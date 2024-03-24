# shellcheck shell=bash

######################################################################
#<
#
# Function: p6df::modules::zsh::state::off()
#
#  Environment:	 ZDOTDIR
#>
######################################################################
p6df::modules::zsh::state::off() {

  p6_file_unlink "${ZDOTDIR}/.zshrc"
  p6_file_unlink "${ZDOTDIR}/.zshenv"
  p6_file_create "${ZDOTDIR}/.zshrc"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::zsh::state::on()
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR ZDOTDIR
#>
######################################################################
p6df::modules::zsh::state::on() {

  p6_file_remove "${ZDOTDIR}/.zshrc"

  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-core/conf/zshrc" "${ZDOTDIR}/.zshrc"
  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-core/conf/zshenv" "${ZDOTDIR}/.zshenv"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::zsh::state::reload()
#
#  Environment:	 PATH
#>
######################################################################
p6df::modules::zsh::state::reload() {

  local pair
  for pair in $(p6_env_list | grep -Ev "^PATH=|P6_DFZ_MODULES|MYSQL_PS1"); do
    local k=$(p6_echo $pair | awk -F= '{print $1}')
    p6_env_export_un "$k"
  done

  exec zsh -li

  # Not reached
  p6_return_void
}
