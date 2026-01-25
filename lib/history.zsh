# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::zsh::history::stats()
#
#>
######################################################################
p6df::modules::zsh::history::stats() {

    history 0 | p6_filter_column_pluck 2 | p6_filter_aggregate_map_reduce | p6_filter_sort_numeric_reverse | p6_filter_row_first 10

    p6_return_void
}
