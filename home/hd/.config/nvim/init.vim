set ignorecase
set smartcase
"set number relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set hidden
set nobackup
set nowritebackup
set noswapfile
set incsearch
set iskeyword-=_
set splitbelow splitright
set mouse=a
set sj=-50
set foldmethod=syntax
set noshowmode
set nohlsearch
set pumheight=10
set title
set fdls=99
set textwidth=80
set colorcolumn=+1
" set clipboard=unnamedplus

filetype plugin on
syntax on

let mapleader =","
let g:netrw_banner=0
let g:netrw_liststyle=2

highlight clear signcolumn

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType python setlocal foldmethod=indent
autocmd InsertLeave,TextChanged cpp,c set foldmethod=syntax

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/tagbar'
Plug 'bfredl/nvim-ipy'
Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'antoinemadec/coc-fzf'

Plug 'ahmedkhalf/jupyter-nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'SirVer/ultisnips'
call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
EOF

let g:nvim_ipy_perform_mappings = 0

lua << EOF
  require("jupyter-nvim").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

command RunQtConsole call jobstart("jupyter qtconsole --JupyterWidget.include_other_output=True")

" function! Runcell()
"     exec "norm \<Plug>(IPy-RunCell)"
"     call search("^##","W")
" endfunction

" autocmd FileType python nmap <buffer> <S-CR> :call Runcell()<CR>
autocmd FileType python nmap <buffer> <S-CR> <Plug>(IPy-RunCell)

autocmd FileType c,cpp setlocal commentstring=//\ %s

let g:gitgutter_enabled = 0

nnoremap <silent> <leader>g :GitGutterToggle<cr>

noremap <silent> <leader>e :CocCommand explorer<CR>

noremap <silent> <leader>t :TagbarToggle<cr>

" let g:tex_flavor = 'latex'
let g:vimtex_compiler_method='latexmk'
let g:vimtex_view_general_viewer = 'zathura'

function! CocFuncName()
    let currentFunctionSymbol = get(b:, 'coc_current_function', '')
    return currentFunctionSymbol !=# '' ? "" .currentFunctionSymbol : ''
endfunction

let g:lightline ={
            \'colorscheme':'onedark',
            \'component_function': {
            \   'cocstatus': 'coc#status',
            \   'currentFunc': 'CocFuncName'
            \},
            \'active': {
            \   'left': [ [ 'mode', 'paste', ],
            \           [ 'readonly', 'relativepath', 'modified' ],
            \           [ 'cocstatus', 'currentFunc' ] ],
            \},
            \'tab_component_function': {
            \   'tabnum': '',
            \},
            \}

set termguicolors
let g:onedark_terminal_italics=1
colorscheme onedark

" FZF config"
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
nnoremap <Leader>z :FZF <CR>
nnoremap <leader>b :Buffers <CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <silent> <A-q> :qa<CR>

nmap <A-1> 1gt
nmap <A-2> 2gt
nmap <A-3> 3gt
nmap <A-4> 4gt
nmap <A-5> 5gt
nmap <A-w> gT
nmap <A-e> gt

nmap <silent> <A-s> :bp<CR>
nmap <silent> <A-d> :bn<CR>

" what is the equivalent of <ctrl-o> in terminal mode?
autocmd BufWinEnter,WinEnter term://* startinsert
tmap <A-w> <C-\><C-n>gT
tmap <A-e> <C-\><C-n>gt
nmap <A-t> :silent !$TERMINAL&<CR>

nnoremap <silent> U :ea 1f<CR>

noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" insert mode emacs shortcuts
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-E> <End>
inoremap <C-F> <Right>
inoremap <A-b> <C-Left>
inoremap <A-f> <C-Right>
inoremap <C-K> <Esc>lC
inoremap <C-U> <Esc>d0xi
inoremap <C-Y> <Esc>pa
inoremap <C-d> <Delete>
inoremap <A-x> <Esc>:
" inoremap <A-f> <Esc>lwi
" inoremap <A-b> <Esc>bi

""" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Search selected text in visual mode
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Removes pipes | that act as seperators on splits
" set fillchars+=vert:\ 

" ----------------coc config-------------"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
"if has("patch-8.1.1564")
"  " Recently vim can merge signcolumn and number column into one
"  set signcolumn=number
"else
"  set signcolumn=yes
"endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? coc#_select_confirm() :
"   \ coc#expandableOrJumpable() ?
"   \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ coc#refresh()

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

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
