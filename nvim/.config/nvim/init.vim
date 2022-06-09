set noswapfile nohlsearch noshowmode
set termguicolors splitright splitbelow
set guicursor= clipboard=unnamedplus signcolumn=no
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set ignorecase smartcase wildignorecase
set cinoptions=l1;(4;:0;m1 statusline=%f:%l:%c\ %m

let mapleader = ' '
let c_syntax_for_h = 1
let c_no_curly_error = 1

function! ClearWhitespace()
    let save = winsaveview()
    keeppatterns %s/\s\+$//e
    keeppatterns %s/\n\+\%$//e
    call winrestview(save)
endfunction

function! Format()
    let path = shellescape(expand("%:p"))

    write
    let save = winsaveview()
    let output = ""

    if &filetype ==# "glos"
        let output = systemlist("./glos -f ".path)
    elseif &filetype ==# "go"
        let output = systemlist("go fmt ".path)
    endif

    silent! bdelete! \*fmt-error\*
    if v:shell_error
        new *fmt-error*
        setlocal buftype=nofile

        call setline(1, output)
        call compile#add_highlights()

        noremap <buffer> <silent> q :close<cr>
        noremap <buffer> <silent> <cr> :call compile#open_file()<cr>

        normal! gg0
    else
        edit
    endif

    call winrestview(save)
endfunction

lua require("ido").setup{render = require("ido.render").vertical}

noremap Q <nop>
noremap K :SigmaMan<cr><c-left>

inoremap <c-k> <c-o>"_D
cnoremap <c-k> <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

noremap <silent> <a-q> :call Format()<cr>

nnoremap <leader>r :%s//gc<left><left><left>
nnoremap <leader>R :s//gc<left><left><left>
vnoremap <leader>r :s//gc<left><left><left>

nnoremap <silent> <c-j> :m .+1<cr>==
nnoremap <silent> <c-k> :m .-2<cr>==
vnoremap <silent> <c-j> :m '>+1<cr>gv=gv
vnoremap <silent> <c-k> :m '<-2<cr>gv=gv

noremap <leader>l :wa<cr>:terminal <up>

noremap <silent> <leader>g :G<cr>
noremap <leader>p :term git push origin main<space>
noremap <leader>u :G remote add origin git@github.com:
noremap <leader>U :G remote set-url origin git@github.com:

noremap <silent> <leader>w :w<cr>
noremap <silent> <leader>d :bd!<cr>
noremap <silent> <leader>t :Snippet<cr><cr>

noremap <silent> <leader>h :Recompile<cr>
noremap <silent> <leader>H :Compile<cr>
noremap <silent> <leader>j :CompileNext<cr>
noremap <silent> <leader>k :CompilePrev<cr>

noremap <silent> <leader>f :Ido std.browse<cr>
noremap <silent> <leader>. :Ido std.git_files<cr>
noremap <silent> <leader>, :Ido std.buffer<cr>
noremap <silent> <leader>v :Ido std.filetypes<cr>

augroup shoumodip
    autocmd!
    autocmd BufRead,BufNewFile *.fasm setlocal filetype=fasm
    autocmd FileType c,cpp setlocal commentstring=//%s
    autocmd FileType go setlocal noexpandtab
    autocmd BufWritePre * call ClearWhitespace()
augroup END

silent! colorscheme minimal
