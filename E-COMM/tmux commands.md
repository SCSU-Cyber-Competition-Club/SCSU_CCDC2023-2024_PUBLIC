# Basic tmux commands

- `ctrl-b` starts all shortcuts in tmux
- `ctrl-b` and `?` to see a list of shortcuts
### PANES
- `ctrl-b` and then RELEASE and press `%` to split into left and right
- `ctrl-b` and `"` to split vertically
- `ctrl-b <arrow key>` to switch the window selected
- close a pane with either `exit` command or `ctrl-d`

### WINDOWS
- `ctrl-b` and `c` to create a new window
- `ctrl-b` and `p` for the previous window
- `ctrl-b` and `n` for the next window
- `ctrl-b` and `<number>` for the numbered window
- `ctrl-b` and `,` to rename the current window
- `ctrl-b` and `&` to kill the current window
### SESSIONS

- you can detach a session (have it continue in the background) by using `ctrl-b` and `d`
- `ctrl-b` and `D` will let you pick which session to detach
- `tmux ls` lets you list all the running sessions
- the syntax to reattach sessions is `tmux attach -t 0`
- `tmux new -s database` will create a new session named database
