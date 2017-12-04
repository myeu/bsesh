export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PS1="\[\033[00;36m\]\w\[\033[00m\] \[\033[00;35m\][\D{%a %b %d %H:%M:%S}]$ \[\033[00m\]"

alias ll='ls -lart'
alias lst='ls -lart| tail'

export HISTSIZE="10000"
export HISTFILESIZE=""
export HISTTIMEFORMAT="%y-%m-%d %T "
export HISTFILE=/home/$USER/.my_bash_history
# save commands to history right away instead of after shell closes
#shopt -s histappend
#PROMPT_COMMAND="history -a;$PROMPT_COMMAND"


# save all commands to a special history file that updates after each command
# regular bash history works as default
log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$
  ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  # only save non repeats
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "||" "$command_part" >> ~/.hist/persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
    if $RECORD_SESH                                                                   # save session commands to special file
    then
        if [[ "$command_part" != "sn"* ]]
        then
            echo $date_part "||" "$GITSESH" "||" "$VENVSESH" "||" "$command_part" >> ${SESHPATH}
        fi
    fi
  fi
}

PROMPT_COMMAND="run_on_prompt_command"

export SESHDATE=`date +"%Y-%m-%d"`
export SESH=""
export SESHPATH=""
export RECORD_SESH=false
export GITSESH=""
export VENVSESH=""

# make an eye catching note in the session history file
sn() {
    if $RECORD_SESH
    then
        echo "<<#>><<#>><<#>><<#>><<#>><<#>><<#>> "  >> ${SESHPATH}
        echo "<<#>><<#>><<#>><<#>><<#>><<#>><<#>> "$@  >> ${SESHPATH}
        echo "<<#>><<#>><<#>><<#>><<#>><<#>><<#>> "  >> ${SESHPATH}
    else
        echo "no session"
    fi
}

setgitsesh() {
    if [ $1 == "none" ]
    then
        GITSESH=""
    else
        GITSESH=$1
    fi
}

setvenvsesh() {
    if [ $1 == "none" ]
    then
        VENVSESH=""
    else
        VENVSESH=$1
    fi
}

# starts a new session
namesesh() {
    if [ $# -ne 1 ]
    then
        echo "ERROR: must supply session name"
    else
        SESH=$1
        RECENTSESH=$SESH
        RECORD_SESH=true
        SESHPATH="/Users/marisayeung/.hist/"${SESHDATE}"-"${SESH}
        if [ -e $SESHPATH ]
        then
            echo "ok - appending"
        else
            echo "ok"
        fi
    fi
}

# start a new file with new date but same session name
newseshdate() {
    if $RECORD_SESH
    then
        SESHDATE=`date +"%Y-%m-%d"`
        SESHPATH="/Users/marisayeung/.hist/"${SESHDATE}"-"${SESH}
    else
        echo "no session"
    fi
}

endsesh() {
    RECORD_SESH=false
    SESHPATH=""
    VENVSESH=""
    GITSESH=""
    SESH=""
}

# check session history
seshh() {
    if $RECORD_SESH
    then
        less $SESHPATH
    else
        echo "no session"
    fi
}

# get session name and/or help info
sesh() {
    if $RECORD_SESH
    then
         echo $SESH
    else
         echo "no session"
    fi
    if [[ $# -eq 1 && $1 == "-h" ]]
    then
        echo "start a session for recording history"
        echo "sessh:                    view session history"
        echo "namesesh <name>:          start a new session, in ~/.hist/<date>-<name>"
        echo "sn <notes>:               add a note with special eye grabbing lines"
        echo "setgitsesh <git branch>:  add a branch name to future lines"
        echo "setvenvsesh <venv>:       add venv name to future lines"
        echo "newseshdate:              start a new file, diff date same session name"
        echo "endsesh:                  stop recording the session"
    fi
}

# future work: update session venv when calling sworkon, update session git branch when checking out etc

# Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}

export WORKON_HOME=$HOME/.virtualenvs
alias sworkon='source /usr/local/bin/virtualenvwrapper.sh'
alias sworkonsd='sworkon; workon simpledata-python'
