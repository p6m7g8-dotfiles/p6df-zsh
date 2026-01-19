# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::zsh::profile::on(name)
#
#  Args:
#	name -
#
#  Environment:	 EPOCHREALTIME PS4
#>
######################################################################
p6df::modules::zsh::profile::on() {
    local name="$1"

    zmodload zsh/datetime
    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '
    export PS4

    local logfile
    logfile=$(mktemp "$name-zsh.XXXXXXXX")
    echo "Logging to $logfile"
    exec 3>&2 2>"$logfile"

    setopt XTRACE
    set -x
}

######################################################################
#<
#
# Function: p6df::modules::zsh::profile::off()
#
#  Environment:	 PS4
#>
######################################################################
p6df::modules::zsh::profile::off() {

    set +x
    unsetopt XTRACE

    PS4='+%N:%i>'
    export PS4

    exec 2>&3 3>&-
}
