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

" color stuff
set background=dark
colorscheme solarized
call togglebg#map("<C-B>")

let mapleader = ","

nmap <TAB> :bn<CR>
nmap <S-TAB> :bp<CR>
nmap w!! :w !sudo tee %<CR>
map <Leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>
nmap <Leader>t= :Tab /=<CR>
vmap <Leader>t= :Tab /=<CR>
nmap <Leader>t> :Tab /=><CR>
vmap <Leader>t> :Tab /=><CR>

imap <S-TAB> <C-o><<

augroup mkd 

    autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>

augroup END 

au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

au BufReadPost *.php  set keywordprg=pman
au BufReadPost *.html set keywordprg=pman

au FileType php set omnifunc=phpcomplete#CompletePHP

let g:debuggerPort = 10001
let g:debuggerBreakAtEntry = 1
let g:debuggerMaxDepth = 3
let g:user_zen_leader_key = ','
let g:user_zen_expandabbr_key = 'Z'
