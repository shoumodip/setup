highlight clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "gruber"

highlight! Cursor       guifg=none    guibg=none    gui=reverse
highlight! Visual       guifg=none    guibg=#282828 gui=none
highlight! Underlined   guifg=none    guibg=none    gui=underline

highlight! Folded       guifg=#73c936 guibg=#282828 gui=none
highlight! LineNr       guifg=#95a99f guibg=none    gui=none
highlight! VertSplit    guifg=#282828 guibg=none    gui=none
highlight! StatusLine   guifg=none    guibg=#282828 gui=none
highlight! StatusLineNC guifg=#95a99f guibg=#282828 gui=none
highlight! EndOfBuffer  guifg=#181818 guibg=none    gui=none

highlight! Question     guifg=#96a6c8 guibg=none    gui=bold
highlight! PmenuSel     guifg=#73c936 guibg=#1d1d1d gui=none
highlight! ErrorMsg     guifg=#f43841 guibg=none    gui=bold
highlight! WarningMsg   guifg=#ffdd33 guibg=none    gui=bold

highlight! String       guifg=#73c936 guibg=none    gui=none
highlight! Comment      guifg=#cc8c3c guibg=none    gui=none
highlight! PreProc      guifg=#95a99f guibg=none    gui=none
highlight! Special      guifg=#ddbb11 guibg=none    gui=none
highlight! Statement    guifg=#ddbb11 guibg=none    gui=bold

highlight! DiffAdd      guifg=#73c936 guibg=none    gui=none
highlight! DiffDelete   guifg=#f43841 guibg=none    gui=none

highlight! link NonText    Normal
highlight! link SpecialKey Normal

highlight! link Todo       ErrorMsg
highlight! link Error      ErrorMsg
highlight! link Search     Visual
highlight! link MoreMsg    Question
highlight! link IncSearch  Search
highlight! link MatchParen   Visual

highlight! link Pmenu        StatusLine
highlight! link PmenuSbar    Pmenu
highlight! link PmenuThumb   Pmenu
highlight! link CursorLine   StatusLine
highlight! link ColorColumn  Visual
highlight! link QuickFixLine CursorLine
highlight! link CursorLineNr LineNr

highlight! link Type         Normal
highlight! link Constant     Normal
highlight! link Delimiter    Normal
highlight! link Character    String
highlight! link SpecialChar  String
highlight! link Identifier   Special
highlight! link Structure    Statement
highlight! link StorageClass Statement

highlight! link Title        Question
highlight! link Directory    Special

highlight! link diffAdded    DiffAdd
highlight! link diffRemoved  DiffDelete
highlight! link markdownCode PreProc
