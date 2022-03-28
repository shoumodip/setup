function! GlosSyntax()
    setlocal filetype=go " For the indentation
    setlocal expandtab
    setlocal filetype=glos
    setlocal commentstring=#%s
    setlocal suffixesadd=.glos

    syntax clear
    syntax keyword Keyword if else while for as let import const return struct
    syntax keyword Special syscall assert sizeof
    syntax keyword Constant true false
    syntax keyword Type char uint bool

    syntax region  String start='"' skip='\\\\\|\\"' end='"'
    syntax match   Character "'\(.\|\\[nrt0\\]\)'"
    syntax match   Number "\<[0-9_]\+\>"

    " The syscalls
    syntax keyword Function exit write

    syntax match Comment '#.*'
endfunction

augroup glos
    autocmd!
    autocmd BufRead,BufNewFile *.glos call GlosSyntax()
augroup END
