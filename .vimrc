" vimrc for mnpk<mnncat@gmail.com>

" ============================================================================
" Plugins {{{
call plug#begin('~/.vim/plugged')

" browsing
Plug 'Yggdroot/indentLine'
autocmd! User indentLine doautocmd indentLine Syntax
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'haya14busa/incsearch.vim'
Plug 'nelstrom/vim-visual-star-search'

" git
Plug 'tpope/vim-fugitive'

" lang
Plug 'fatih/vim-go'
Plug 'scrooloose/syntastic'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'honza/dockerfile.vim'

" edit
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'

" colorscheme
Plug 'junegunn/seoul256.vim'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'


call plug#end()
" }}} Plugins




" ============================================================================"
" Basic {{{
set foldmethod=marker
syntax enable
let g:molokai_original=1
let g:rehash256=1
colorscheme molokai
hi Normal guibg=none ctermbg=none

set number
set hlsearch
set t_Co=256
" set listchars=tab:\>\ ,eol:$
set scrolloff=2

set laststatus=2
set completeopt-=preview
if has("unix")
	let s:uname = system("uname")
	if s:uname == "Darwin\n"
		set clipboard=unnamed
	elseif s:uname == "Linux\n"
		set clipboard=unnamedplus
	endif
endif
iabbrev </ </<C-X><C-O>
set expandtab tabstop=4 shiftwidth=4
" set colorcolumn=80
set cursorline
" highlight ColorColumn ctermbg=233
set exrc
set secure

" }}} Basic


" ============================================================================
" Map {{{
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
map <C-K> :TComment<CR>
" }}} Map


" ============================================================================
" Autocmd {{{
au FileType python setl tabstop=4 shiftwidth=4
au FileType cpp set cino=g1,h1,l1,i4,+4,(0,w1,W4 expandtab shiftwidth=2
au FileType javascript set expandtab tabstop=2 shiftwidth=2
au FileType coffee set expandtab tabstop=2 shiftwidth=2
au FileType json set expandtab tabstop=2 shiftwidth=2
au FileType scss set expandtab tabstop=2 shiftwidth=2
au FileType css set expandtab tabstop=2 shiftwidth=2
au FileType html set expandtab tabstop=2 shiftwidth=2
au FileType go set listchars=tab:\\  list noet tabstop=8 shiftwidth=8
au FileType jade set noet listchars=tab:\\  list noet tabstop=4 shiftwidth=4
au FileType vim set expandtab tabstop=2 shiftwidth=2
" }}} Autocmd


" ============================================================================
" config {{{
let g:indentLine_enabled = 1
" }}} config

" ============================================================================
" Others {{{
" auto change to paste mode when pasting from buffer
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
" }}} Others
