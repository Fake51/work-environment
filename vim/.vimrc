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

nmap <Leader>jsl :call VimuxRunCommand("jslint " . bufname("%"))<CR>
nmap <Leader>jsh :call VimuxRunCommand("jshint " . bufname("%"))<CR>
nmap <Leader>jm :call VimuxRunCommand("mocha " . bufname("%"))<CR>
nmap <Leader>jswl :call VimuxRunCommand("jslint --sloppy=true --browser=true --regexp==true --maxerr=1000 --unparam=true --plusplus=true " . bufname("%"))<CR>
nmap <Leader>npt :call VimuxRunCommand("npm test")<CR>
nmap <Leader>rr :call VimuxRunCommand("ruby " . bufname("%"))<CR>
nmap <Leader>rp :call VimuxRunCommand("php " . bufname("%"))<CR>
nmap <Leader>rn :call VimuxRunCommand("node " . bufname("%"))<CR>

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
au BufNewFile,BufRead *.json set ft=javascript

au BufReadPost *.php  set keywordprg=pman
au BufReadPost *.html set keywordprg=pman

au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType javascript call JavaScriptFold()

au FileType php nmap <Leader>ps :call VimuxRunCommand("bin/phpspec run")<CR>

let g:debuggerPort = 10001
let g:debuggerBreakAtEntry = 1
let g:debuggerMaxDepth = 5
let g:user_zen_leader_key = ','


if $TERMINATOR_PROFILE == "solarized-light"
    ToggleBG
endif

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
  vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
