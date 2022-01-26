echo Hello Gitpod
echo Here is my .bash_aliases dotfile

alias gitsha='git rev-parse HEAD'
alias python='python3'
alias af="alias-finder"
alias pytest="python -m pytest"
alias switchj8='sdk default java 8.0.282.hs-adpt'
alias switchj11='sdk default java 11.0.10.hs-adpt'
alias switch_spark='sdk default spark'
alias switch_flink='sdk default flink'
# git
alias gcane="git commit -v --amend --no-edit"
alias grsetpo='git remote set-url --push origin'
alias gpom='git push --set-upstream origin master'
alias gcbd='git checkout develop && git pull --all && git checkout -b'
alias gcbm='git checkout master && git pull --all && git checkout -b'
alias gcbr='git checkout release && git pull --all && git checkout -b'
# gh
alias gprd="gh pr create --base develop -f"
alias gprdt="gh pr create --base develop -t'Dev' -f"
alias gprm="gh pr create --base master -f"
alias gprmt="gh pr create --base master -t'Master' -f"
alias gprr="gh pr create --base release -f"
alias gprrt="gh pr create --base release -t'Master' -f"
alias gprdm="git checkout develop && git pull --all && gh pr create --base master --head develop -t'Dev to Master' -f"
alias gprrm="git checkout release && git pull --all && gh pr create --base master --head release -t'Release to Master' -f"
alias gpo="git push --set-upstream origin"
alias gc="git commit -v -a -s -m''"
alias gprmerge="gh pr merge -m --auto -d "
# kubectl
alias kgvsa="kubectl get vs --all-namespaces"
alias kgspark="kubectl get SparkApplication"
alias kdspark="kubectl delete SparkApplication"
alias kg="kg"
alias kghpa="kubectl get hpa"

