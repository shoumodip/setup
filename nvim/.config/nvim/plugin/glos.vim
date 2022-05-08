function! GlosSyntax()
    setlocal smartindent
    setlocal filetype=glos
    setlocal commentstring=;%s

    syntax clear
    syntax keyword Keyword if else while for as let import const return struct match break continue sizeof
    syntax keyword Special print eprint fprint syscall assert
    syntax keyword Constant true false argc argv
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
