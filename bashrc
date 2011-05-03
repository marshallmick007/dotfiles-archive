#!/bin/bash
# .bashrc
# Marshall Mickelson
# Last modified: Sun Nov 7, 2010 01:45AM
# Description: SUPER cross platform edition v. 
# Written to work on both linux boxes and Macs!  Things not working
# are commented.  Stolen from many place and tweaked to work for me.
# Feel free to take all or some if you like it.

if [ "$PS1" ]; then  # If running interactively, then run till fi at EOF:

if [ "$TERM" = "screen" ]; then
    export TERM=xterm
fi


export LS_COLORS="no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;00:cd=40;33;00:or=00;05;37;41:mi=00;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"

#--- custom variables here - you shouldn't need to change anything above here ---#
PROMPT="power"          # sets prompt style.  choices: power or anything else to disable
WTERM="xterm"           # could also be rxvt
INTERFACE="en1"    # sadly, not always eth0, and very annoying to autodetect
NEVER_USE_X="Y"         # override helpful autosetting of use_x when x-server detected
BACKUPDIR="${HOME}/Dropbox/backups" # Backup directory
BACKUPGIT="${HOME}/work/dotfiles"   # dotfiles git directory 
#--- end custom variables, you shouldn't need to change anything below here --#

HOST=$(hostname)        # for host info function
OS=$(uname)             # for resolving pesky os differing switches


#-----------------------------------------------------------
#@ Colors
#-----------------------------------------------------------

#  Black       0;30     Dark Gray     1;30
#  Blue        0;34     Light Blue    1;34
#  Green       0;32     Light Green   1;32
#  Cyan        0;36     Light Cyan    1;36
#  Red         0;31     Light Red     1;31
#  Purple      0;35     Light Purple  1;35
#  Brown       0;33     Yellow        1;33
#  Light Gray  0;37     White         1;37

red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
green='\e[0;32m'
GREEN='\e[1;32m'
purple='\e[0;35m'
PURPLE='\e[1;35m'
yellow='\e[0;33m'
YELLOW='\e[1;33m'
NC='\e[0m' #no color

## Used in echo -e statements
E_PURPLE="\033[0;35m"
E_NC="\033[0m"
E_RED="\033[1;31m"

## From http://wiki.archlinux.org/index.php/Color_Bash_Prompt
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

export LESS_TERMCAP_mb=$'\E[01;35m'
export LESS_TERMCAP_md=$'\E[01;34m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#-----------------------------------------------------------
#@ X DISPLAY settings
#-----------------------------------------------------------
if [ $OS = "Linux" ]; then
   function get_xserver ()
   {
       case $TERM in
           xterm | xterm-color | linux )
               XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
               XSERVER=${XSERVER%%:*}
               ;;
       esac
   }
   if [ -z ${DISPLAY:=""} ]; then
       get_xserver
       if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) || ${XSERVER} == "unix" ]]; then
           export DISPLAY=":0.0"
       else
          export DISPLAY=${XSERVER}:0.0
       fi
   fi
elif [ $OS = 'Darwin' ]; then
   if [[ -z $DISPLAY ]]; then
       disp_no=($( ps -ax | grep X11.app | grep -v grep | awk '{print $9}' ))
       if [[ -n $disp_no ]];then
           export DISPLAY=${disp_no}.0
       else
           export DISPLAY=''
           echo "Not running X-Server"
       fi
   fi
fi
if [[ ! -z $DISPLAY ]]; then
    if [ $NEVER_USE_X != 'Y' ]; then
        USE_X="Y"
        #echo "Using X"
    #else 
        #echo "usage of X prohibited by NEVER_USE_X"
    fi
    if [ $SHLVL = 1 ]; then
        rm -f $HOME/.display
        echo $DISPLAY > $HOME/.display
        echo "DISPLAY has been set to $DISPLAY"
    elif [ $SHLVL -gt 1 ]; then
        if [ -e $HOME/.display ]; then
            DISPLAY_FIX=$(cat $HOME/.display)
            if [ $DISPLAY != $DISPLAY_FIX ]; then
                export DISPLAY=$DISPLAY_FIX
                echo "screen/DISPLAY mismatch detected.  DISPLAY has been adjusted to $DISPLAY"
            fi
        fi
    fi
