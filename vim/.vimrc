call plug#begin('~/.vim/plugged')
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-sensible'
Plug 'towolf/vim-helm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'GrzegorzKozub/vim-elixirls', { 'do': ':ElixirLsCompileSync' }
Plug 'airblade/vim-gitgutter'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'sirver/ultisnips'

call plug#end()

source ~/.vim/configs/coc
" source ~/.vim/configs/syntastic

source ~/.vim/configs/personal
