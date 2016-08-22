#!/bin/bash

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
# nerdtree
git clone https://github.com/scrooloose/nerdtree.git

# snipmate
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/garbas/vim-snipmate.git
git clone https://github.com/honza/vim-snippets.git

# xmllint
sudo apt install libxml2-utils

cat > ~/.vimrc << EOF
set nocompatible
filetype off

" Settings to replace tab. Use :retab for replacing tab in existing files.
set tabstop=4
set shiftwidth=4
set expandtab

" Have Vim jump to the last position when reopening a file
if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Other general vim options:
syntax on
set showmatch      " Show matching brackets.
set ignorecase     " Do case insensitive matching
set incsearch      " show partial matches for a search phrase
set nopaste
set number         " show line number
set undolevels=1000

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

colorscheme desert

map j !python -m json.tool<CR>              " format JSON
map l !xmllint --format --recover -<CR>     " format XML

execute pathogen#infect()

set cryptmethod=blowfish2
EOF

