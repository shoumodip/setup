let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(plug_path)
    silent execute '!curl -fLo ' . plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugins')
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'shoumodip/fm.vim'
Plug 'shoumodip/compile.nvim'

Plug '~/code/ido-nvim/ido.nvim'
Plug 'ido-nvim/tag.nvim'
Plug 'ido-nvim/project.nvim'

Plug 'shoumodip/vim-man'
Plug 'shoumodip/vim-snippet'
Plug 'shoumodip/vim-cheatsheet'
call plug#end()

set noswapfile nohlsearch noshowmode
set termguicolors splitright splitbelow
set guicursor= clipboard=unnamedplus
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set ignorecase smartcase wildignorecase
set cinoptions=l1;(0;:0 statusline=%f:%l:%c\ %m

silent! colorscheme minimal

let mapleader = ' '
let c_syntax_for_h = 1
let c_no_curly_error = 1

tnoremap <esc> <c-\><c-n>

noremap Q gq
noremap <silent> <c-l> :cclose<cr><c-l>

nnoremap <leader>r :%s//gc<left><left><left>
vnoremap <leader>r :s//gc<left><left><left>

nnoremap <silent> <c-j> :m .+1<cr>==
nnoremap <silent> <c-k> :m .-2<cr>==
vnoremap <silent> <c-j> :m '>+1<cr>gv=gv
vnoremap <silent> <c-k> :m '<-2<cr>gv=gv

noremap K :SigmaMan<cr><c-left>
noremap <leader>u :G remote add origin git@github.com:
noremap <leader>p :term git push origin main
noremap <leader>l :wa<cr>:terminal <up>

noremap <silent> <leader>v :G<cr>
noremap <silent> <leader>w :w<cr>
noremap <silent> <leader>d :bd!<cr>
noremap <silent> <leader>q :Cheatsheet<cr><cr>
noremap <silent> <leader>t :Snippet<cr><cr>

function! ClearWhitespace()
    let save = winsaveview()
    keeppatterns %s/\s\+$//e
    keeppatterns %s/\n\+\%$//e
    call winrestview(save)
endfunction

noremap <silent> <leader>h :Recompile<cr>
noremap <silent> <leader>H :Compile<cr>
noremap <silent> <leader>j :CompileNext<cr>
noremap <silent> <leader>k :CompilePrev<cr>

augroup shoumodip
    autocmd!
    autocmd FileType c,cpp setlocal commentstring=//%s
    autocmd FileType go setlocal noexpandtab
    autocmd FileType fasm setlocal commentstring=;%s
    autocmd BufEnter *.fasm setlocal filetype=fasm
    autocmd FileType fzf tnoremap <buffer> <esc> <c-c>
    autocmd BufWritePre * call ClearWhitespace()
augroup END

noremap <silent> <leader>b :Ido std.browse<cr>

noremap <silent> <leader>g. :Ido std.git_files<cr>
noremap <silent> <leader>g, :Ido std.buffer<cr>

noremap <silent> <leader>gf :Ido std.find_files<cr>
noremap <silent> <leader>gc :Ido std.filetypes<cr>

noremap <silent> <leader>o :Ido project.open<cr>
noremap <silent> <leader>. :Ido project.find_files<cr>
noremap <silent> <leader>, :Ido project.buffer<cr>

noremap <silent> <leader>sf :Ido tag.functions<cr>
noremap <silent> <leader>sv :Ido tag.variables<cr>
noremap <silent> <leader>st :Ido tag.types<cr>
noremap <silent> <leader>se :Ido tag.enums<cr>
noremap <silent> <leader>sd :Ido tag.defines<cr>

lua require("ido").setup{render = require("ido.render").vertical}
