# Include the current git branch in the terminal window title
# Defaults to `user@hostname:current_dir` if the branch cannot be derived
branch_win_title() {
    # check if current dir is a git repository
    $(git branch --show-current > /dev/null 2>&1)
 
    if [[ $? -eq 0 ]]; then
         # repository name and current git branch
	 # sample: my-awesome-git-repo - [master]
         echo "$(basename `git rev-parse --show-toplevel`) - ["$(git branch --show-current)"]"
    else
         # username@hostname and current directory
	 # sample: user@home:/home/user
         echo "${USER}@${HOSTNAME}:$(pwd)"
    fi
}
 
# add git branch info to PS1 and window title (specific to bash)
# see https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x264.html
PROMPT_COMMAND='echo -ne "\033]0;$(branch_win_title)\007"'