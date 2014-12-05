call pathogen#infect()
call pathogen#helptags()

source ~/.vim/rc/settings
source ~/.vim/rc/mappings
source ~/.vim/rc/autocommands
source ~/.vim/rc/scripts

if $TERMINATOR_PROFILE == "solarized-light"
    ToggleBG
endif
