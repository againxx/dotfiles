local Color, colors, Group, groups, styles = require("colorbuddy").setup()

Color.new('bg',              '#1F2430')
Color.new('fg',              '#CBCCC6')
Color.new('fg_idle',         '#707A8C')
Color.new('comment',         '#5C6773')
Color.new('markup',          '#F28779')
Color.new('constant',        '#D4BFFF')
Color.new('operator',        '#F29E74')
Color.new('entity',          '#73D0FF')
Color.new('entity_dark',     '#399EE6')
Color.new('tag',             '#5CCFE6')
Color.new('field',           '#B695E0')
Color.new('constant_dark',   '#A37ACC')
Color.new('regexp',          '#95E6CB')
Color.new('string',          '#BAE67E')
Color.new('string_dark',     '#86B300')
Color.new('namespace',       '#9ac732')
Color.new('func',            '#FFD580')
Color.new('special',         '#FFE6B3')
Color.new('keyword',         '#FFA759')
Color.new('error',           '#FF3333')
Color.new('accent',          '#FFCC66')
Color.new('panel',           '#232834')
Color.new('guide',           '#323A4C')
Color.new('line',            '#191E2A')
Color.new('longline',        '#371F1C')
Color.new('selection',       '#33415E')
Color.new('added',           '#A6CC70')
Color.new('modified',        '#77A8D9')
Color.new('removed',         '#F27983')
Color.new('border',          '#101521')
Color.new('shadow',          '#141925')
Color.new('selection_light', '#42547a')

Group.new('Normal',          colors.fg,              colors.none,      styles.NONE)
Group.new('SignColumn',      colors.none,            colors.none,      styles.NONE)
Group.new('CursorLineNr',    colors.accent,          colors.none,      styles.NONE)
Group.new('ColorColumn',     colors.none,            colors.line,      styles.NONE)
-- Conceal, Cursor, CursorIM
Group.new('CursorColumn',    colors.none,            colors.line,      styles.NONE)
Group.new('CursorLine',      colors.none,            colors.line,      styles.NONE)
Group.new('LineNr',          colors.selection_light, colors.none,      styles.NONE)

Group.new('Directory',       colors.fg_idle,         colors.none,      styles.NONE)
Group.new('DiffAdd',         colors.added,           colors.panel,     styles.NONE)
Group.new('DiffChange',      colors.modified,        colors.panel,     styles.NONE)
Group.new('DiffText',        colors.fg,              colors.panel,     styles.NONE)
Group.new('ErrorMsg',        colors.fg,              colors.error,     styles.standout)
Group.new('VertSplit',       colors.bg,              colors.none,      styles.NONE)
Group.new('Folded',          colors.fg_idle,         colors.panel,     styles.NONE)
Group.new('FoldColumn',      colors.none,            colors.panel,     styles.NONE)
-- Incsearch

Group.new('MatchParen',      colors.fg,              colors.bg,        styles.underline)
Group.new('ModeMsg',         colors.string,          colors.none,      styles.NONE)
Group.new('MoreMsg',         colors.string,          colors.none,      styles.NONE)
Group.new('NonText',         colors.guide,           colors.none,      styles.NONE)
Group.new('Pmenu',           colors.fg,              colors.selection, styles.NONE)
Group.new('PmenuSel',        colors.fg,              colors.selection, styles.reverse)
-- PmenuSbar
-- PmenuThumb
Group.new('Question',        colors.string,          colors.none,      styles.NONE)
Group.new('Search',          colors.bg,              colors.constant,  styles.NONE)
Group.new('SpecialKey',      colors.selection,       colors.none,      styles.NONE)
Group.new('SpellCap',        colors.tag,             colors.none,      styles.underline)
Group.new('SpellLocal',      colors.keyword,         colors.none,      styles.underline)
Group.new('SpellBad',        colors.error,           colors.none,      styles.underline)
Group.new('SpellRare',       colors.regexp,          colors.none,      styles.underline)
Group.new('StatusLine',      colors.fg,              colors.panel,     styles.NONE)
Group.new('StatusLineNC',    colors.fg_idle,         colors.panel,     styles.NONE)
Group.new('WildMenu',        colors.selection,       colors.markup,    styles.NONE)
Group.new('TabLine',         colors.fg,              colors.panel,     styles.reverse)
-- TabLineFill
-- TabLineSel
Group.new('Title',           colors.keyword,         colors.none,      styles.NONE)
Group.new('Visual',          colors.none,            colors.selection, styles.NONE)
-- VisualNos
Group.new('WarningMsg',      colors.error,           colors.none,      styles.NONE)
Group.new('LongLineWarning', colors.none,            colors.longline,  styles.underline)
-- WildMenu

-- Generic Syntax Highlighting: (see :help group-name)
Group.new('Comment',         colors.comment,         colors.none,      styles.italic)

Group.new('Constant',        colors.constant,        colors.none,      styles.NONE)
Group.new('String',          colors.string,          colors.none,      styles.NONE)
--    Character
--    Number
--    Boolean
--    Float

Group.new('Identifier', colors.tag,      colors.none, styles.NONE)
Group.new('Function',   colors.func,     colors.none, styles.NONE)
Group.new('Statement',  colors.keyword,  colors.none, styles.bold + styles.italic)
--    Conditional
--    Repeat
--    Label
Group.new('Operator',   colors.operator, colors.none, styles.NONE)
--    Keyword
--    Exception

Group.new('PreProc',    colors.special,  colors.none, styles.NONE)
--    Include
--    Define
--    Macro
--    PreCondit

Group.new('Type',            colors.entity,    colors.none,        styles.NONE)
--    StorageClass
Group.new('Structure',       colors.special,   colors.none,        styles.NONE)
--    Typedef

Group.new('Special',         colors.special,   colors.none,        styles.NONE)
--    SpecialChar
--    Tag
--    Delimiter
--    SpecialComment
--    Debug

Group.new('Underlined',      colors.tag,       colors.none,        styles.underline)
Group.new('Ignore',          colors.none,      colors.none,        styles.NONE)
Group.new('Error',           colors.fg,        colors.error,       styles.NONE)
Group.new('Todo',            colors.markup,    colors.none,        styles.NONE)

-- Quickfix window highlighting
-- exe "hi! qfLineNr"        .s:fg_keyword   .s:bg_none        .s:fmt_none
-- exe "hi! qfError"         .s:fg_removed   .s:bg_none        .s:fmt_bold
-- exe "hi! qfWarning"       .s:fg_function  .s:bg_none        .s:fmt_bold
--    qfFileName
--    qfLineNr

-- exe "hi! Conceal"           .s:fg_guide   .s:bg_none        .s:fmt_none
-- exe "hi! CursorLineConceal" .s:fg_guide   .s:bg_line        .s:fmt_none
-- exe "hi! Whitespace"        .s:fg_border  .s:bg_none        .s:fmt_none

-- exe "hi! Constructor"       .s:fg_regexp     .s:bg_none        .s:fmt_none
-- exe "hi! Field"             .s:fg_field      .s:bg_none        .s:fmt_none
-- exe "hi! Namespace"         .s:fg_namespace  .s:bg_none        .s:fmt_none
-- exe "hi! Parameter"         .s:fg_markup     .s:bg_none        .s:fmt_none
