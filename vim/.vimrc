call pathogen#infect()
call pathogen#helptags()

set smartindent
set tabstop=4
set softtabstop=4
set expandtab
set cursorline
set number
set autoindent
set ignorecase
set shiftwidth=4
set foldmethod=marker
set incsearch
set hlsearch
set hidden
set ruler
syntax enable
set encoding=utf8
set tags=./tags;

let mapleader = ","

" NERDTree
let NERDTreeShowHidden=1

" powerline
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Vimux
nmap <Leader>vc :VimuxCloseRunner<CR>
nmap <Leader>vi :VimuxInterruptRunner<CR>
nmap <Leader>vp :VimuxPromptCommand<CR>
nmap <Leader>vr :call VimuxRunCommand("command")
vmap <Leader>vr y0:call VimuxRunCommand("<C-R>0")<CR>

" color stuff
set background=dark
colorscheme solarized
call togglebg#map("<Leader>bg")

" various commands
nmap <TAB> :bn<CR>
nmap <S-TAB> :bp<CR>
nmap w!! :w !sudo tee %<CR>
map <Leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>
nmap <Leader>t= :Tab /=<CR>
vmap <Leader>t= :Tab /=<CR>
nmap <Leader>t> :Tab /=><CR>
vmap <Leader>t> :Tab /=><CR>
nmap <Leader>nt :NERDTreeToggle<CR>

augroup mkd 

    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>

augroup END 

au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

au BufReadPost *.php  set keywordprg=pman
au BufReadPost *.html set keywordprg=pman

au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType css set omnifunc=csscomplete#CompleteCSS

let g:debuggerPort = 10001
let g:debuggerBreakAtEntry = 1
let g:debuggerMaxDepth = 3
let g:user_zen_leader_key = ','
let g:user_zen_expandabbr_key = 'Z'
