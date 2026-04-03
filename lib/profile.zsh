# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::zsh::profiling::on(name)
#
#  Args:
#	name -
#
#  Environment:	 EPOCHREALTIME PS4
#>
######################################################################
p6df::modules::zsh::profiling::on() {
    local name="$1"

    zmodload zsh/datetime
    setopt PROMPT_SUBST
    PS4='+$EPOCHREALTIME %N:%i> '
    p6_env_export "PS4" "$PS4"

    local logfile
    logfile=$(mktemp "$name-zsh.XXXXXXXX")
    p6_msg "Logging to $logfile"
    exec 3>&2 2>"$logfile"

    setopt XTRACE
    set -x
}

######################################################################
#<
#
# Function: p6df::modules::zsh::profiling::off()
#
#  Environment:	 PS4
#>
######################################################################
p6df::modules::zsh::profiling::off() {

    set +x
    unsetopt XTRACE

    PS4='+%N:%i>'
    p6_env_export "PS4" "$PS4"

    exec 2>&3 3>&-
}
