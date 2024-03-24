# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::zsh::fpath::current()
#
#  Environment:	 FPATH
#>
######################################################################
p6df::modules::zsh::fpath::current() {

    p6_vertical "$FPATH"

    p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::zsh::fpath::if(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6df::modules::zsh::fpath::if() {
    local dir="$1"

    if p6_dir_exists "$dir"; then
        fpath+=($dir)
    fi

    p6_return_void
}
