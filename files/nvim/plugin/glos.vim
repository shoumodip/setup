function! GlosSyntax()
    setlocal filetype=go " For the indentation
    setlocal expandtab
    setlocal filetype=glos
    setlocal commentstring=#%s
    setlocal suffixesadd=.glos

    syntax clear
    syntax keyword Keyword if else while match as fn var use enum const break return struct
    syntax keyword Special self argc argv syscall panic sizeof
    syntax keyword Constant true false
    syntax keyword Type u8 u64 bool

    syntax region  String start='"' skip='\\\\\|\\"' end='"'
    syntax match   Character "'\(.\|\\[nrt0\\]\)'"
    syntax match   Number "\<[0-9_]\+\>"

    syntax match Comment '#.*'
endfunction

augroup glos
    autocmd!
    autocmd BufRead,BufNewFile *.glos call GlosSyntax()
augroup END
