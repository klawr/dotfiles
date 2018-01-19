setopt prompt_subst

() {

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER='%F{green}%n%{$reset_color%}'
  PR_USER_OP='%F{green}%#%{$reset_color%}'
  PR_PROMPT='%{$fg_bold[black]%}λ%{$reset_color%} '
else # root
  PR_USER='%F{red}%n%{$reset_color%}'
  PR_USER_OP='%F{red}%#%{$reset_color%}'
  PR_PROMPT='%F{red}λ%{$reset_color%} '
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  PR_HOST='%F{red}%M%{$reset_color%}' # SSH
else
  PR_HOST='%F{green}%M%{$reset_color%}' # no SSH
fi

local return_code="%(?..%F{red}%? ↵%{$reset_color%})"

local user_prompt="${PR_USER}%F{cyan}@${PR_HOST}"
local current_dir="%B%F{blue}%~%f%b"

local git_branch='$(git_prompt_info)'

PROMPT="${user_prompt} ${current_dir} ${git_branch}
${PR_PROMPT} %f"
RPROMPT="${return_code}"

PROMPT2="%{$fg_bold[black]%}%_${PR_PROMPT}"

#PROMPT=$'
#%{$fg[blue]%}%/%{$reset_color%} $(git_prompt_info)$(bzr_prompt_info)%{$fg[white]%}[%n@%m]%{$reset_color%} %{$fg[white]%}[%T]%{$reset_color%}
#%{$fg_bold[black]%}>%{$reset_color%} '



ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%F{yellow}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

}
