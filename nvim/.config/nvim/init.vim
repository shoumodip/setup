set noswapfile nohlsearch noshowmode
set termguicolors splitright splitbelow
set guicursor= clipboard=unnamedplus
set expandtab tabstop=4 softtabstop=4 shiftwidth=4
set ignorecase smartcase wildignorecase
set cinoptions=l1;(0;:0 statusline=%f:%l:%c\ %m

let mapleader = ' '
let c_syntax_for_h = 1
let c_no_curly_error = 1

function! GotoTerm(number)
    if s:terminals[a:number] && buflisted(s:terminals[a:number])
        execute "buffer " . s:terminals[a:number]
    else
        terminal
        execute 'tnoremap <buffer> <a-' . (a:number + 1) . '> <c-\><c-n><c-o>'
        let s:terminals[a:number] = bufnr()
    endif

    startinsert
endfunction

function! GotoTermSetup(count)
    let s:terminals = repeat([0], a:count)
    for i in range(a:count)
        execute 'noremap <silent> <a-' . (i + 1) . '> :call GotoTerm(' . i . ')<cr>'
    endfor
endfunction

function! ClearWhitespace()
    let save = winsaveview()
    keeppatterns %s/\s\+$//e
    keeppatterns %s/\n\+\%$//e
    call winrestview(save)
endfunction

call GotoTermSetup(4)
lua require("ido").setup{render = require("ido.render").vertical}

noremap Q <nop>
noremap K :SigmaMan<cr><c-left>

nnoremap <leader>r :%s//gc<left><left><left>
vnoremap <leader>r :s//gc<left><left><left>

nnoremap <silent> <c-j> :m .+1<cr>==
nnoremap <silent> <c-k> :m .-2<cr>==
vnoremap <silent> <c-j> :m '>+1<cr>gv=gv
vnoremap <silent> <c-k> :m '<-2<cr>gv=gv

noremap <leader>u :G remote add origin git@github.com:
noremap <leader>p :term git push origin main
noremap <leader>l :wa<cr>:terminal <up>

noremap <silent> <leader>g :G<cr>
noremap <silent> <leader>w :w<cr>
noremap <silent> <leader>d :bd!<cr>
noremap <silent> <leader>t :Snippet<cr><cr>
noremap <silent> <leader>c :Calculator<cr>

noremap <silent> <leader>h :Recompile<cr>
noremap <silent> <leader>H :Compile<cr>
noremap <silent> <leader>j :CompileNext<cr>
noremap <silent> <leader>k :CompilePrev<cr>

noremap <silent> <leader>b :Ido std.browse<cr>

noremap <silent> <leader>f :Ido std.find_files<cr>
noremap <silent> <leader>F :Ido std.buffer<cr>
noremap <silent> <leader>q :Ido std.filetypes<cr>

noremap <silent> <leader>o :Ido project.open<cr>
noremap <silent> <leader>. :Ido project.find_files<cr>
noremap <silent> <leader>, :Ido project.buffer<cr>

noremap <silent> <leader>sf :Ido tag.functions<cr>
noremap <silent> <leader>sv :Ido tag.variables<cr>
noremap <silent> <leader>st :Ido tag.types<cr>
noremap <silent> <leader>se :Ido tag.enums<cr>
noremap <silent> <leader>sd :Ido tag.defines<cr>

augroup shoumodip
    autocmd!
    autocmd FileType c,cpp setlocal commentstring=//%s
    autocmd FileType go setlocal noexpandtab
    autocmd BufWritePre * call ClearWhitespace()
augroup END

silent! colorscheme minimal
