# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$PATH:$HOME/.rvm/gems/ruby-1.9.3-p551/bin" # Add RVM to PATH for scripting
export PATH="$PATH:$HOME/idea-IU-172.3317.76/bin"
export PATH="$PATH:$HOME/android-studio/bin/"
export PATH="$PATH:/media/sf_android-sdk/Sdk/platform-tools/"
export PATH="$PATH:$HOME/node-v8.11.1-linux-x64/bin"
export PATH="$PATH:$HOME/node-v8.11.1-linux-x64/lib/node_modules/node/bin"

export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export ORACLE_BASE=/u01/app/oracle
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
export PATH=$ORACLE_HOME/bin:$PATH

export JAVA_OPTS="-Druntime.environment=local -XX:MaxPermSize=512m"
export GRADLE_OPTS="-Xms1024m -Xmx2048m -XX:MaxPermSize=256m"

export PATH=/opt/gradle-1.3/bin:$PATH

export ANDROID_HOME=/media/sf_android-sdk/Sdk/
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

. /etc/profile.d/git-01color.sh
. /etc/profile.d/git-02prompt.sh

export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export JDK8_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export JDK_HOME=$JDK8_HOME

export ACT_ENV=tst #Which environment out there to target from command line

#alias dataservices='gradle clean jR -Penv=local -PactiveProfile=mock,testhelper'
alias dataservices='JAVA_HOME=$JDK8_HOME ./gradlew -Penv=local -PactiveProfile=mock clean appRunDebug'
alias placementsweb='gradle clean gwtAll jR -Penv=local -PactiveProfile=mock,testhelper -PproductIds=All'
alias auvtxwc='gradle clean gwtAll jR -Penv=local -PactiveProfile=mock,testhelper -PproductIds=AUVTXWC'
alias cdplacementsweb='cd ~/workspace/ATP/products/placements/web/'
alias cddataservices='cd ~/workspace/ATP/services/web/'
alias sqlUpDa='cd ~/workspace/ATP/services/sql/; git checkout master; git pull; gradle upDa'
alias sqldev='~/sqldeveloper/sqldeveloper.sh &'
alias stash='function _stash(){ git remote show origin | grep "Fetch URL:" | cut -d" " -f 5 | xargs google-chrome; };_stash'
alias bitbucket='function _bitbucket(){ git remote show origin | grep "Fetch URL:" | cut -d" " -f 5 | xargs google-chrome; };_bitbucket'
alias jira='function _jira(){ google-chrome "https://aonriskservices.atlassian.net/browse/$1"; };_jira'
alias itwiki='function _itwiki(){ google-chrome "http://itwiki.aonnet.aon.net/dosearchsite.action?queryString=$1"; };_itwiki'
alias svntrunk='function _svntrunk(){ svn co "svn+ssh://fhajdarp@apsyduapt001.aonnet.aon.net/svn/integration/$1/trunk" $1;};_svntrunk'
alias scenario='cd ~/workspace/ATP/products/placements/scenario-test; function _scenario(){ gradle -Dproduct=$1 -Dtarget.env=tst -Dstory=$2 -Dbrowser=firefox clean testBusinessScenario;};_scenario'
alias rmdir='rm -r -f $1'
alias jkill='ps -ef | grep java | cut -c 10-15| xargs kill -9'
alias java6='sudo update-alternatives --config java <<< "1"'
alias java8='sudo update-alternatives --config java <<< "3"'
alias unit='function _unit(){ gradle -Dtest.single=$1 -Penv=local test; };_unit'
alias unittest='function _unit(){ JAVA_HOME=$JDK8_HOME ./gradlew -x compileJava -x compileGroovy -x jacocoTestCoverageVerification -x jacocoTestReport test --tests $1; };_unit'

alias startdb='printf "startup" | sqlplus / as sysdba'
alias gitpullall='for D in INS*; do [ -d "${D}" ] && cd "${D}" && git checkout master && git pull && cd ..; done'
alias gitpass='git config --global credential.helper "cache --timeout 3600"'

alias dststlog='scp fhajdarp@apsydudst002.aonnet.aon.net:/var/log/tomcat8/dataservices.log /tmp'

json() {
    http --verify=no https://atpservices-$ACT_ENV.aonnet.aon.net/dataservices/placements/$1/data
}

aclopen() {
    echo "https://atp$ACT_ENV.aon.com.au/placements/id/$1"
}

aclcreatenz() {
    export productId="$1"
    export clientId="2327749"
    export assignedTo="banderso"
    echo "https://atp$ACT_ENV.aon.com.au/placements/newplacement/createPopulatedPlacement?clientId=$clientId&assignedTo=$assignedTo&productId=$productId&creatorUserId=A0708775&oppSystem=NONE&clientSystem=ODS"
}

monitoring() {
    export auditId=$(http --verify=no https://atpservices-$ACT_ENV.aonnet.aon.net/dataservices/placements/$1/data | jq ".AuditId" | tr -d '"')
    echo "google-chrome https://supporttools-$ACT_ENV/Monitoring/Monitoring.html#Detail?auditId=$auditId"
}

placementwar() {
    cdplacementsweb
    gradle clean war sourceJar testJar -x test -PproductIds=AUVTXWC
    for filename in $(find ~/.gradle/caches -name 'placements-SNAPSHOT.jar'); do
        cp ./build/libs/placements-SNAPSHOT.jar "$filename"
        echo "replaced $filename with the latest built"
    done
    for filename in $(find ~/.gradle/caches -name 'placements-SNAPSHOT-test.jar'); do
        cp ./build/libs/placements-SNAPSHOT-test.jar "$filename"
        echo "replaced $filename with the latest built"
    done
    for filename in $(find ~/.gradle/caches -name 'placements-SNAPSHOT-sources.jar'); do
        cp ./build/libs/placements-SNAPSHOT-sources.jar "$filename"
        echo "replaced $filename with the latest built"
    done
    #for filename in $(find ~/.gradle/caches -name 'placements-SNAPSHOT-test-sources.jar'); do
    #    cp ./build/libs/placements-SNAPSHOT-test-sources.jar "$filename"
    #    echo "replaced $filename with the latest built"
    #done
}

tst_installkeys() {
    ssh-copy-id fhajdarp@apsydudst002.aonnet.aon.net
    ssh-copy-id fhajdarp@apws-autctst01
}

tstdslog() {
    scp fhajdarp@apsydudst002.aonnet.aon.net:/var/log/tomcat8/dataservices.log /tmp/dataservices1.log
    code /tmp/dataservices1.log
}

tstpwlog() {
    # Run this to install keys if gets lost: ssh-copy-id masong@apsyduwst001.apac.aon.bz
    scp masong@apsyduwst001.apac.aon.bz:/aon/tomcat/tst/atp/logs/placements.log /tmp/placements.log
    code /tmp/placements.log
}


HISTCONTROL=ignoredups:erasedups
