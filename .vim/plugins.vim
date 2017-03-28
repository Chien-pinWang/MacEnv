
" vim-plug Section, List of Installed Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'yegappan/mru'
Plug 'itchyny/lightline.vim'
Plug 'ledger/vim-ledger'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'itchyny/calendar.vim'
Plug 'vim-scripts/ag.vim'
Plug 'vimwiki/vimwiki'
Plug 'yuratomo/w3m.vim'
call plug#end()

" File System Explorer 'NERDTree' Configurations
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=35
map <C-n> :NERDTreeToggle<CR>

" Most Recent Used File Listing 'MRU' Configurations
let MRU_Max_Entries=1000
let MRU_Exclude_Files='^jrnl*'

" Ledger's vim Support 'vim-ledger' Configurations
let g:ledger_detailed_first=1
let g:ledger_extra_options = '--pedantic --explicit'
let g:ledger_bin = '/usr/local/bin/ledger'
let g:ledger_fold_blanks = 1
let g:ledger_align_at = 55
let g:ledger_default_commodity = 'NTD'
let g:ledger_commodity_before = 1
let g:ledger_commodity_sep = ' '
let g:ledger_winpos = 'B'
map <C-a> :LedgerAlign<CR>

" Snippet Engine 'ultisnips' Configurations
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Calendar app 'calendar.vim' configurations
let g:calendar_first_day="sunday"
let g:calendar_date_month_name=1
let g:calendar_view='day'
let g:calendar_views=['week', 'day', 'agenda', 'month', 'clock']
let g:calendar_cyclic_view=1
let g:calendar_google_calendar=1

" vimwiki Wiki Document
let g:vimwiki_folding='list'
" let g:vimwiki_folding='expr'
" let g:vimwiki_folding='syntax'
map >> <Plug>VimwikiIncreaseLvlSingleItem
map << <Plug>VimwikiDecreaseLvlSingleItem

" w3m.vim Browse Web Page in vim
" let g:w3m#command='/usr/local/bin/w3m'
let g:w3m#external_browser='open'
" let g:w3m#homepage="local ~/.w3m/bookmark.html"
