# to simlink this file 
# ln -sf "$HOME/bin/.zshrc" "$HOME/.zshrc"

# ----- PATHS -----
export PATH=$HOME/bin:/usr/local/bin:$PATH
export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export ZDOTDIR=~/
export RACK_DIR=/Users/thomas/PROJETS/NOI-VCVRACK/Rack-SDK
export CMAKE_COLOR_DIAGNOSTICS=ON

## ----- Alias ------
alias compress="7zz a"
alias extract="7zz e"
alias browse="pandoc -f html -t markdown"
alias 320mp3="for i in *.wav; do lame -b 320 "$i"; done"
alias md="pbpaste | pandoc -f markdown -t html | pbcopy; echo 'Conversion done.'"
alias copy="pbcopy"
alias paste="pbpaste"
alias ll="ls -1"
alias lla="ls -Aoh"
alias symlink="ln -s"
alias please="sudo !!"
alias cassetter="(cd ~/FILES/SOUND/Tools/cassetter && npm run dev && cd -)"
alias hide="chflags hidden"
alias show="chflags nohidden"
alias py="/opt/homebrew/bin/python3.9"
alias InkCoverage="gs -o Desktop/InkCoverage.txt -sDEVICE=ink_cov Desktop/InkCoverage.pdf"

# ----- Load Plugins -----
# source "/opt/homebrew/Cellar/zsh-autocomplete/23.07.13/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(fzf --zsh)"
source ${HOME}/.ghcup/env

# ----- nnn cd behviour ------
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    command nnn "$@"
    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}

# ----- Prompt customization -----
source ~/bin/_prompt.zsh
prompt_config

# ----- prompt welcome ------
clear

echo " "
echo "      { }"
echo "    { }o{ }"     
echo "  \_\/{ }"
echo " __ /_      welcome traveler ~"    
echo "|_____|"
echo " \___/"

