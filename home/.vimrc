" vim config by Cies Breijs
"
" this file should be available at: ~/.vim.local
" it is to be used with carlhuda's janus (see github)
" on ubunutu one should install the 'vim-nox' package
" and optionally the 'exuberant-ctags' package

" Jump 5 lines when running out of the screen
"set scrolljump=5

" keep the cursor from getting to the screenedges
set scrolloff=8

" cool colors
"color jellybeans+
highlight StatusLine ctermfg=Black ctermbg=Brown
highlight StatusLineNC ctermfg=Black ctermbg=DarkGray
" match-paren color distinguishable from cursor
highlight MatchParen ctermfg=White ctermbg=DarkGrey cterm=bold

" wrapping please! (set nowrap to turn wrapping off)
set wrap

" mapping to make movements operate on screen lines in ANY mode
" (logic to switch with wrap mode breaks splits
" from: http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
" this is know to cause errors with certain plugins

" no linenumbers please! (set number to turn 'm on)
set nonumber

" highlight the cursor line
" From http://www.pixelbeat.org/settings/.vimrc
if v:version >= 700
  set cursorline
endif

" nicer completion using the status line
set wildmenu
set wildmode=longest:full,full

" strip trailing whitespace before every save
" http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l,c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" color the status line red to indicate i-mode
autocmd InsertEnter * :highlight StatusLine ctermfg=Black ctermbg=Blue
autocmd InsertLeave * :highlight StatusLine ctermfg=Black ctermbg=Brown

" or maybe TAB is easier to type (only in i-mode)
" use shift-tab to insert a '\t'
" sadly this doesnt work from the config file
imap <Tab> <Esc>

" my most often made typo, is hereby allowed
" cnoreabbrev only replaces 'W' with 'w' but only if it is
" neither followed nor preceded by a word character and
" makes sure the history has the correct commands listed
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Q! q!
cnoreabbrev Wq wq
cnoreabbrev WQ wq

" beginning and end of line should not limit freedom of movement :)
set whichwrap+=b,s,h,l,<,>,[,]

" try to bind it to escape
"imap <F1> :highlight StatusLine ctermfg=Black ctermbg=Brown

" disable cursor keys; one day i'll uncomment these :)
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"map <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>
"imap <up> <nop>
