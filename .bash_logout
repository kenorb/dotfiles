# ~/.bash_logout: executed by bash(1) when login shell exits.

# Clear console if possible when logging out to increase privacy.
[ "$SHLVL" = 1 ] && clear_console -q 2>/dev/null
