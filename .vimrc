let $LANG = 'en_US.UTF-8'
let $LC_CTYPE="en_US.UTF-8"
let $LC_NUMERIC="en_US.UTF-8"
let $LC_TIME="en_US.UTF-8"
let $LC_COLLATE="en_US.UTF-8"
let $LC_MONETARY="en_US.UTF-8"
let $LC_MESSAGES="en_US.UTF-8"
let $LC_PAPER="en_US.UTF-8"
let $LC_NAME="en_US.UTF-8"
let $LC_ADDRESS="en_US.UTF-8"
let $LC_TELEPHONE="en_US.UTF-8"
let $LC_MEASUREMENT="en_US.UTF-8"
let $LC_IDENTIFICATION="en_US.UTF-8"

call plug#begin('~/.vim/plugged')

" Airline
Plug 'vim-airline/vim-airline'

" vim-cheatsheet
Plug 'lifepillar/vim-cheat40'

" vimwiki
Plug 'vimwiki/vimwiki'

" Undo Tree
Plug 'mbbill/undotree/'

" MarkDown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mzlogin/vim-markdown-toc'

" File navigation
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" Git
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
"Plug 'APZelos/blamer.nvim'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Rainbow
Plug 'luochen1990/rainbow'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ALE
"Plug 'dense-analysis/ale'

" Surround
Plug 'tpope/vim-surround'

" vimtex
Plug 'lervag/vimtex'

" syntax highlight
Plug 'bfrg/vim-c-cpp-modern' " C/C++
"Plug 'fatih/vim-go'
"Plug 'vim-python/python-syntax' " Python

"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Themes
Plug 'sainnhe/sonokai'

" Async
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'

Plug 'easymotion/vim-easymotion'

" tagbar
Plug 'preservim/tagbar'

" comment
Plug 'preservim/nerdcommenter'

" copilot
Plug 'github/copilot.vim'

" Buffer
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'moll/vim-bbye'
Plug 'djoshea/vim-autoread'

call plug#end()

set mouse=a
set autoread
set updatetime=1000
set autoindent
set number
set relativenumber
set cursorline
set showcmd
set wrap
set wildmenu
set hlsearch
set incsearch
set ignorecase
set smartcase
set encoding=utf-8 fileencodings=utf-8
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nofoldenable
set belloff=all
set ttimeoutlen=10

syntax on
set nocompatible
filetype indent plugin on

