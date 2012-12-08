"" Marshall's vim config
""
"" Thanks:
""   Gary Bernhardt  <destroyallsoftware.com>
""   Drew Neil  <vimcasts.org>
""   Tim Pope  <tbaggery.com>
""   Janus  <github.com/carlhuda/janus>
""

set nocompatible
syntax enable
set encoding=utf-8

call pathogen#infect()
filetype plugin indent on

set background=dark
color molokai
set nonumber
set ruler       " show the cursor position all the time
set cursorline
set showcmd     " display incomplete commands

if has('gui_macvim')
  "set guifont=Menlo\ Regular\ for\ Powerline:h14
  set guifont=Source\ Code\ Pro:h13
  "set guifont=Inconsolata-dz\ for\ Powerline:h14
endif

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

"" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:▸\              " a tab should display as "  ", trailing whitespace as "."
"set listchars+=trail:.            " show trailing spaces as dots
"set listchars+=eol:¬
set listchars+=trail:·
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Make sure all mardown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g`\"" | endif
endif

" provide some context when editing
set scrolloff=3

" don't use Ex mode, use Q for formatting
map Q gq

" from vimbits.org
map Y y$

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

let mapleader=","


" New CtrlP implementation - https://github.com/kien/ctrlp.vim
map <leader>f :CtrlP<cr>
map <leader>d :CtrlPMRU<cr>

" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <leader><leader> <c-^>

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" disable cursor keys in normal mode
"map <Left>  :echo "no!"<cr>
"map <Right> :echo "no!"<cr>
"map <Up>    :echo "no!"<cr>
"map <Down>  :echo "no!"<cr>

set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  "set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
  set statusline=%F%m%r%h%w\ [type=%Y]\ [pos=%04l,%04v][%p%%]\ [len=%L]
  " Start the status line
  "set statusline=%f\ %m\ %r

  " Add fugitive
  "set statusline+=%{fugitive#statusline()}

  " Finish the statusline
  "set statusline+=\ Line:\ %l/%L\ [%p%%]
  "set statusline+=\ Col:%v
  "set statusline+=\ Buf:\ #%n
  " Show char code and byte under the cursor
  " set statusline+=[%b][0x%B]
endif


" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

let g:CommandTMaxHeight=10

" easybuffer.vim
map <leader>b :EasyBufferHorizontal<cr>

" watch-for-changes.vim
map <leader>w :WatchForChanges!<cr>

" Distraction Free Writing - 
" https://github.com/laktek/distraction-free-writing-vim
let g:fullscreen_colorscheme = "iawriter"
let g:fullscreen_font = "Cousine:h14"
let g:normal_colorscheme = "Tomorrow-Night-Bright"
let g:normal_font="Source\ Code\ Pro:h13"

" Powerline settings
" https://github.com/Lokaltog/vim-powerline

let g:Powerline_symbols = 'fancy'
"https://github.com/Lokaltog/vim-powerline/wiki/Statusline-segments
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

