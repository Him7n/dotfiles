export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export BUILD_PURPOSE=DEVELOPMENT
# ENV VARs
export GEMINI_API_KEY="AIzaSyBhFJ6f01FEJJzXbxVXuSOPZL7TP9E8qn0"
# export PATH=$JAVA_HOME/bin:/opt/homebrew/bin/bazel:$PATH
export JFROG_USERNAME=harness-internal-read
export JFROG_PASSWORD=H8Z8no1cvf
export HARNESS_GENERATION_PASSPHRASE=00b4b62eeef694e718613aa370ae17dbd2559db46d6d72064c1182612069f835
export BUILD_PURPOSE=DEVELOPMENT
export OPTIMIZED_PACKAGE_TESTS=1
# export JAVA_HOME=$(/usr/libexec/java_home -v 17.0.7)
export PATH="/opt/homebrew/opt/llvm@15/bin:$PATH"
export PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home -v17)
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
# export PATH="$JAVA_HOME/bin:$PATH"
# export JAVA_HOME=$(/usr/libexec/java_home -v17)
# export PATH="$JAVA_HOME/bin:$PATH"
# export PATH="$HOME/.local/bin:$PATH"
export HARNESS_GENERATION_PASSPHRASE="00b4b62eeef694e718613aa370ae17dbd2559db46d6d72064c1182612069f835"
OPEN_API_KEY=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
export STACK_DRIVER_LOGGING_ENABLED=false
export NEXT_GEN=true
export HARNESS_LOCAL_DELEGATE=true
export LOG_SERVICE_DISABLE_AUTH=true
export LOG_SERVICE_GLOBAL_TOKEN=token
export LOG_SERVICE_SECRET=secret_key
export SHOULD_CONFIGURE_WITH_PMS=true
#sourcing scripts 
source ~/startui.sh
# Completion
autoload -Uz compinit
compinit -C -d ~/.zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd() { vcs_info }

# ZSH Completion Styling
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

# Tab Completion with Dots
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# ZSH Options
setopt AUTOCD
setopt PROMPT_SUBST
setopt MENU_COMPLETE
setopt LIST_PACKED
setopt AUTO_LIST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt COMPLETE_IN_WORD

# Fancy Prompt with Icons
function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F{black}%f%b"
  else
    echo "%B%F{cyan}%f%b"
  fi
}
PS1='%B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}❯❯%f.%F{red}❯❯)%f%b '

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Terminal Title Hooks
function xterm_title_precmd() {
  print -Pn -- '\e]2;%n@%m %~\a'
}
function xterm_title_preexec() {
  print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
}
if [[ "$TERM" == (kitty*|alacritty*|gnome*|tmux*|xterm*) ]]; then
  add-zsh-hook -Uz precmd xterm_title_precmd
  add-zsh-hook -Uz preexec xterm_title_preexec
fi

# Aliases
alias ls='lsd -a --group-dirs=first'
alias ll='lsd -la --group-dirs=first'
alias cj='z'  # zoxide
alias tf='terraform'
alias ktl='kubectl'
alias cs='colima start --cpu 2 --memory 4 --disk 80 --with-kubernetes'
alias devup='docker-compose -f /Users/himanshusharma/gitops-dev-env/docker/docker-compose.dev.yaml up -d'
alias argoup='kubectl config use-context colima && \
                      kubectl create ns argocd || true && \
                      kubectl config set-context --current --namespace=argocd && \
                      kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.14.14/manifests/install.yaml -n argocd'
alias resumelg='kubectl config use-context colima;kubectl config set-context --current --namespace=argocd;kubectl scale deployments --all --replicas=1 -n argocd;kubectl scale statefulsets --all --replicas=1 -n argocd;docker start docker-harness-postgres-1;docker start docker-harness-redis-1;docker start docker-harness-mongo-1;docker start docker-harness-mongosetup-1;sleep 5;kubectl -n argocd port-forward deployment/argocd-dex-server 5556:5556 > /dev/null  2>&1 &;kubectl -n argocd port-forward deployment/argocd-repo-server 8081:8081 > /dev/null 2>&1 &;kubectl -n argocd port-forward deployment/argocd-server 8080:8080 > /dev/null 2>&1 &;kubectl -n argocd port-forward deployment/argocd-redis 6378:6379 > /dev/null 2>&1 &;kubectl -n argocd port-forward service/argocd-server 30663:443 > /dev/null 2>&1 &'
alias pauselg='kubectl config use-context colima; \
kubectl config set-context --current --namespace=argocd; \
kubectl scale deployments --all --replicas=0 -n argocd; \
kubectl scale statefulsets --all --replicas=0 -n argocd; \
docker stop docker-harness-postgres-1; \
docker stop docker-harness-redis-1; \
docker stop docker-harness-mongo-1; \
docker stop docker-harness-mongosetup-1; \
pkill -f "kubectl.*port-forward.*argocd"'
alias lg='lazygit'
alias upscaleagent='s ns himanshu-test;kubectl scale deployments --all --replicas=1;kubectl scale statefulsets --all --replicas=1'
# zoxide init
eval "$(zoxide init zsh)"

# Bun setup (adjust path if needed)
export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"
# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/himanshusharma/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# nvm
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

########
#
# gitty
#######

gs() {
  local selected
  selected=$(git for-each-ref --sort=-committerdate \
    --format="%(refname:short) | %(objectname:short) | %(subject)" refs/heads/ \
    | fzf --height=20 --reverse --prompt="git switch > " \
          --preview="git log -5 --oneline --color=always \$(echo {} | cut -d'|' -f1)" \
    | cut -d'|' -f1 | xargs)

  if [ -n "$selected" ]; then
    git switch "$selected"
  fi
}
ff() {
  # Run fzf and store the selected path in a local variable named 'file'
  local file
  file=$(fzf --height 80% --layout=reverse --preview 'bat --style=numbers --color=always --line-range :200 {}')

  # If a file was selected (the variable isn't empty), open it in nvim
  # This prevents opening an empty nvim buffer if you press Esc
  [ -n "$file" ] && nvim "$file"
}

# TF config
export TF_LOG=DEBUG
export HARNESS_PLATFORM_API_KEY=pat.1bvyLackQK-Hapk25-Ry4w.67efd8e2b8aab616a9694c78.D6sIe66xsMuqb3dZlcq7
export HARNESS_API_KEY=pat.1bvyLackQK-Hapk25-Ry4w.67efd8e2b8aab616a9694c78.D6sIe66xsMuqb3dZlcq7
export HARNESS_ACCOUNT_ID=bvyLackQK-Hapk25-Ry4w
export HARNESS_ENDPOINT=https://qa.harness.io/gateway

# Added by Windsurf
export PATH="/Users/himanshusharma/.codeium/windsurf/bin:$PATH"
source <(switcher init zsh)
alias s=switch
source <(switch completion zsh)
source <(switch completion zsh)
export PATH=$PATH:$(go env GOPATH)/bin
