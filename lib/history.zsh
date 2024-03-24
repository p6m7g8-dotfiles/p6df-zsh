# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::zsh::history::stats()
#
#>
######################################################################
p6df::modules::zsh::history::stats() {

    history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head

    p6_return_void
}
