use std::{io, path};
use tokio::fs;
use tokio::io::BufReader;
use tokio_stream::StreamExt;

#[allow(dead_code)]
const WORDS_PATH: &'static str = "/usr/share/dict/words";

#[derive(Debug, Clone)]
pub struct WordDef {
    pub word: String,
    pub phonetic: String,
    pub definition: String,
    pub translation: String,
    pub pos: String,
}

#[derive(Clone)]
pub struct DictWithTranslation {
    words: Vec<WordDef>,
}

impl DictWithTranslation {
    pub fn new(words: Vec<WordDef>) -> Self {
        Self { words }
    }

    pub fn look(&self, query: &str) -> Vec<WordDef> {
        let pos = self.words.binary_search_by(|word| word.word.as_str().cmp(&query));
        let mut cur = match pos {
            Ok(index) => index,
            Err(index) => index,
        };
        let mut result = Vec::new();
        while self.words[cur].word.starts_with(query) {
            result.push(self.words[cur].clone());
            cur += 1;
        }
        result
    }
}

pub async fn read_ecdict(path: impl AsRef<path::Path>) -> io::Result<Vec<WordDef>> {
    let ecdict_file = fs::File::open(path).await?;
    let mut reader = csv_async::AsyncReader::from_reader(BufReader::new(ecdict_file));
    let mut records = reader.records();
    let mut result = Vec::with_capacity(770612);

    while let Some(record) = records.next().await {
        let record = record?;
        result.push(
            WordDef {
                word: record.get(0).unwrap().to_lowercase(),
                phonetic: record.get(1).unwrap_or("").to_string(),
                definition: record.get(2).unwrap_or("").to_string(),
                translation: record.get(3).unwrap_or("").to_string(),
                pos: record.get(4).unwrap_or("").to_string(),
            },
        );
    }
    Ok(result)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_binary_search() {
        let words = read_ecdict("/home/ustc1314/.local/share/nvim/cmp-zi/ecdict.csv").await.unwrap();
        let dict = DictWithTranslation::new(words);
        let result = dict.look("tes");
        assert_eq!(result.len(), 455);
    }
}
