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
highlight! Folded       guifg=#83a598 guibg=#3c3836 gui=none
highlight! Underlined   guifg=#83a598 guibg=none    gui=underline
highlight! WarningMsg   guifg=#cc8c3c guibg=none    gui=bold
highlight! PmenuSel     guifg=#282828 guibg=#83a598 gui=none
highlight! LineNr       guifg=#928374 guibg=none    gui=none

highlight! Statement    guifg=#fb4934 guibg=none    gui=none
highlight! String       guifg=#b8bb26 guibg=none    gui=none
highlight! Comment      guifg=#928374 guibg=none    gui=none
highlight! Special      guifg=#83a598 guibg=none    gui=none
highlight! PreProc      guifg=#8ec07c guibg=none    gui=none

highlight! NonText      guifg=#282828 guibg=none    gui=none
highlight! Question     guifg=#fe8019 guibg=none    gui=bold
highlight! DiffAdd      guifg=#b8bb26 guibg=none    gui=none
highlight! DiffDelete   guifg=#fb4934 guibg=none    gui=none
highlight! Search       guifg=#d79921 guibg=none    gui=bold

highlight! link ErrorMsg     Error
highlight! link IncSearch    StatusLine
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
highlight! link QuickFixLine CursorLine
highlight! link CursorLineNr LineNr
