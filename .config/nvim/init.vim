" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-sensible' " sensible defaults
Plug 'tpope/vim-commentary' " use `gc` to comment
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak' " `s` and `S` do two letter sneaking
Plug 'sheerun/vim-polyglot' " many different language packs
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'xavierd/clang_complete'

" Let's make it pretty
Plug 'chriskempson/base16-vim'

call plug#end()

let g:airline_powerline_fonts = 0
let g:vim_markdown_fenced_languages = ['html', 'python', 'bash=sh', 'c=c']
" path to directory where library can be found
let g:clang_library_path='/usr/lib/'

syntax enable
set background=dark
set termguicolors
" spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4

" colorscheme
" add colorscheme to match master_theme

let master_theme = system('cat $HOME/.config/colors/current-theme')
execute 'colorscheme' master_theme

hi! Normal guibg=NONE ctermbg=NONE
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

" Scroll with mouse
set mouse=a

" Copy/paste to system clipboard
" (instead, we prefer to use "+y and "+p to copy and paste respectively -
" keeps the buffers separate)
" set clipboard=unnamedplus

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

nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
inoremap <Right> <C-o>:echo "No right for you!"<CR>

nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
inoremap <Up> <C-o>:echo "No up for you!"<CR>

nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
inoremap <Down> <C-o>:echo "No down for you!"<CR>

" because I'm getting so used to spacemacs
nnoremap <Space>fs :w<CR>
nnoremap <Space>wq :wq<CR>

nmap <C-p> <Plug>MarkdownPreviewToggle
imap <C-s> <Esc>:w<CR>i
nmap <C-s> :w<CR>