map S :w<CR>
map Q :q<CR>
noremap <C-h> 0
noremap <C-l> $
noremap <C-q> :Bdelete<CR>
noremap <C-k><C-q> :bufdo Bdelete<CR>
xnoremap < <gv
xnoremap > >gv
xnoremap <C-C> "+y1
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[1 q"
  let &t_SR = "\e[4 q"
endif

" Plugin keymap
nnoremap <F1> :nohlsearch<CR>
nnoremap <F2> :UndotreeToggle<CR>

"copilot
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_inactive_alt_sep=1
let g:airline_inactive_collapse=1
nmap <silent> <leader>1 <Plug>AirlineSelectTab1
nmap <silent> <leader>2 <Plug>AirlineSelectTab2
nmap <silent> <leader>3 <Plug>AirlineSelectTab3
nmap <silent> <leader>4 <Plug>AirlineSelectTab4
nmap <silent> <leader>5 <Plug>AirlineSelectTab5
nmap <silent> <leader>6 <Plug>AirlineSelectTab6
nmap <silent> <leader>7 <Plug>AirlineSelectTab7
nmap <silent> <leader>8 <Plug>AirlineSelectTab8
nmap <silent> <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>= <Plug>AirlineSelectNextTab

" NERDTree
nnoremap <leader>t :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeTabsToggle<CR>
nnoremap <C-n> :NERDTreeTabsFind<CR>
let g:nerdtree_tabs_smart_startup_focus = 1

" vimwiki 
let g:vimwiki_list = [{'path':'~/.vimwiki/','path_html':'~/.vimwiki/html/','html_header':'~/.vimwiki/template/header.tpl','syntax':'markdown','ext':'.md'}]
let g:vimwiki_global_ext = 0

"fzf
nnoremap <leader>p :Files<CR>
nnoremap <leader>rg :RG<CR>

" rainbow
let g:rainbow_active = 1

" vimtex
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_compiler_method = 'latexmk'
let maplocalleader = "."

" color
if has('termguicolors')
  set termguicolors
endif
set t_Co=256 
let g:sonokai_style='maia'
let g:sonokai_enable_italic=1
let g:sonokai_transparent_background=0
let g:sonokai_diagnostic_text_highlight=1
let g:sonokai_better_performance=1
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
colorscheme sonokai

"markdown-preview
let g:mkdp_theme = 'dark'
let g:mkdp_page_title = '${name}'

" markdown-toc
let g:vmt_list_item_char= "-"

autocmd FileType javascript,typescript call SetTwoSpaces()
autocmd FileType yaml call SetTwoSpaces()
autocmd FileType json,jsonc call SetTwoSpaces()
autocmd FileType css call SetTwoSpaces()
autocmd FileType html call SetTwoSpaces()
autocmd FileType markdown call SetTwoSpaces()

function SetTwoSpaces()
        setlocal softtabstop=2
        setlocal shiftwidth=2
endfunction

" Surround for latex
au FileType tex let b:AutoPairs = {"(":")","{":"}","[":"]"}

" Jump to last edit
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Backup and undo history
set backup
set backupcopy=auto
set undofile
set undolevels=5140
if has ('nvim')
    set backupdir=$HOME/.vim/nvim_files/backup//
    set undodir=$HOME/.vim/nvim_files/undo//
else
    set backupdir=$HOME/.vim/files/backup//
    set undodir=$HOME/.vim/files/undo//
endif
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
endif
if !isdirectory($HOME.'/.vim/files/backup') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/backup')
endif
if !isdirectory($HOME.'/.vim/files/undo') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files/undo')
endif
if !isdirectory($HOME.'/.vim/nvim_files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/nvim_files')
endif
if !isdirectory($HOME.'/.vim/nvim_files/backup') && exists('*mkdir')
  call mkdir($HOME.'/.vim/nvim_files/backup')
endif
if !isdirectory($HOME.'/.vim/nvim_files/undo') && exists('*mkdir')
  call mkdir($HOME.'/.vim/nvim_files/undo')
endif

function BackupClean(days)
    if isdirectory(&backupdir)
        for file in globpath(&backupdir,"*", 1, 1)
            if localtime() > getftime(file) + 86400 * a:days && delete(file) != 0
                    echo "BackupCleaner: Error deleting '" . file . "'"
                endif
        endfor
    else
        echo "BackupCleaner: Directory not found"
    endif
endfunction
function UndoClean(days)
    if isdirectory(&undodir)
        for file in globpath(&undodir, '*', 1, 1)
            if localtime() > getftime(file) + 86400 * a:days && delete(file) != 0
                echo "UndoDirCleaner: Error deleting '" . file . "'"
            endif
        endfor
    else
        echo "UndoDirCleaner: Directory not found"
    endif
endfunction

call UndoClean(120)
call BackupClean(120)


" ALE
"let g:ale_disable_lsp = 1
"let g:ale_sign_error = '✗'
"let g:ale_sign_warning = '⚡'

" Async Run&Task
nnoremap <silent> <F3> :AsyncTask project-init<cr>
nnoremap <silent> <F4> :AsyncTask project-build<cr>
nnoremap <silent> <F5> :AsyncTask project-run<cr>
nnoremap <silent> <F6> :AsyncStop <cr>
nnoremap <F7> :call asyncrun#quickfix_toggle(max([8,winheight(0)/5]))<cr>
let g:asyncrun_bell = 1
let g:asyncrun_open = max([8,winheight(0)/5])
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
let g:asynctasks_term_pos = 'bottom'
let g:asynctasks_term_focus = 0
let g:asynctasks_term_rows = max([8,winheight(0)/5])
let g:asynctasks_template = {}
let g:asynctasks_template.cmake = [
              \ "[project-init]",
              \ "command=cmake -B build -GNinja",
              \ "cwd=<root>",
              \ "",
              \ "[project-build]",
              \ "command=cmake --build build",
              \ "cwd=<root>",
              \ "errorformat=%. %#--> %f:%l:%c",
              \ "",
              \ "[project-run]",
              \ "command=",
              \ "cwd=<root>",
              \ "output=terminal",
              \ ]

let g:asynctasks_template.cargo = [
              \ "[project-init]",
              \ "command=cargo update",
              \ "cwd=<root>",
              \ "",
              \ "[project-build]",
              \ "command=cargo build",
              \ "cwd=<root>",
              \ "errorformat=%. %#--> %f:%l:%c",
              \ "",
              \ "[project-run]",
              \ "command=cargo run",
              \ "cwd=<root>",
              \ "output=terminal",
              \ ]

"Git 
" lightline
"let g:lightline = {
"  \ 'active': {
"  \   'left': [
"  \     [ 'mode', 'paste' ],
"  \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
"  \   ],
"  \   'right':[
"  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
"  \     [ 'blame' ]
"  \   ],
"  \ },
"  \ 'component_function': {
"  \   'blame': 'LightlineGitBlame',
"  \ }
"\ }
"
"function! LightlineGitBlame() abort
"  let blame = get(b:, 'coc_git_blame', '')
"  " return blame
"  return winwidth(0) > 120 ? blame : ''
"endfunction
"autocmd User CocGitStatusChange {command}
"" navigate chunks of current buffer
"nmap [g <Plug>(coc-git-prevchunk)
"nmap ]g <Plug>(coc-git-nextchunk)
"" navigate conflicts of current buffer
"nmap [c <Plug>(coc-git-prevconflict)
"nmap ]c <Plug>(coc-git-nextconflict)
"" show chunk diff at current position
"nmap gs <Plug>(coc-git-chunkinfo)
"" show commit contains current position
"nmap gc <Plug>(coc-git-commit)
"" create text object for git chunks
"omap ig <Plug>(coc-git-chunk-inner)
"xmap ig <Plug>(coc-git-chunk-inner)
"omap ag <Plug>(coc-git-chunk-outer)
"xmap ag <Plug>(coc-git-chunk-outer)

let g:blamer_enabled = 0
let g:blamer_show_in_insert_modes = 0
let g:blamer_delay = 100
let g:blamer_date_format = '%m/%d/%y %H:%M'

" cpp highlight
let g:cpp_attributes_highlight = 1
let g:cpp_simple_highlight = 1
let g:cpp_function_highlight = 1
let g:cpp_member_highlight = 1

"let g:cpp_class_scope_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_class_decl_highlight = 1
"let g:cpp_posix_standard = 1
"let g:cpp_experimental_simple_template_highlight = 1
"let g:cpp_experimental_template_highlight = 1
"let g:cpp_concepts_highlight = 1
"let g:cpp_no_function_highlight = 1

" tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_width = min([25,winwidth(0)/5])

" coc.vim
" Some servers have issues with backup files, see #649.
"set nobackup
"set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-2> coc#refresh()
endif
" Close completion
"inoremap <silent><expr> <leader>c coc#pum#close()

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
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
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

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
" Mutiple cursors
nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-s> <Plug>(coc-cursors-word)
xmap <silent> <C-s> <Plug>(coc-cursors-range)
nmap <leader>x  <Plug>(coc-cursors-operator)

autocmd CursorHold * silent call CocActionAsync('highlight')

let g:ackprg = 'ag --vimgrep'

" vim-go
let g:go_def_mode='gopls'
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
