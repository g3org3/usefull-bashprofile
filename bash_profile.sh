
docker-clean() {
    echo "Removing unused containers..."
    docker rmi `docker images | grep none | awk '{print $3}'`;
    docker rm `docker ps -a | grep Exited | awk '{print $1}'`;
    docker rm `docker ps -a | grep Created | awk '{print $1}'`;
    docker rm `docker ps -a | grep Dead | awk '{print $1}'`;

    echo "Cleaning... volumes"
    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock:ro -v /var/lib/docker:/var/lib/docker martin/docker-cleanup-volumes
}

push() {
	remote="origin";
	branch="master";

	if [[ -n "$1" ]]; then
		if [[ "$1" -ne "_" ]]; then
			remote=$1
		fi
	fi

	if [[ -n "$2" ]]; then
		branch=$2
	else
        branch=`gib | grep \* | awk '{print$2}'`
    fi

	echo "git push -u "$remote" "$branch" --tags";
	# git push -u $remote $branch --tags;
}
pull() {
	remote="origin";
	branch="master";

	if [[ -n "$1" ]]; then
		if [[ "$1" -ne "_" ]]; then
			remote=$1
		fi
	fi

	if [[ -n "$2" ]]; then
        branch=$2
    else
        branch=`gib | grep \* | awk '{print$2}'`
    fi

	echo "git pull "$remote" "$branch" --tags";
	# git pull $remote $branch --tags;
}

# Aliases
alias dc='docker-compose'
alias gis='git status';
alias gic='git checkout';
alias gib='git branch';
