function! GlosSyntax()
    setlocal smartindent
    setlocal filetype=glos
    setlocal commentstring=;%s
    setlocal suffixesadd=.glos

    syntax clear
    syntax keyword Keyword if else while for as fn let import const return struct match break continue sizeof
    syntax keyword Special syscall assert argc argv
    syntax keyword Constant true false
    syntax keyword Type char uint bool
    syntax keyword Todo TODO FIXME NOTE BUG

    syntax region  String start='"' skip='\\\\\|\\"' end='"'
    syntax match   Character "'\(\\[nrt0'\\]\|[^'\\]\)'"
    syntax match   Number "\<[0-9][0-9_]*\>"

    syntax match Comment ';.*' contains=Todo
endfunction

augroup glos
    autocmd!
    autocmd BufRead,BufNewFile *.glos call GlosSyntax()
augroup end
