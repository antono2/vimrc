  " enter the current millenium
set nocompatible

" enable syntax and plugins (for netrw)
syntax enable
" Is off by v-vim, as vim itself doesn't know vlang
" filetype plugin on

" Detect filetype on, used with autocmd FileType, and autoindent
filetype indent on
set shiftwidth=2
" don't use actual tab character
set expandtab
set tabstop=2
set softtabstop=2

" Finding Files
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" Display all matching files when tab complete
set wildmenu


""" Key Bindings 

let mapleader = "\\"
" :let maplocalleader = ","

" Autochoice on file swap exists - with message
autocmd SwapExists * let v:swapchoice = "e"

" Execute the command under the cursor and replace the line with the command output
noremap Q !!$SHELL<CR>


""" Line numbers stuff
" Line numbers ON
:set number

" Automaticall switch line numbers on entering edit mode
" Line numbers are kept on when switching buffers
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END



""" Vlang Stuff

" Looks for a v.mod file up to 3 parent directories and runs v in there.
" If none is found, it runs v in the current directory.
" The output is simply echoed to the screen.
function! RunVProgram()
  let mod_file_path = 
    \ trim(system('find ./ ../ ../../ ../../../ -maxdepth 1 -iname "v.mod"'))
  " The result is something like "../v.mod".

  " This will remove the filename like "../".
  let mod_file_dir = substitute(mod_file_path, 
                          \'v.mod$', '', '')
  " If the substitution result is "", meaning no .mod file was found,
  " make sure to have at least a "." there.
  if len(mod_file_dir) == 0
    let mod_file_dir = "."
  endif
  let run_output = system('v -cg run '.mod_file_dir)
  echo run_output
endfunction

nnoremap <F10> :<C-u>call RunVProgram()<CR>
inoremap <F10> <ESC>:<C-u>call RunVProgram()<CR>

" Save File :w
nnoremap <F9> :<C-u> w<CR>
" In insert mode go back to insert after saving
inoremap <F9> <ESC>:w<CR>a

" When typing exactly ' {}' add new line and insert mode in between.
" It also fixes annoying autoindent issue when closing } and removes the spaces
" substitute matches all whitespaces (tabs etc.) at the beginning of the line;
ab  {} {<CR>}<ESC>:substitute /^\s\+//e<ESC>O
