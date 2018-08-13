" .vimrc
" mnpk<mnncat@gmail.com>

" ============================================================================
"  Vim-Plug Lists {{{
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!mkdir -p ~/.vim/autoload'
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
call plug#begin('~/.vim/plugged')
" configuration
Plug 'mnpk/dotfiles', {'do': './install'}
" completer
"
" colorscheme
Plug 'tomasr/molokai'
Plug 'mnpk/vim-monokai'
Plug 'junegunn/seoul256.vim'
" language support
Plug 'mnpk/aheui.vim'
Plug 'mnpk/vim-cppinclude'
Plug 'digitaltoad/vim-jade'
Plug 'nvie/vim-flake8'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'suan/vim-instant-markdown'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'stephpy/vim-yaml'
Plug 'fatih/vim-go'
Plug 'elzr/vim-json'
Plug 'ap/vim-css-color'
Plug 'rhysd/vim-clang-format'
Plug 'MrTheodor/vim-cpplint'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" util
Plug 'mnpk/limelight.vim'
Plug 'mnpk/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'The-NERD-tree'
Plug 'vcscommand.vim'
Plug 'bufexplorer.zip'
Plug 'tComment'
Plug 'a.vim'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'nelstrom/vim-visual-star-search'
Plug 'SyntaxRange'
Plug 'Tail-Bundle'
Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'sjl/gundo.vim'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/Conque-GDB'
Plug 'haya14busa/incsearch.vim'
Plug 'syntastic'
" fun
Plug 'mnpk/vim-reddit'
Plug 'ryanss/vim-hackernews'
Plug 'csexton/jekyll.vim'
" git related
Plug 'tpope/vim-fugitive'
Plug 'mnpk/vim-jira-complete'
call plug#end()
" }}} Vim-Plug 

" ============================================================================"
" Basic {{{
set foldmethod=marker
syntax enable
let g:molokai_original=1
let g:rehash256=1
colorscheme monokai
" seoul256 (dark):
"   Range:   233 (darkest) ~ 239 (lightest)
"   Default: 237
" let g:seoul256_background = 234
" colorscheme seoul256

set number
set hlsearch
set t_Co=256
" set tabstop=4
" set shiftwidth=4
set listchars=tab:\┊\ ,eol:$
set scrolloff=2
set laststatus=2
set tags=tags;/,./Linux/tags
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
" set expandtab tabstop=2 shiftwidth=2
set colorcolumn=80
set cursorline
highlight ColorColumn ctermbg=233
set exrc
set secure
" }}} Basic

" ============================================================================
" Commands {{{
command! -nargs=1 FARecursive silent execute '!clear'<bar>silent execute '!echo searching \"<f-args>\"...'<bar>silent execute 'grep! <f-args> `find . -name "*.cpp" -or -name "*.c" -or -name "*.h"`'<bar>:botright copen<bar>redraw!
command! -nargs=1 FA silent execute '!clear'<bar>silent execute '!echo searching \"<f-args>\"...'<bar>silent execute 'grep! <f-args> `find . -maxdepth 2 -name "*.cpp" -or -name "*.c" -or -name "*.h" -or -name "*.hpp"`'<bar>:botright copen<bar>redraw!
command! -nargs=1 Find silent execute '!clear'<bar>silent execute 'grep! <f-args> %'<bar>:botright copen<bar>:redraw!
command! CMake :wa<bar>silent execute '!mkdir -p build;cd build;cmake ..'<bar>execute "make! -C build -j4"<bar>:copen<bar>:redraw!
command! CMakeTest :wa<bar>silent execute '!mkdir -p build;cd build;cmake ..'<bar>execute "make! -C build unittest -j4"<bar>:copen<bar>:redraw!
command! CMakeClean :wa<bar>execute "make! -C build clean"<bar>:copen<bar>:redraw!
command! Make :wa<bar>silent execute '!clear'<bar> execute "make! -C build -j4"<bar>:botright copen<bar>:redraw!
command! MakeTags execute '!find . -name "*.h" -or -name "*.cpp" -or -name "*.c" | ctags -L -'
command! RemoveTrailingWhitespace :%s/\s\+$//
command! DjangoRunserver execute '!./manage.py runserver 0.0.0.0:8000'
command! RunPython silent execute '!clear'<bar>execute '!python %'
command! RunGo silent execute '!clear'<bar>execute '!go run %'
command! ToUTF8 silent execute '!python ~/to_utf8.py %'<bar>:e %<bar>:redraw!
" }}} Commands

