alias makepass="openssl rand -base64 32"
alias please="sudo !!"
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"

function unpac() {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2) tar xjf $1 ;;
			*.tar.gz) tar xzf $1 ;;
			*.bz2) bunzip2 $1 ;;
			*.rar) rar x $1 ;;
			*.gz) gunzip $1 ;;
			*.tar) tar xf $1 ;;
			*.tbz2) tar xjf $1 ;;
			*.tgz) tar xzf $1 ;;
			*.zip) unzip $1 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*) echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

function pac() {
	if [ $# -lt 2 ]; then
		echo "use $(basename $0) archive.{.tar.gz}{.tgz}{.tar.bz2}{.tbz}{.rar}{.zip}{.tar}{.gz}{.bz2} file(s)"
	else
		case "$1" in
			*.tar.gz | *.tgz ) tar cfvz "$1" $(until [ -z "$2" ]; do echo "$2"; shift; done) ;;
			*.tar.bz2 | *.tbz )	tar cfvj "$1" $(until [ -z "$2" ]; do echo "$2"; shift; done) ;;
			*.zip) zip -r "$1" $(until [ -z "$2" ]; do echo "$2"; shift; done) ;;
			*.rar) rar a "$1" $(until [ -z "$2" ]; do echo "$2"; shift; done) ;;
			*.tar) tar cf "$1" $(until [ -z "$2" ]; do echo "$2"; shift; done) ;;
			*.gz) gzip "$2" > "$1"; shift ;;
			*.bz2) bzip2 "$2" > "$1"; shift ;;
			*) echo Not a valid archive! ;;
		esac
	fi
}

# Poor man's at
function startat() {
	if [ $# -lt 2 ]; then
		echo "Usage: $(basename $0) HH:MM:SS command"
	else
		CURRENTTIME=$(date +%s)
		STARTTIME=$(date --date="$(date +"%b %d $1")" +%s)
		DIFF=$(($STARTTIME - $CURRENTTIME))

		if [ $DIFF -lt 0 ]; then
			DIFF=$((86400+$DIFF))
		fi
		
		echo $(echo "($(date +%H:%M:%S)) Starting \"$2\" in $(($DIFF / 3600 % 60)):$(($DIFF / 60 % 60)):$(($DIFF % 60))")

		sleep $DIFF
		$2
	fi
}