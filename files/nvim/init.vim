let plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(plug_path)
    silent execute '!curl -fLo ' . plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugins')
Plug 'morhetz/gruvbox'
Plug 'godlygeek/tabular'
Plug 'airblade/vim-rooter'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-rsi'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'shoumodip/vim-snippet'
Plug 'shoumodip/vim-man'
Plug 'shoumodip/fm.vim'
call plug#end()

silent! colorscheme gruvbox

set noswapfile nohlsearch
set number relativenumber termguicolors
set splitright splitbelow
set mouse=a guicursor= clipboard=unnamedplus
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set ignorecase smartcase wildignorecase
set cinoptions=l1;(0 exrc secure

let mapleader = ' '
let c_no_curly_error = 1
let c_syntax_for_h = 1

let g:asyncrun_open = 15

tnoremap <esc> <c-\><c-n>

noremap Q gq
noremap <c-l> :cclose<cr><c-l>
noremap <leader>r :%s//g<left><left>
noremap <leader>R :s//g<left><left>
noremap <leader>s :%S//g<left><left>
noremap <leader>S :S//g<left><left>

nnoremap <silent> <c-j> :m .+1<cr>==
nnoremap <silent> <c-k> :m .-2<cr>==
vnoremap <silent> <c-j> :m '>+1<cr>gv=gv
vnoremap <silent> <c-k> :m '<-2<cr>gv=gv

noremap <leader>u :G remote add origin git@github.com:shoumodip/
noremap <leader>p :term git push origin main
noremap <silent> <leader>g :G<cr>

noremap <leader>a :Tabularize /

noremap <silent> <leader>w :w<cr>
noremap <silent> <leader>d :bd!<cr>

noremap <silent> <leader>. :GFiles --cached --others --exclude-standard<cr>
noremap <silent> <leader>, :Buffers<cr>
noremap <silent> <leader>n :Lines<cr>
noremap <silent> <leader>h :Helptags<cr>
noremap <silent> <leader>v :Filetypes<cr>
noremap <silent> <leader>c :Commits<cr>

command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number -- '.shellescape(<q-args>), 0,
            \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

noremap <silent> <leader>f :GGrep<cr>

noremap <silent> <leader>T :Snippet<cr><cr>
noremap K :SigmaMan<cr><c-left>

function! FixCode()
    let save = winsaveview()
    keeppatterns %s/\s\+$//e
    keeppatterns %s/\n\+\%$//e
    normal! gg=G
    call winrestview(save)
endfunction

noremap <silent> <leader>e :call FixCode()<cr>:w<cr>

function! ProjectRun(build, overwrite)
    silent! wa
    let command = ""

    if a:build
        if !exists("g:project_build_cmd") || g:project_build_cmd == "" || a:overwrite
            let input = input("Build: ")

            if input == ""
                return
            endif

            let g:project_build_cmd = input
        endif

        let command = g:project_build_cmd
    else
        if !exists("g:project_test_cmd") || g:project_test_cmd == "" || a:overwrite
            let input = input("Test: ")

            if input == ""
                return
            endif

            let g:project_test_cmd = input
        endif

        let command = g:project_test_cmd
    endif

    execute "AsyncRun " . command
endfunction

noremap <silent> <leader>h :call ProjectRun(1, 0)<cr>
noremap <silent> <leader>l :call ProjectRun(0, 0)<cr>
noremap <silent> <leader>H :call ProjectRun(1, 1)<cr>
noremap <silent> <leader>L :call ProjectRun(0, 1)<cr>

noremap <silent> <leader>j :cn<bar>copen<cr>zt<c-w><c-p>
noremap <silent> <leader>k :cp<bar>copen<cr>zt<c-w><c-p>

noremap <leader>; :wa<cr>:AsyncRun <up>
noremap <leader>: :wa<cr>:terminal <up>

augroup shoumodip
    autocmd!
    autocmd FileType c,cpp setlocal commentstring=//%s
    autocmd FileType go setlocal noexpandtab
    autocmd FileType fasm setlocal commentstring=;%s
    autocmd BufEnter *.fasm setlocal filetype=fasm
    autocmd BufEnter *.nasm setlocal filetype=nasm
    autocmd FileType fzf tnoremap <buffer> <esc> <c-c>
augroup END
