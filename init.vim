version 6.0

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
" Some pre-config
" Plug 'tpope/vim-sensible'
" Plug 'editorconfig/editorconfig-vim'

" Searching file now awesome
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/vim-gitbranch'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Image viwer
Plug 'edluffy/hologram.nvim'

" Git
Plug 'tpope/vim-fugitive'

" LaTex
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Auto complete
Plug 'mattn/emmet-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Rust lang
Plug 'rust-lang/rust.vim'

" Visual is important
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'rust-lang/rust.vim'
Plug 'uiiaoo/java-syntax.vim'
Plug 'vim-python/python-syntax'
Plug 'sheerun/vim-polyglot'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'htmldjango', 'html'] }

" Coding in vim just like playing a piano
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Yes, nerd
Plug 'preservim/nerdtree'
Plug 'scrooloose/nerdcommenter'

" Color Scheme
Plug 'navarasu/onedark.nvim'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Line Number
set number
set relativenumber
set nowrap

" Enable mouse input
set mouse=a

" Make searching case insensitive
set ignorecase          
" ... unless the query has capital letters.
set smartcase           
" Use 'g' flag by default with :s/foo/bar/.
set gdefault            

" always 4 spaces
" set ts=4 sw=4
" set tabstop=4
" set shiftwidth=4

" Color Scheme
let g:onedark_config = {
    \ 'style': 'warm',
\}
syntax on
set background=dark
colorscheme nord
" colorscheme onedark
" colorscheme gruvbox

let g:one_allow_italics = 1

" Some coloring
set termguicolors
set window=38
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" Tabs
set tabstop=4
set softtabstop=0 noexpandtab

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
 
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ?
  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=yes
else
  set signcolumn=number
endif

let g:gitgutter_sign_allow_clobber = 1

" LightLine Config
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'gitbranch', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'filename': 'FilenameForLightline',
	  \   'gitbranch': 'gitbranch#name',
      \ },
      \ }

" Show path of filename
function! FilenameForLightline()
    return expand('%')
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" Java Syntax
highlight link javaIdentifier NONE

" Python Syntax
let g:python_highlight_all = 1

" FZF Config
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_OPTS = "--layout=reverse --info=inline"
let $FZF_DEFAULT_COMMAND="rg --files"
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'TODO', 'border': 'sharp' } }

command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'bat {}']}, <bang>0)

" Active Rainbow Parentheses
let g:rainbow_active = 1

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

let g:user_emmet_leader_key='<C-L>'

" Navigating files and buffer like luke skywalker
nnoremap <silent> <space><space> :Files<CR>
nnoremap <silent> <space>wb :Buffers<CR>
nnoremap <silent> <space>bf :BLines<CR>
nnoremap <silent> <space>rg :Rg<CR>
nnoremap <silent> <space>hf :History<CR>

" Code folding
nnoremap <silent> <space>cfi :set foldenable<bar>foldmethod=indent<CR>
nnoremap <silent> <space>cfd :set nofoldenable<CR>

" Tabs controls
nnoremap <silent> tn :tabnew<CR>
nnoremap <silent> tc :tabclose<CR>
nnoremap <silent> tl :tabnext<CR>
nnoremap <silent> th :tabprevious<CR>

" Clear search highlight
nnoremap <silent> <space>cl :nohlsearch<CR>

" Wrap linse
nnoremap <silent> <space>tt :set wrap<CR>
nnoremap <silent> <space>tn :set nowrap<CR>

" Flutter or Dart Keybinding
nnoremap <silent> <space>fl :CocCommand flutter.run<CR>
nnoremap <silent> <space>fe :CocCommand flutter.emulators<CR>
nnoremap <silent> <space>fD :CocList FlutterDevices<CR>

nnoremap <silent> <space>fdR :CocCommand flutter.dev.hotRestart<CR>
nnoremap <silent> <space>fdr :CocCommand flutter.dev.hotReload<CR>

" Copy and paste to and from system clipboard
vnoremap <silent> <space>cp "+y
nnoremap <silent> <space>pp "+p
vnoremap <silent> <space>pp "+p

" Split 
nnoremap <silent> <space>wv :vsplit<CR>
nnoremap <silent> <space>ww :wincmd w<CR>

" Toggle comment
nnoremap <silent> ,<space> NERDCommenterToggle<CR>

" Open terminal
if has("win32")
	nnoremap <silent> <space>ot :term pwsh<CR>
else
	nnoremap <silent> <space>ot :term<CR>
endif

" Nerd Tree
map <C-o> :NERDTreeToggle<CR>

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Autocmd

" Build after save rst file
if has("win32")
  autocmd BufWritePost *.rst term ..\make.bat html 
else
  autocmd BufWritePost *.rst term ..\make html 
endif


" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" vim: set ft=vim :
