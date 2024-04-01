# git
alias gc="git checkout"
alias ga="git add ."
alias gcm="git commit -m"
alias gpl="git pull"
alias gps="git push"


# gclp: 克隆一个git仓库。如果仓库的URL以https://github.com/开头，它会先开启代理，然后克隆仓库，最后关闭代理。
# 使用方法: gclp <repository> [directory]
# <repository> 是要克隆的仓库的URL。
# [directory] 是可选的，是克隆仓库的目标目录。如果没有提供，将使用仓库的名称作为目标目录。
gclp() {
	if [ $# -lt 1 ]; then
		echo "Usage: gclp <repository> [directory]"
		return 1
	fi

	local repo=$1
	local dir=$2

	if [[ $repo == https://github.com/* ]]; then
		proxy
	fi

	if [ -z "$dir" ]; then
		dir=$(basename $repo .git)
	fi

	git clone $repo $dir

	if [[ $repo == https://github.com/* ]]; then
		unproxy
	fi
}


# 函数用于提交并推送Git仓库的更改
# 使用方法: gcpu <commit-message>
# 参数:
#   - commit-message: 提交的信息
# 返回:
#   - 如果提交和推送成功，返回0
#   - 如果缺少提交信息，返回1
gcpu() {
    if [ $# -lt 1 ]
    then
        echo "使用方法: gcpu <commit-message>"
        return 1
    fi

    local commit_message=$1

    git add .
    git commit -m "$commit_message"
    git push
}


# gbrm: 删除一个git分支。如果提供了-r参数，它也会删除远程分支。
# 使用方法: gbrm <branch> [-r]
# <branch> 是要删除的分支的名称。
# [-r] 是可选的，如果提供，将同时删除远程分支。
gbrm() {
  if [ $# -lt 1 ]
  then
    echo "Usage: gbrm <branch> [-r]"
    return 1
  fi

  local branch=$1
  local remote=$2

  git branch -d $branch

  if [ "$remote" = "-r" ]
  then
    git push origin --delete $branch
  fi
}