" ============================================================================
" Map {{{
nmap <F2> :AV<CR>
nmap <F3> :Find <cword><CR>
nmap <F4> :FA <cword><CR>
au FileType python nmap <F5> :RunPython<CR>
au FileType go nmap <F5> :RunGo<CR>
nmap <F5> :CMake<CR>
nmap <F6> :CMakeTest<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F9> :BufExplorer<CR>
nmap <F10> :ConqueGdbVSplit<CR>
nmap <F11> :ConqueTermVSplit bash<CR>
map <F12> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
nmap U "_cw"<esc>b
map <C-K> :TComment<CR>
nmap qq :q<CR>
nmap qa :qa<CR>
nmap <space> XPpr
nmap K XPpr<CR>
vnoremap L >gv
vnoremap H <gv
vnoremap K xkP`[V`]
vnoremap J xp`[V`]
" map <Esc><Esc> :w<CR>
inoremap jk <Esc>
nnoremap ! :!
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}} Map

" ============================================================================
" Plugin Settings {{{
" let NERDTreeQuitOnOpen = 1
let g:vim_markdown_folding_disabled=1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:snips_author = 'mwpark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#use_vcscommand = 1
" let g:syntastic_cpp_no_include_search = 1
" let g:syntastic_cpp_check_header = 0
" let g:syntastic_cpp_remove_include_errors = 1
" let g:syntastic_cpp_checkers = ['gcc', 'cpplint', 'cppcheck']
" let g:syntastic_auto_loc_list = 2
" let g:syntastic_check_on_open = 0
" let g:syntastic_loc_list_height = 5
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_cpp_cpplint_exec = 'cpplint'
" let g:syntastic_cpp_cpplint_args = '--filter=-readability/streams,-legal/copyright,-build/header_guard,-build/include_order,-build/c++11'
" let g:syntastic_cpp_compiler_options='-std=c++11'
" let g:syntastic_cpp_include_dirs = ['/usr/local/boost157/include', '/home/mnpk/src/probe/ADSBase/Include', 'src/']
" let g:syntastic_python_pylint_args = '--rcfile=~/pylint.rc'
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_enable_highlighting=0
let g:ycm_show_diagnostics_ui = 0
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:SuperTabDefaultCompletionType = '<C-n>'
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:jiracomplete_url = 'http://d7.mnpk.org/jira/'
let g:jiracomplete_username = 'mnpk'
let g:jiracomplete_format = '"[". v:val.abbr ."]"'
" clang-format
            " \ "AllowShortIfStatementsOnASingleLine" : "true",
            " \ "AllowShortBlocksOnASingleLine": "true",
            " \ "AllowShortFunctionsOnASingleLine": "true",
let g:clang_format#style_options = {
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AllowShortBlocksOnASingleLine": "false",
            \ "AllowShortFunctionsOnASingleLine": "false",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}
let g:clang_format#command = 'clang-format-3.5'
let g:clang_format#code_style = 'google'
" let g:clang_format#auto_format_on_insert_leave = 1
let g:clang_format#auto_format = 0
let g:cpplint_filter = "-readability/streams,-legal/copyright,-build/header_guard,-build/include_order,-build/c++11,-readability/casting,-runtime/references,-build/include,-runtime/int"
let g:clang_library_path="/usr/lib/llvm-3.5/lib"
let g:clang_user_options = '-std=c++11' 
let g:plug_timeout = 600
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CloseOnEnd = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:jekyll_path = $HOME . "/blog"
let g:go_bin_path = $HOME . "/go/bin"
let g:vim_json_syntax_conceal = 0
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude = ['jade']
let g:indentLine_color_term = 240
let g:indentLine_char="┊"

" }}} Plugin Settings

" ============================================================================
" Autocmd {{{
autocmd FileType c,cpp,objc nnoremap <buffer>== :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer>== :ClangFormat<CR>
autocmd User GoyoEnter Limelight
autocmd User GoyoLeave Limelight!
" autocmd BufNewFile,BufReadPost *.md set filetype=markdown
au FileType python setl tabstop=4 shiftwidth=4
au FileType cpp set cino=g1,h1,l1,i4,+4,(0,w1,W4 expandtab shiftwidth=2
au FileType javascript set expandtab tabstop=2 shiftwidth=2
au FileType coffee set expandtab tabstop=2 shiftwidth=2
au FileType json set expandtab tabstop=2 shiftwidth=2
au FileType scss set expandtab tabstop=2 shiftwidth=2
au FileType css set expandtab tabstop=2 shiftwidth=2
au FileType html set expandtab tabstop=2 shiftwidth=2
au FileType go set listchars=tab:\┊\  list noet tabstop=8 shiftwidth=8
au FileType jade set noet listchars=tab:\┊\  list noet tabstop=4 shiftwidth=4
au FileType vim set expandtab tabstop=2 shiftwidth=2
" }}} Autocmd

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
