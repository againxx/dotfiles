use async_trait::async_trait;
use nvim_rs::{compat::tokio::Compat, create::tokio as create, Handler, Neovim, Value};
use std::{sync::{Arc, Mutex}, error::Error};
use tokio::io::Stdout;

use cmp_zi::DictWithTranslation;

#[derive(Clone)]
struct NeovimHandler {
    dict: Arc<Mutex<Option<DictWithTranslation>>>,
}

#[async_trait]
impl Handler for NeovimHandler {
    type Writer = Compat<Stdout>;

    async fn handle_request(
        &self,
        name: String,
        args: Vec<nvim_rs::Value>,
        _neovim: Neovim<Self::Writer>,
    ) -> Result<nvim_rs::Value, nvim_rs::Value> {
        match name.as_ref() {
            "init" => {
                let dict = self.dict.clone();
                tokio::spawn(async move {
                    let reading_result =
                        cmp_zi::read_ecdict(args.first().unwrap().as_str().unwrap()).await;
                    match reading_result {
                        Ok(words) => *dict.lock().unwrap() = Some(DictWithTranslation::new(words)),
                        Err(e) => eprintln!("Error read ecdict '{}'", e),
                    }
                });
                Ok(Value::Nil)
            }
            "look" => match self.dict.lock().unwrap().as_ref() {
                Some(dict) => {
                    let result = dict.look(args.first().unwrap().as_str().unwrap());
                    let mut response = Vec::with_capacity(result.len());
                    for word in result {
                        response.push(Value::from(vec![
                            Value::from(word.word),
                            Value::from(word.phonetic),
                            Value::from(word.definition),
                            Value::from(word.translation),
                            Value::from(word.pos),
                        ]))
                    }
                    Ok(Value::from(response))
                }
                None => Ok(Value::Nil),
            },
            _ => Ok(Value::Nil),
        }
    }
}

#[tokio::main]
async fn main() {
    let handler = NeovimHandler {
        dict: Arc::new(Mutex::new(None)),
    };
    let (nvim, io_handler) = create::new_parent(handler).await;
    match io_handler.await {
        Err(joinerr) => eprintln!("Error joining IO loop: '{}'", joinerr),
        Ok(Err(err)) => {
            if !err.is_reader_error() {
                nvim
                    .err_writeln(&format!("Error: '{}'", err))
                    .await
                    .unwrap_or_else(|e| {
                        eprintln!("Well, dang... '{}'", e);
                    });
            }

            if !err.is_channel_closed() {
                eprintln!("Error: '{}'", err);
                let mut source = err.source();
                while let Some(e) = source {
                    eprintln!("Caused by: '{}'", e);
                    source = e.source();
                }
            }
        }
        Ok(Ok(_)) => {}
    }
}
