set noswapfile nohlsearch noshowmode
set termguicolors splitright splitbelow
set guicursor= clipboard=unnamedplus signcolumn=no
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set ignorecase smartcase wildignorecase
set cinoptions=l1;(0,W4;:0;m1

let mapleader = ' '
let c_syntax_for_h = 1
let c_no_curly_error = 1

noremap Q <nop>

nnoremap <leader>r :%s//gc<left><left><left>
nnoremap <leader>R :s//gc<left><left><left>
vnoremap <leader>r :s//gc<left><left><left>

nnoremap <leader>s :%S//gc<left><left><left>
nnoremap <leader>S :S//gc<left><left><left>
vnoremap <leader>s :S//gc<left><left><left>

nnoremap <silent> <c-j> :m .+1<cr>==
nnoremap <silent> <c-k> :m .-2<cr>==
vnoremap <silent> <c-j> :m '>+1<cr>gv=gv
vnoremap <silent> <c-k> :m '<-2<cr>gv=gv

noremap <silent> <leader>H :Compile<cr>
noremap <silent> <leader>h :Recompile<cr>
noremap <silent> <leader>j :CompileNext<cr>
noremap <silent> <leader>k :CompilePrev<cr>

noremap <silent> <leader>g :G<cr>
noremap <leader>p :term git push origin main<space>
noremap <leader>u :G remote add origin git@github.com:
noremap <leader>U :G remote set-url origin git@github.com:

noremap <silent> <leader>w :w<cr>
noremap <silent> <leader>d :bd!<cr>
noremap <silent> <leader>t :Snippet<cr><cr>

noremap <silent> <leader>f :Ido std.browse<cr>
noremap <silent> <leader>, :Ido std.buffer<cr>
noremap <silent> <leader>. :Ido std.git_files<cr>
noremap <silent> <leader>v :Ido std.filetypes<cr>

function! ClearWhitespace()
    let save = winsaveview()
    keeppatterns %s/\s\+$//e
    keeppatterns %s/\n\+\%$//e
    call winrestview(save)
endfunction

augroup shoumodip
    autocmd!
    autocmd FileType c,cpp setlocal commentstring=//%s
    autocmd FileType go setlocal noexpandtab
    autocmd BufWritePre * call ClearWhitespace()
augroup END

colorscheme minimal
lua require("ido").setup{render = require("ido.render").vertical}
