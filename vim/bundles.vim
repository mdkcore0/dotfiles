" Installation

filetype off
call vundle#begin()

" Vundle | https://github.com/VundleVim/Vundle.vim
Plugin 'gmarik/Vundle.vim'

if has('nvim')
    " vim-airline | https://github.com/vim-airline/vim-airline
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
endif

" GitGutter | https://github.com/airblade/vim-gitgutter
Plugin 'airblade/vim-gitgutter'


" EasyMotion | https://github.com/easymotion/vim-easymotion
Plugin 'easymotion/vim-easymotion'


" YouCompleteMe | https://github.com/Valloric/YouCompleteMe
Plugin 'Valloric/YouCompleteMe'


" UltiSnips dependencies
" https://github.com/honza/vim-snippets
Plugin 'honza/vim-snippets'
" UltiSnips | https://github.com/SirVer/ultisnips
Plugin 'SirVer/ultisnips'


" vim-solarized | https://github.com/altercation/vim-colors-solarized
Plugin 'altercation/vim-colors-solarized'


" nerdcommenter | https://github.com/scrooloose/nerdcommenter
Plugin 'scrooloose/nerdcommenter'


" auto-pairs | https://github.com/jiangmiao/auto-pairs
Plugin 'jiangmiao/auto-pairs'


" neomru | https://github.com/Shougo/neomru.vim
Plugin 'Shougo/neomru.vim'
" neoyank | https://github.com/Shougo/neoyank.vim
Plugin 'Shougo/neoyank.vim'
" denite.nvim | https://github.com/Shougo/denite.nvim
Plugin 'Shougo/denite.nvim'


" vim-tmux-navigator | https://github.com/christoomey/vim-tmux-navigator
Plugin 'christoomey/vim-tmux-navigator'


" context_filetype | https://github.com/Shougo/context_filetype.vim
Plugin 'Shougo/context_filetype.vim'


" FSwitch | https://github.com/vim-scripts/FSwitch
Plugin 'vim-scripts/FSwitch'


" Gundo | https://github.com/sjl/gundo.vim
Plugin 'sjl/gundo.vim'


" vim-qml | https://github.com/peterhoeg/vim-qml
Plugin 'peterhoeg/vim-qml'


" i3-vim-syntax | https://github.com/PotatoesMaster/i3-vim-syntax
Plugin 'PotatoesMaster/i3-vim-syntax'


" vim-polyglot | https://github.com/sheerun/vim-polyglot
Plugin 'sheerun/vim-polyglot'


" vim-pydocstring | https://github.com/heavenshell/vim-pydocstring.git
Plugin 'heavenshell/vim-pydocstring.git'


" vim-indent-guides | https://github.com/nathanaelkane/vim-indent-guides
Plugin 'nathanaelkane/vim-indent-guides'


" vim-flake8 | https://github.com/nvie/vim-flake8
Plugin 'nvie/vim-flake8'

call vundle#end()
filetype plugin indent on

" Configuration

if has('nvim')
    " vim-airline | https://github.com/vim-airline/vim-airline
    let g:python2_host_prog = '/usr/local/bin/python'
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_close_button = 0
    let g:airline#extensions#tabline#show_buffers = 0
endif

" EasyMotion | https://github.com/Lokaltog/vim-easymotion
let g:EasyMotion_leader_key = '<Leader>'


" YouCompleteMe | https://github.com/Valloric/YouCompleteMe
"let g:ycm_key_invoke_completion = '<C-]>'
let g:ycm_confirm_extra_conf = 0
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_error_symbol = '‣'
let g:ycm_warning_symbol = '×'
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


" UltiSnips | https://github.com/SirVer/ultisnips
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsListSnippets="<C-h>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" vim-solarized | https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized


" denite.nvim | https://github.com/Shougo/denite.nvim
" XXX
"nnoremap <F3> :UniteSessionSave 
call denite#custom#source(
    \"buffer,file,file_mru,file_rec,grep",
    \"matchers", ['matcher_fuzzy'])
call denite#custom#source('z', 'sorters', ['sorter_rank'])
call denite#custom#option('_', {
    \'prompt': '',
    \'smartcase': v:true,
    \'short_source_names': v:true,
    \'empty': v:false,
    \'auto_resume': v:true,
    \'highlight_matched_char': 'Operator',
    \'highlight_mode_normal': 'CursorLine',
\})
let g:unite_source_file_mru_long_limit=3000
let g:unite_source_directory_mru_long_limit=3000
let g:unite_source_file_mru_limit=200
let g:unite_source_file_mru_filename_format=''

"" use 'the silver searcher' instead of 'grep' if available
if executable('ag')
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'default_opts', [
        \'--skip-vcs-ignores',
        \'--vimgrep',
        \'--hidden',
        \'--smart-case',
        \'--nocolor',
    \])
endif

" custom bindings
nnoremap <leader>* :DeniteCursorWord -buffer-name=grep grep:.<cr>
nnoremap <leader>i :Denite -buffer-name=file file<cr>
nnoremap <leader>r :Denite -buffer-name=file_rec file_rec<cr>
nnoremap <leader>m :Denite -buffer-name=file_mru file_mru<cr>
nnoremap <leader>p :Denite -buffer-name=files buffer file_mru file_rec<cr>
nnoremap <leader>h :Denite -buffer-name=buffer buffer<cr>
nnoremap <leader>y :Denite -buffer-name=yank neoyank<cr>
nnoremap <leader>/ :Denite -buffer-name=grep grep:.<cr>
" install exuberant-ctags
nnoremap <leader>o :Denite -buffer-name=outline -split=vertical -winwidth=60 -default-action=open outline<cr>
" XXX
"nnoremap <leader>s :Unite -no-split session<cr>

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
      \['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent>,g :Denite -buffer-name=git-grep file_rec/git<cr>

" global mappings
call denite#custom#map('_', '<CR>', '<denite:do_action:tabopen>', 'noremap')
let _mode_mappings = [
    \['<C-n>', '<denite:move_to_next_line>', 'noremap'],
    \['<C-p>', '<denite:move_to_previous_line>', 'noremap'],
    \['<C-s>', '<denite:do_action:split>', 'noremap'],
    \['<C-v>', '<denite:do_action:vsplit>', 'noremap'],
    \['<C-r>', '<denite:do_action:switch>', 'noremap'],
\]
for each in _mode_mappings
    call denite#custom#map('insert', each[0], each[1], each[2])
    call denite#custom#map('normal', each[0], each[1], each[2])
endfor

" insert mode mappings
call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>', 'noremap')
" normal mode mappings
"


" FSwitch | https://github.com/vim-scripts/FSwitch
nnoremap <F7> :FSSplitLeft<cr>
nnoremap <F8> :FSHere<cr>


" Gundo
nnoremap <F5> :GundoToggle<CR>


" vim-pydocstring
nmap <silent> <C-_> <Plug>(pydocstring)


" vim-indent-guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
" odd and even with same color :)
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=black

" just autoload on python files; toggle with <leader>ig
augroup python_files
    autocmd!
    autocmd BufRead,BufNew *.py execute "IndentGuidesEnable"
augroup END
