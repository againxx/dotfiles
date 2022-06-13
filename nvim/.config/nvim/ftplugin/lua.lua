require("xx.utils").set_indent(2)

require("pretty-fold").ft_setup("lua", {
  fill_char = "·",
  matchup_patterns = {
    { "^%s*do$", "end" }, -- do ... end blocks
    { "^%s*if", "end" }, -- if ... end
    { "^%s*for", "end" }, -- for
    { "function%s*%(", "end" }, -- 'function( or 'function (''
    { "{", "}" },
    { "%(", ")" }, -- % to escape lua pattern char
    { "%[", "]" }, -- % to escape lua pattern char
  },
})
