# vimrc
This .vimrc includes a function `RunVProgram()` to run vlang [V](https://vlang.io/) programs on pressing `<F9>` in normal mode.
It looks up the .mod file in up to 3 parent directories using the systems find tool.
In case there is none, it will run `v -cg run .` in the current directory.<br>
The program output is simply echoed.<br>
<br>
Also there is a neat little shell execution mapping on `<S-q>`(meaning Shift+q) with `noremap Q !!$SHELL<CR>`, which runs the text under the cursor
as a shell script and replaces the line with the output.<br>
Try it by typing `date` in vim. Then `<ESC>` to get to normal mode and press `<S-q>`. The line should be replaced with the current date.<br>
<br>
Only tested on GNU/Linux, or as I've recently taken to calling it, GNU plus Linux.
