highlight clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "minimal"

highlight! Cursor       guifg=none    guibg=none    gui=reverse
highlight! Error        guifg=#fb4934 guibg=none    gui=bold
highlight! Todo         guifg=#fb4934 guibg=none    gui=none
highlight! StatusLine   guifg=none    guibg=#504945 gui=none
highlight! StatusLineNC guifg=none    guibg=#3c3836 gui=none
highlight! VertSplit    guifg=#504945 guibg=none    gui=none
highlight! Visual       guifg=none    guibg=#504945 gui=none
highlight! Folded       guifg=#cc8c3c guibg=#3c3836 gui=none
highlight! Underlined   guifg=#95a99f guibg=none    gui=underline
highlight! WarningMsg   guifg=#cc8c3c guibg=none    gui=bold
highlight! PmenuSel     guifg=#93b936 guibg=#282828 gui=none
highlight! LineNr       guifg=#928374 guibg=none    gui=none

highlight! Statement    guifg=#d79921 guibg=none    gui=bold
highlight! String       guifg=#93b936 guibg=none    gui=none
highlight! Comment      guifg=#cc8c3c guibg=none    gui=none
highlight! Special      guifg=#95a99f guibg=none    gui=none
highlight! PreProc      guifg=#95a99f guibg=none    gui=none

highlight! NonText      guifg=#282828 guibg=none    gui=none
highlight! Question     guifg=#fe8019 guibg=none    gui=bold
highlight! DiffAdd      guifg=#b8bb26 guibg=none    gui=none
highlight! DiffDelete   guifg=#fb4934 guibg=none    gui=none

highlight! link ErrorMsg     Error
highlight! link IncSearch    StatusLine
highlight! link Search       IncSearch
highlight! link MoreMsg      Question
highlight! link SpecialKey   NonText
highlight! link MatchParen   Visual
highlight! link Pmenu        StatusLineNC
highlight! link PmenuSbar    Pmenu
highlight! link PmenuThumb   Pmenu
highlight! link CursorLine   StatusLineNC
highlight! link ColorColumn  Visual

highlight! link Character    String
highlight! link SpecialChar  String
highlight! link Constant     Normal
highlight! link Type         Normal
highlight! link Identifier   Special
highlight! link Structure    Statement
highlight! link StorageClass Statement

highlight! link Title        Special
highlight! link Directory    Special

highlight! link diffAdded    DiffAdd
highlight! link diffRemoved  DiffDelete
highlight! link SignColumn   Normal

highlight! link DiagnosticError ErrorMsg
highlight! link DiagnosticWarn  WarningMsg
