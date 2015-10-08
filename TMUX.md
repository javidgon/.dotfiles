# Shortcuts (Based on the provided .tmux conf)

* Open a new session: `tmux -2 new -s <session_name>`
* Attach session: `tmux -2 attach -t <session_name>`
* Kill session: `tmux -2 kill-session -t <session_name>`
* Kill server: `tmux -2 kill-server`

## Sessions
* List sessions: `Ctrl-a s`
* Attach session: `Ctrl-a a`
* Detach session: `Ctrl-a d`
* Go to tmux console: `Ctrl-a :`

## Windows
* New window: `Ctrl-a c`
* Move to next window: `Ctrl-a n`
* Move to last window: `Ctrl-a l`
* Kill window: `Ctrl-a k`
* List windows: `Ctrl-a "`
* Rename window: `Ctrl-a ,`
* Split window vertically: `Ctrl-a V`
* Split window horizontally: `Ctrl-a S`

## Panes
* Kill pane: `Ctrl-a X`
* Rotate among panes: `Ctrl-a Tab`
* Navigate among panes `Ctrl-a <up>/<down>/<left>/<right>`
* Access to Scroll mode: `Ctrl-a [` (Quit mode: `q`)
* Toggle zoom in/out (pane): `Ctrl-a z`
