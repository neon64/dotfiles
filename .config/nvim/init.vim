" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

" Let's make it pretty
Plug 'chriskempson/base16-vim'

call plug#end()

let g:airline_powerline_fonts = 1

syntax enable
set background=dark
set termguicolors
" spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4
" colorscheme
colorscheme base16-tomorrow-night
hi! EndOfBuffer guifg='#002b36'

" FINDING FILES
" 
" According to the video here:
" https://www.youtube.com/watch?v=XA2WjJbmmoM&t=408s

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display allmatching files when we tab complete
set wildmenu

" HYBRID NUMBERING
" 
" https://jeffkreeftmeijer.com/vim-number
set number relativenumber

" SYNTAX FOLDING
" 
"
set foldmethod=syntax
set foldlevel=4
map <Space> za

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>
nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
