scriptencoding utf-8
syntax match VimwikiTodoCheckbox "- \[ \]"  conceal cchar=○ containedin=VimwikiListTodo
syntax match VimwikiTodoCheckbox "- \[\.\]" conceal cchar=◔ containedin=VimwikiListTodo
syntax match VimwikiTodoCheckbox "- \[o\]"  conceal cchar=◑ containedin=VimwikiListTodo
syntax match VimwikiTodoCheckbox "- \[O\]"  conceal cchar=◕ containedin=VimwikiListTodo
syntax match VimwikiTodoCheckbox "- \[X\]"  conceal cchar=✔ containedin=VimwikiListTodo
syntax match VimwikiTodoCheckbox "- \[-\]"  conceal cchar=✗ containedin=VimwikiListTodo
