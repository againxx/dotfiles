local init = function()
  vim.opt_local.iskeyword:append "92"
  vim.opt_local.conceallevel = 2
  vim.b.coc_additional_keywords = { "\\" }

  if vim.b.match_words then
    vim.b.match_words = vim.b.match_words .. [[,\\begin{\w\+}:\\end{\w\+}]]
  end

  local switch_definitions = [==[
  let b:switch_custom_definitions = [
    {
      '\(|:\=-\+\)\+|': {
        '|\@<=-\(-\=|\)\@!': ':',
        '|\@<=[:-]\=-|\@=': ':-:',
        '\(|-\=\)\@<!-|\@=': ':',
      },
      '\(|:-\+:\)\+|': {
        '|\@<=:': '-'
      },
      '\(|-\+:\)\+|': {
        '|\@<=-': ':',
        ':|\@=': '-'
      },
      '!\@<!\[\([^]]\+\)\](\([^)]\+\))': '\[\[\2|\1\]\]',
      '\[\[\([^]|]\+\)|\([^]]\+\)\]\]': '\[\2\](\1)',
      '\[\[\([^]|]\+\)\]\]': '\[\1\](\1)',
      '^# \(.*\)$': '= \1 =',
      '^## \(.*\)$': '== \1 ==',
      '^### \(.*\)$': '=== \1 ===',
      '^#### \(.*\)$': '==== \1 ====',
      '^##### \(.*\)$': '===== \1 =====',
      '^###### \(.*\)$': '====== \1 ======',
      '^= \(.*\) =$': '# \1',
      '^== \(.*\) ==$': '## \1',
      '^=== \(.*\) ===$': '### \1',
      '^==== \(.*\) ====$': '#### \1',
      '^===== \(.*\) =====$': '##### \1',
      '^====== \(.*\) ======$': '###### \1',
      '{{\([^|]\+\)|\([^|]*\)|style="width:\(\d\+\)px"}}': '!\[\2\](\1 =\3x)',
      '!\[\([^]]*\)\](\([^)]\+\) =\(\d\+\)x)': '{{\2|\1|style="width:\3px"}}',
      '!\[\([^]]*\)\](\([^)]\+\))': '{{\2|\1|style="width:750px"}}',
    },
    ['\\rightarrow', '\\longrightarrow', '\\Rightarrow', '\\Longrightarrow'],
    ['\\leftarrow', '\\longleftarrow', '\\Leftarrow', '\\Longleftarrow'],
    ['\\leftrightarrow', '\\longleftrightarrow', '\\Leftrightarrow', '\\Longleftrightarrow', '\\iff'],
    ['\\hat', '\\tilde', '\\widehat', '\\widetilde', '\\overline', '\\bar'],
    ['\\ldots', '\\cdots'],
    ['- [ ]', '- [X]']
  ]
]==]

  vim.cmd(switch_definitions:gsub("\n", ""))

  if vim.g.colors_name == "ayu" then
    vim.cmd [[hi! link Conceal Function]]
    vim.cmd [[hi! link TaskwikiTaskPriority CocErrorSign]]
  end

  -- Table-mode
  vim.g.table_mode_motion_left_map = "[t"
  vim.g.table_mode_motion_right_map = "]t"
  vim.g.table_mode_motion_up_map = "[T"
  vim.g.table_mode_motion_down_map = "]T"
  vim.g.table_mode_corner = "|"
  vim.g.table_mode_map_prefix = "<localleader>t"
  vim.g.table_mode_tableize_d_map = "<localleader>ta"

  local success, wk = pcall(require, "which-key")
  if not success then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()

  wk.add {
    mode = { "i" },
    { ";;", ";", buffer = bufnr, desc = "Literal ;" },
    { ";T", "*<Space>[<Space>]<Space>", buffer = bufnr, desc = "Task list" },
    { ";c", "``<Space><++><C-o>F`", buffer = bufnr, desc = "Emphasis" },
    { ";e", "<Esc><Cmd>call search('\\s\\?<++>')<CR>\"_cf>", buffer = bufnr, desc = "Go to end" },
    { ";m", "$$<++><C-o>F$", buffer = bufnr, desc = "Inline math" },
    { ";n", "<Esc>A<Space>\\\\<CR>", buffer = bufnr, desc = "New line in math block" },
    { ";o", "<Esc><Cmd>call search('\\s\\?<++>')<CR>\"_cf><CR>", buffer = bufnr, desc = "Go to new line" },
    { ";q", "<Esc><Cmd>call search('[)}\\]]')<CR>a", buffer = bufnr, desc = "Go out of )}]" },
    { ";t", "-<Space>[<Space>]<Space>", buffer = bufnr, desc = "Check list" },
    { ";w", "<Esc><Cmd>call search('<++>')<CR>\"_cf>", buffer = bufnr, desc = "Go to next word" },
    -- when packer first load TableMode the TableModeEnable command does not have effect,
    -- the cursor will also jump to some strange place, use `. to jump to the original place
    { ";|", "<cmd>TableModeEnable<cr><cmd>TableModeEnable<cr><c-o>`.| ", buffer = bufnr, desc = "Toggle table mode" },
  }

  wk.add {
    { "<space><space>", '/<++><cr>:nohlsearch<cr>"_c4l', buffer = bufnr, desc = "Go to next anchor" },
    { "[T", buffer = bufnr, desc = "Go to up table cell" },
    { "[t", buffer = bufnr, desc = "Go to left table cell" },
    { "]T", buffer = bufnr, desc = "Go to down table cell" },
    { "]t", buffer = bufnr, desc = "Go to right table cell" },
  }

  wk.add {
    { "<localleader>t", buffer = bufnr, group = "table" },
    { "<localleader>t?", buffer = bufnr, desc = "Cell representation" },
    { "<localleader>ta", buffer = bufnr, desc = "Tableize" },
    { "<localleader>tdc", buffer = bufnr, desc = "Delete column" },
    { "<localleader>tdd", buffer = bufnr, desc = "Delete row" },
    { "<localleader>tm", "<cmd>TableModeToggle<cr>", buffer = bufnr, desc = "Toggle table mode" },
    { "<localleader>tr", buffer = bufnr, desc = "Table realign" },
  }
end

return { init = init }