else
    USE_X="N"
    echo "Not using X"
fi
if [ $NEVER_USE_X = "Y" ]; then
    USE_X="N"
fi

#-----------------------------------------------------------
#@ Setup $HOME
#-----------------------------------------------------------
if [ ! -d "${HOME}/bin" ]; then
    mkdir ${HOME}/bin
    chmod 700 ${HOME}/bin
    echo "${HOME}/bin was missing.  I recreated it for you."
fi
if [ ! -d "${HOME}/Documents" ]; then
    if ! [  -d "${HOME}/data" ]; then
        mkdir ${HOME}/data
        chmod 700 ${HOME}/data
        echo "${HOME}/data was missing.  I recreated it for you."
    fi
fi
if [ ! -d "${HOME}/tmp" ]; then
    mkdir ${HOME}/tmp
    chmod 700 ${HOME}/tmp
    echo "${HOME}/tmp was missing.  I recreated it for you."
fi

if [ ! -d "${BACKUPDIR}" ]; then
	if [ ! -d "${BACKUPDIR}/configs" ]; then
	    mkdir ${BACKUPDIR}/configs
	    chmod 700 ${BACKUPDIR}/configs
	    echo "${BACKUPDIR}/configs was missing.  I recreated it for you."
	fi

	if [ ! -d "${BACKUPDIR}/scripts" ]; then
	    mkdir ${BACKUPDIR}/scripts
	    chmod 700 ${BACKUPDIR}/scripts
	    echo "${BACKUPDIR}/scripts was missing.  I recreated it for you."
	fi
fi

if [ ! -d "${BACKUPGIT}" ]; then
    mkdir ${BACKUPGIT}
    chmod 700 ${BACKUPGIT}
    echo "${BACKUPGIT} was missing.  I recreated it for you."
fi

#-----------------------------------------------------------
#@ Ruby Development
#-----------------------------------------------------------

# This loads RVM into a shell session.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  

source ~/.git-completion.bash


