## COLORSCHEME: gruvbox light (medium)
#
# Some colors are not used by gruvbox light medium theme.
# The main idea is to find best version of colors that fit
# the spirit of gruvbox light theme with limited numbers of
# 256 color palette.

set-option -g status "on"

# default statusbar colors
set-option -g status-style bg=colour252,fg=colour239 # bg=notInGruvboxPallete, #fg=fg1

# default window title colors
set-window-option -g window-status-style bg=colour66,fg=colour229 # bg=aqua, fg=bg5

# default window with an activity alert
set-window-option -g window-status-activity-style bg=colour237,fg=colour241 # bg=bg1, fg=notInGruvboxPallete

# active window title colors
set-window-option -g window-status-current-style bg=default,fg=colour237 # bg=default, fg=bg1

# pane border
set-option -g pane-active-border-style fg=colour241 # fg=notInGruvboxPallete
set-option -g pane-border-style fg=colour252 # bg1=notInGruvboxPallete

# message infos (visible while writing command)
set-option -g message-style bg=colour252,fg=colour241 # bg=notInGruvboxPallete, fg=notInGruvboxPallete

# writing commands inactive
set-option -g message-command-style bg=colour124,fg=colour241 # bg=notInGruvboxPallete, fg=notInGruvboxPallete

# pane number display
set-option -g display-panes-active-colour colour241 # notInGruvboxPallete
set-option -g display-panes-colour colour248 # notInGruvboxPallete

# clock
set-window-option -g clock-mode-colour colour172 # orange

# bell
set-window-option -g window-status-bell-style bg=colour124,fg=colour229 # bg=red, fg=bg

## Theme settings mixed with colors (unfortunately, but there is no cleaner way)
set-option -g status-justify "left"
set-option -g status-left-style none
set-option -g status-left-length "80"
set-option -g status-right-style none
set-option -g status-right-length "80"
set-window-option -g window-status-separator ""

set-option -g status-left "#[bg=colour243,fg=colour255] #S #[bg=colour252,fg=colour243,nobold,noitalics,nounderscore]"
set-option -g status-right "#[bg=colour252,fg=colour243,nobold,nounderscore,noitalics]#[bg=colour243,fg=colour255] %Y-%m-%d  %H:%M #[bg=colour243,fg=colour237,nobold,noitalics,nounderscore]#[bg=colour237,fg=colour255] #h "

set-window-option -g window-status-current-format "#[bg=colour215,fg=colour252,nobold,noitalics,nounderscore]#[bg=colour215,fg=colour239] #I #[bg=colour215,fg=colour239,bold] #W#{?window_zoomed_flag,*Z,} #[bg=colour252,fg=colour215,nobold,noitalics,nounderscore]"
set-window-option -g window-status-format "#[bg=colour249,fg=colour252,noitalics]#[bg=colour249,fg=colour241] #I #[bg=colour249,fg=colour241] #W #[bg=colour252,fg=colour249,noitalics]"

# vim: set ft=tmux tw=0 nowrap:
