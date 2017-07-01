" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

" Let's make it pretty
Plug 'frankier/neovim-colors-solarized-truecolor-only'

call plug#end()

let g:airline_powerline_fonts = 1

" Colours
syntax enable
set background=dark
set termguicolors
colorscheme solarized
hi! EndOfBuffer guifg='#002b36'