function get_git_branch() {
  echo `git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
}

#-----------------------------------------------------------
#@ Bash settings
#-----------------------------------------------------------
#umask 007
ulimit -S -c 0      # Don't want any coredumps
#set -o notify       # notify when jobs running in background terminate
set -o noclobber    # prevents catting over file
#set -o ignoreeof   # can't c-d out of shell
set -o nounset      # attempt to use undefined variable outputs error message and forces exit
#set -o xtrace      # useful for debuging
bind 'C-u:kill-whole-line'                      # Ctrl-U kills whole line
bind 'set bell-style visible'                   # No beeping
#bind 'set horizontal-scroll-mode on'           # Don't wrap
bind 'set show-all-if-ambiguous on'             # Tab once for complete
bind 'set visible-stats on'                     # Show file info in complete

#-----------------------------------------------------------
#@ Enable options:
#-----------------------------------------------------------
shopt -s cdspell         # auto fixes cd / spelling mistakes
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -u mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion  # bash>=2.04 only
shopt -s histappend histreedit histverify
shopt -s extglob    # necessary for programmable completion

stty stop undef
stty start undef

#-----------------------------------------------------------
#@ Aliases
#-----------------------------------------------------------

# Enable Bashmarks

source ~/bin/bashmarks.sh

if [ -f dircolors ]; then
    eval `dircolors -b`
fi
if [ $OS = "Linux" ]; then
    alias ls='ls --color=auto -h'
elif [ $OS = "Darwin" ]; then
    alias ls='ls -G'
fi


alias gpull='git pull origin `get_git_branch`'
alias gpush='git push origin `get_git_branch`'



alias htop="htop --sort-key PERCENT_CPU"
#alias ..="cd .."
#alias c="clear"
# alias cp="cp -i"
alias df="df -h"
alias du="du -h"
alias lh="ls -lh .[a-zA-Z0-9]*"
alias ll="ls -lh"
alias lla="ls -lha"
alias ls="ls -h"
#alias m="~/bin/motd.pl"
#alias me="vi ~/.muttrc"
alias mkdir="mkdir -p"
alias mv="mv -i"
#alias newpw="pwgen --no-capitalize"
#alias path="env | grep PATH"
#alias pcd="cd -"
#alias pe="vi ~/.procmailrc"
#alias pico="vi"
alias ps="ps aux"
# alias prime="perl -wle 'print "Prime" if (1 x shift) !~ /^1?$|^(11+?)\1+$/' "
#alias rl="source $HOME/.bashrc"
alias rm="rm -i"
#alias se="vi ~/.screenrc"
#alias showx="echo USE_X current status = $USE_X"
#alias sr="screen -d -RR"
#alias sx="screen -x"
#alias tc="tar cfvz"
#alias tx="tar xfvz"
#alias upgrade="apt-get update;apt-get upgrade -y"
#alias ve="vi ~/.vimrc"
alias vi="mvim"
alias vim="mvim"

alias HEX="ruby -e 'printf(\"0x%X\n\", ARGV[0])'"
alias DEC="ruby -e 'printf(\"%d\n\", ARGV[0])'"
alias BIN="ruby -e 'printf(\"%bb\n\", ARGV[0])'"
alias WORD="ruby -e 'printf(\"0x%04X\n\", ARGV[0])'"


# Get readable list of network IPs
#alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias flush="dscacheutil -flushcache" # Flush DNS cache

#-----------------------------------------------------------
#@ PATH
#-----------------------------------------------------------
if [ "$UID" -eq 0 ]; then
    PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
fi
PATH=$PATH:$HOME/bin:/opt/local/bin


#-----------------------------------------------------------
#@ STARTUP
#-----------------------------------------------------------
if [ -e "/usr/bin/uptime" ]; then
    echo "Uptime: ` /usr/bin/uptime`"
fi

#-----------------------------------------------------------
#@ EXPORTS
#-----------------------------------------------------------

# copy from somewhere, don't know how it works
# remove duplicate path
export PATH=$(echo $PATH | awk -F: '
{ for (i = 1; i <= NF; i++) arr[$i]; }
END { for (i in arr) printf "%s:" , i; printf "\n"; } ')

# Misc Variables
export EDITOR="mate"
export VISUAL="mate"
export HISTCONTROL=ignoredups
export HOSTFILE=$HOME/.hosts
export PAGER=less

if [ -d $HOME/Maildir/ ]; then
    export MAIL=$HOME/Maildir/
    export MAILPATH=$HOME/Maildir/
    export MAILDIR=$HOME/Maildir/
elif [ -f /var/mail/$USER ]; then
    export MAIL="/var/mail/$USER"
fi

#-----------------------------------------------------------
#@ PS1 PROMPT
#-----------------------------------------------------------

#PS1 function
function host_load()
{
	THRESHOLD_MED=33
    THRESHOLD_HIGH=66
    COLOR_LOW=$GREEN
	COLOR_MED=$YELLOW
    COLOR_HIGH=$RED

    if [ $OS = "Linux" ]; then
        ONE=$(uptime | sed -e "s/.*load average: \(.*\...\),\(.*\...\),\(.*\...\)/\1/" -e "s/ //g")
    fi
    if [ $OS = "Darwin" ]; then
        ONE=$(uptime | sed -e "s/.*load averages: \(.*\...\)\(.*\...\)\(.*\...\)/\1/" -e "s/ //g")
    fi
    ONEHUNDRED=$(echo -e "scale=0 \n $ONE/0.01 \nquit \n" | bc)
    if [ $ONEHUNDRED -gt $THRESHOLD_HIGH ]; then
    	HOST_COLOR=$COLOR_HIGH
		LOAD_PROMPT="###"
	elif [ $ONEHUNDRED -gt $THRESHOLD_MED ]; then
		HOST_COLOR=$COLOR_MED
		LOAD_PROMPT="##-"
    else
        HOST_COLOR=$COLOR_LOW 
		LOAD_PROMPT="#--"
    fi
}

function git_prompt()
{
	GIT_BRANCH_EVAL=`(__git_ps1 " (%s)")`
	GIT_BRANCH_EVAL=$(echo $GIT_BRANCH_EVAL)
	GIT_PROMPT=""
	if [ "$GIT_BRANCH_EVAL" != "" ]; then
		GIT_PROMPT="-[${GREEN}\]\[${yellow}\]git:\[${GIT_BRANCH_EVAL}\]\[${GREEN}\]]"
	fi
}

vim_pwd()
{
  _pwd=`pwd | sed "s#$HOME#~#"`
  if [[ $_pwd == "~" ]]; then
    _vimdirname=$_pwd
  else
    _vimdirname=`dirname "$_pwd" | sed -E "s/\/(.)[^\/]*/\/\1/g"`
    if [[ $_vimdirname == "/" ]]; then
      _vimdirname=""
    fi
    _vimdirname="$_vimdirname/`basename "$_pwd"`"
  fi
  NEW_PWD=$_vimdirname
}


short_pwd()
{
    # How many characters of the $PWD should be kept
    local pwdmaxlen=35
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        # NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        # NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
        vim_pwd
    fi
}

function power_prompt()
{
    host_load
    set_xtitle
	git_prompt
	short_pwd
    if [ "$UID" -eq 0 ]; then
        PS1="[\[${HOST_COLOR}\]\t\[${NC}\]][\[${red}\]\u@\h:\w >\[${NC}\] "
    else
        #PS1="[\[${HOST_COLOR}\]\t\[${NC}\]] \[${cyan}\]\u\[${NC}\]@\[${red}\]\h\[${NC}\]:\w > "
		
		PS1="\n\[${HOST_COLOR}\]${LOAD_PROMPT}\[${GREEN}\][\[${blue}\]\u@\h\[${GREEN}\]]-[\[${purple}\]\${NEW_PWD}\[${GREEN}\]]-[\[${green}\]\$(date +%k:%M)\[${GREEN}\]]\[${GIT_PROMPT}\]\n\[${GREEN}\]#\[${GREEN}\]:>\[${NC}\] "
    fi
}
if [ $PROMPT = "power" ]; then
    PROMPT_COMMAND=power_prompt
else
    if [ "$UID" -eq 0 ]; then
        PS1="[\t][\[${red}\]\u@\h:\w]\$\[${NC}\] "
    else
        #PS1="[\t][\[${cyan}\]\u\[${NC}\]@\[${red}\]\h\[${NC}\]:\w]\$ "
		PS1="\n#--[\[${blue}\]\u@\h\[${NC}\]]-[\[${purple}\]\w\[\e[m\]]-[\$(date +%k:%M)]\n#:> "
    fi
fi

function set_xtitle()
{
    if [ $TERM == "xterm" ]; then
        echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"
    fi
}

#-----------------------------------------------------------
#@ FUNCTIONS
#-----------------------------------------------------------

# iTerm2 growl support
growl() { echo -e $'\e]9;'${1}'\007' ; return  ; }

# Functions
function _exit()
{
    echo -e "${RED}So long and thanks for all the fish${NC}"
}
trap _exit EXIT

function sendrc()
{
    scp ~/.bashrc $1:~/.bashrc
    scp ~/.profile $1:~/.profile
}

function sync()
{
	sendrc $1
	scp ~/Library/Safari/Bookmarks.plist $1:~/Library/Safari/Bookmarks.plist
}

function sendbashrc()
{
    scp ~/.bashrc $1:~/.bashrc.$HOST
}

# Cool History Summerizer
historyhawk()
{ 
	history|awk '{a[$2]++}END{for(i in a){printf"%5d\t%s\n",a[i],i}}'|sort -nr|head; 
}

function term()
{
    CUSTTERM="$WTERM -tn xterm +sb -bg black -fg white -sl 1000 -geometry 150x55"
    if [ $# -eq 0 ]; then
        $CUSTTERM &
    else
        $CUSTTERM -e $* &
    fi
}

function togglex()
{
    if [ $USE_X = 'Y' ]; then
        USE_X='N'
        echo "Stop using X..."
    elif [ $USE_X = 'N' ]; then
        USE_X='Y'
        echo "Start using X..."
    fi
}

function psg()
{
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then  # cool way to find null $1.  also can use $# -eq 0
        echo grep running processes
        echo usage: psg [process]
    else                
        ps -aux | grep USER | grep -v grep
        ps -aux | grep -i $1 | grep -v grep
    fi      
}

function lsofg()
{
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo grep lsof
        echo usage: losfg [port/program/whatever]
    else
        lsof | grep -i $1 | less
    fi
}

function ls-net()
{
    lsof -nPi | cut -f 1 -d " "| uniq | tail -n +2
}

function wiki()
{
  dig +short txt $1.wp.dg.cx
}

# mkdir, cd into it
mkcd () {
    mkdir -p "$*"
    cd "$*"
}

function serve() 
{ 
	python -m SimpleHTTPServer ${1:-8080} 
} 

function whoisg() # query for domain status
{
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo grep whois lookups for status
        echo usage: whoisg [domain name]
    else
        whois $1 | grep -i -B 3 -A 3 status
    fi
}

function ds()  # invalid du option on mac
{
    echo 'size of directories in MB'
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo 'you did not specify a directy, using pwd'
        DIR=$(pwd)
        find $DIR -maxdepth 1 -type d -exec du -sm \{\} \; | sort -nr
    else
        find $1 -maxdepth 1 -type d -exec du -sm \{\} \; | sort -nr
    fi
}

function repeat()
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
    eval "$@";
    done
}

function my_ip()  # sucky.  interface must be hardcoded.  needs work
{
    MY_IP=$(/sbin/ifconfig $INTERFACE | awk '/inet / { print $2 } ' | sed -e s/addr://)
}

function ii()  # get current host related info  # kind of works on mac.  different interface.  dynamic-able?
{
    echo -e "\nYou are logged onto ${E_PURPLE}$HOST"
    echo -e "\n${E_PURPLE}Additionnal information:${E_NC} " ; uname -a
    echo -e "\n${E_PURPLE}Users logged on:${E_NC} " ; w -h
    echo -e "\n${E_PURPLE}Current date :${E_NC} " ; date
    echo -e "\n${E_PURPLE}Machine stats :${E_NC} " ; uptime
    echo -e "\n${E_PURPLE}Disk space :${E_NC} " ; df
    echo -e "\n${E_PURPLE}Memory stats :${E_NC} " ;
	if [ "$OS" = "Linux" ]; then
		free -m
	elif [ "$OS" = "Darwin" ]; then
		vm_stat
	fi
    my_ip 2>&- ;
    echo -e "\n${E_PURPLE}Local IP Address :${E_NC}" ; echo ${MY_IP:-"Not connected"}
    echo
}

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }  # works
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }  # doesn't work on mac. iilegal option -f

function www()
{
    if [ $USE_X = 'Y' ]; then
        if [ $OS = 'Linux' ]; then
            term elinks http://$1
        elif [ $OS = 'Darwin' ]; then
            term lynx http://$1
        else 
            echo "Unknown OS"
        fi
    else
        if [ $OS = 'Linux' ]; then
            elinks http://$1 
        elif [ $OS = 'Darwin' ]; then
            open -a Safari http://$1
        else 
            echo "Unknown OS"
        fi
    fi
}

function gg()
{
    echo "searching google for $*"
    SEARCH=$(echo $* | sed -e 's/ /\%20/g')
    echo "translating search to URL speak...  $SEARCH"
    www www.google.com/search?q="$SEARCH"
}

function ff() { find . -name '*'$1'*' ; }  # find a file  # works
function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }  # find a file and run $2 on it  # works

function show-archive()  # not tested on mac
{
    if [ -f $1 ]; then
        case $1 in
            *.tar.gz)   gunzip -c $1 | tar -tf - -- ;;
            *.tar)      tar -tf $1 ;;
            *.tgz)      tar -ztf $1 ;;
            *.zip)      unzip -l $1 ;;
            *)      echo "'$1' Error. Please go away" ;;
        esac
    else
        echo "'$1' is not a valid archive"
    fi
}

function gojo()  # gojo - tries to unarchive anything thrown at it  # not tested on mac
{
    ##### Probably done more robustly with file(1) but not as easily
    local FILENAME="${1}"
    local FILEEXTENSION=`echo ${1} | cut -d. -f2-`
    case "$FILEEXTENSION" in
        tar)
            tar xvf "$FILENAME";;
        tar.gz)
            tar xzvf "$FILENAME";;
        tgz)
            tar xzvf "$FILENAME";;
        gz)
            gunzip "$FILENAME";;
        tbz)
            tar xjvf "$FILENAME";;
        tbz2)
            tar xjvf "$FILENAME";;
        tar.bz2)
            tar xjvf "$FILENAME";;
        tar.bz)
            tar xjvf "$FILENAME";;
        bz2)
            bunzip2 "$FILENAME";;
        tar.Z)
            tar xZvf "$FILENAME";;
        Z)
            uncompress "$FILENAME";;
        zip)
            unzip "$FILENAME";;
        rar)
            unrar x "$FILENAME";;
    esac
}

function private()
{
    find $HOME -type d -exec chmod 700 {} \;
    find $HOME -type f -exec chmod 600 {} \;
    find $HOME/bin -type f -exec chmod +x {} \;
    public
}

function public()
{
    if [ -d $HOME/public_html ]; then
        chown -R $USER:www-data $HOME/public_html
        chmod 755 $HOME/public_html
        find $HOME/public_html/ -type d -exec chmod 775 {} \;
        find $HOME/public_html/ -type f -exec chmod 664 {} \;
        chmod 755 $HOME
    fi
}

function lowercase()  # move filenames to lowercase  # not working on mac
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
            */*) dirname==${file%/*} ;;
            *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

function jquery()
{
	curl http://code.jquery.com/jquery-1.5.min.js > jquery.js
}

function rot13()
{
    if [ $# -eq 0 ]; then
        tr '[a-m][n-z][A-M][N-Z' '[n-z][a-m][N-Z][A-M]'
    else
        echo $* | tr '[a-m][n-z][A-M][N-Z' '[n-z][a-m][N-Z][A-M]'
    fi
}

# command line *list tools.  Primarily accomplished from within mutt with
# macros, though.  see muttrc macros.
function whitelist()
{
    echo $1 >> $HOME/.pmdata/whitelist
    echo "$1 has been added to the whitelist"
}

function blacklist()
{
    echo $1 >> $HOME/.pmdata/blacklist
    echo "$1 has been added to the blacklist"
}

function bouncelist()
{
    echo $1 >> $HOME/.pmdata/bouncelist
    echo "$1 has been added to the bouncelist"    
}

function bashrc_edit()
{
    mvim ~/.bashrc
}

function restart_pow()
{
    echo "*** Stopping the Pow server..."
    launchctl unload "$HOME/Library/LaunchAgents/cx.pow.powd.plist" 2>/dev/null || true
    echo "*** Starting the Pow server..."
    launchctl load "$HOME/Library/LaunchAgents/cx.pow.powd.plist" 2>/dev/null
    echo "Done"
}

function clean_downloads()
{
    ~/bin/sweep.rb ~/Downloads
}

function backupbash()
{
	BPATH="${HOME}${BACKUPDIR}"
	if [ -d "${BPATH}" ]; then
		echo "Backing up .bashrc to ${BPATH}/bashrc"
		cp ~/.bashrc ${BPATH}/bashrc
	else
		echo "Backup directory ${BPATH} does not exist!"
	fi
}

function backupconfigs()
{
	echo -e "${E_PURPLE}Backing up config files to ${BPATH}${E_NC}"
	BPATH="${BACKUPDIR}/configs"
	if [ -d "${BPATH}" ]; then
		echo "Backing up .bashrc to ${BPATH}/bashrc"
		cp ~/.bashrc ${BPATH}/bashrc
		echo "Backing up .gitconfig to ${BPATH}/gitconfig"
		cp ~/.gitconfig ${BPATH}/gitconfig
		echo "Backing up .inputrc to ${BPATH}/inputrc"
		cp ~/.inputrc ${BPATH}/inputrc
		echo "Backing up .profile to ${BPATH}/profile"
		cp ~/.profile ${BPATH}/profile
		echo "Backing up hosts file to ${BPATH}/hosts"
		cp /etc/hosts ${BPATH}/hosts
		echo "Backing up httpd.conf file to ${BPATH}/httpd.conf"
		cp /Applications/MAMP/conf/apache/httpd.conf ${BPATH}/httpd.conf
        echo "Backing up Pentadactyl configuration"
        cp ~/.pentadactylrc ${BPATH}/pentadactylrc
        echo "Backing up .rvmrc file to ${BPATH}/rvmrc"
        cp ~/.rvmrc ${BPATH}/rvmrc
        echo "Backing up VIM"
        cp ~/.vim/vimrc ${BPATH}/vim/vimrc
        cp ~/.vim/gvimrc ${BPATH}/vim/gvimrc
        cp ~/.vim/README.markdown ${BPATH}/vim/README.markdown
        cp ~/.vimrc.local ${BPATH}/vimrc.local
        cp ~/.gvimrc.local ${BPATH}/gvimrc.local

        echo -e "${E_PURPLE}Dumping dot files to github dropbox. ${BACKUPGIT}${E_NC}"
        cp -Rv ${BPATH}/* ${BACKUPGIT}
        echo -e "${E_RED}Don't forget to git commit the files in ${BACKUPGIT}${E_NC}"
	else
		echo "Backup directory ${BPATH} does not exist!"
	fi
}

function backupscripts()
{
	BPATH="${BACKUPDIR}/scripts"
	if [ -d "${BPATH}" ]; then
		echo -e "${E_PURPLE}Backing up ~/bin folder to ${BPATH}${E_NC}"
		cp -v ~/bin/* ${BPATH}
	else
		echo "Backup directory ${BPATH} does not exist!"
	fi
}

function backup1pass()
{
	echo -e "${E_PURPLE}Backing up 1Password keychain${BPATH}${E_NC}"
	if [ -f ~/bin/backup1pass.py ]; then
		~/bin/backup1pass.py
	else
		echo "Unable to backup 1Password"
	fi
}

function backup()
{
	#TODO: 	Backup CyberDuck bookmarks
	#		Backup GlimmerBlocker settings
	#		GPG Public Key
	#		1Password backup integration
	#		Source Code
	#		Select Documents
	backupscripts
	backupconfigs
	backup1pass
}

function _help()
{
	echo -e "[${E_PURPLE}backup${E_NC}]        - Performs all known backup operations"
	echo -e "[${E_PURPLE}backupconfigs${E_NC}] - Copies a select set of .config files to a backup directory"
	echo -e "[${E_PURPLE}backupscripts${E_NC}] - Copies the contents of ~/bin to a backup directory"
	echo -e "[${E_PURPLE}ii${E_NC}]            - Generates a system 'report' of the current machine stats"
	echo -e "[${E_PURPLE}mkcd${E_NC}]          - Creates a directory and cd's into it"
	echo -e "[${E_PURPLE}historyhawk${E_NC}]   - Bash history summary"
	echo -e "[${E_PURPLE}serve${E_NC}]         - Starts Python's SimpleHTTPServer using the specified directory"  # no description should be longer than this one!
    echo -e "[${E_PURPLE}bashmarks (s, g, l)${E_NC}] - Creates aliases for folders for easy cd'ing"  # no description should be longer than this one!
		
}

fi  #end interactive check
