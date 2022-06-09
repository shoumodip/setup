function! GlosSyntax()
    setlocal cindent
    setlocal filetype=glos
    setlocal commentstring=//%s
    setlocal suffixesadd=.glos

    syntax clear
    syntax keyword Keyword as in var proc enum const struct if else case default while for break return import assert syscall
    syntax keyword Constant true false
    syntax keyword Type int bool char str
    syntax keyword Todo TODO FIXME NOTE BUG

    syntax region  String start='"' skip='\\\\\|\\"' end='"'
    syntax match   Character "'\(\\[nrt0'\\]\|[^'\\]\)'"
    syntax match   Number "\<[0-9][0-9_]*\>"

    syntax match Comment '//.*' contains=Todo
endfunction

augroup glos
    autocmd!
    autocmd BufRead,BufNewFile *.glos call GlosSyntax()
augroup end
