# ============================
# }}} Custom Configuration {{{
# ============================

# ----------
# Zsh Config
# ----------

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Prompt
PROMPT='%2~ ${(e)git_info[prompt]}» '

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# -----------
# Tool Config
# -----------

# Less
export LESS=FR
export LESSHISTFILE=-

# ---------
# Variables
# ---------

# Shell varaibles
# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# Env variables
export CUSTOM_SCRIPTS="$HOME/.dotfiles/scripts"
export LOCAL_BIN="$HOME/.local/bin"
typeset -U path=(
    $LOCAL_BIN
    "$CUSTOM_SCRIPTS/bin"
    $path
)
typeset -U fpath=(
    "$CUSTOM_SCRIPTS/env"
    "$CUSTOM_SCRIPTS/comp"
    $fpath
)

# -------
# Aliases
# -------

source "$HOME/.zim/aliases.zsh"

# ====================
# }}} Zimfw Config {{{
# ====================

# -------------
# Module Config
# -------------

#
# git-info
#
setopt nopromptbang prompt{cr,percent,sp,subst}
zstyle ':zim:git-info:branch' format '%F{252}%b%f'
zstyle ':zim:git-info:dirty' format '%F{166}●%f'
zstyle ':zim:git-info:commit' format '%F{252}%c%f'
zstyle ':zim:git-info:keys' format 'prompt' '%F{252}[%f%b%c%D%F{252}]%f '
autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# -----------
# Module Init
# -----------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# -----------------------
# Post-Init Module Config
# -----------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# ==================
# }}} FNM Config {{{
# ==================

export FNM_PATH="$HOME/.local/share/fnm"
if [[ -d "$FNM_PATH" ]] {
    typeset -U path=("$FNM_PATH" $path)
    eval "$(fnm env \
            --use-on-cd \
            --version-file-strategy=recursive \
            --resolve-engines \
            --shell zsh)"
}
