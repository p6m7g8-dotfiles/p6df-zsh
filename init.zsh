# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6df::modules::zsh::deps()
#
#>
######################################################################
p6df::modules::zsh::deps() {
	ModuleDeps=(
		p6m7g8-dotfiles/p6common

		zsh-users/zsh-completions
		zsh-users/zsh-syntax-highlighting
		zsh-users/zsh-history-substring-search
		zsh-users/zsh-autosuggestions

		hlissner/zsh-autopair
#		zdharma/fast-syntax-highlighting # XXX: complex install

		sorin-ionescu/prezto:modules/history

		ohmyzsh/ohmyzsh:lib/diagnostics

		zplug/zplug
	)
}

######################################################################
#<
#
# Function: p6df::modules::zsh::external::yum()
#
#>
######################################################################
p6df::modules::zsh::external::yum() {

  sudo yum install zsh
}

######################################################################
#<
#
# Function: p6df::modules::zsh::external::brew()
#
#>
######################################################################
p6df::modules::zsh::external::brew() {

  brew install zsh
  brew install zmap
  brew install zshdb
  brew install zssh
  brew install zsync
}

######################################################################
#<
#
# Function: p6df::modules::zsh::home::symlink()
#
#  Environment:	 XXX
#>
######################################################################
p6df::modules::zsh::home::symlink() {

  # XXX: .zshenv .zshrc here or there?
}

######################################################################
#<
#
# Function: p6df::modules::zsh::init()
#
#  Environment:	 HISTFILE P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::zsh::init() {

  p6_env_export HISTFILE="$__p6_dir/share/.zhistory"

  p6df::core::path::cd::if "$P6_DFZ_SRC_DIR/ohmyzsh/ohmyzsh/plugins"
  
  p6df::modules::zsh::zplug::init
  p6df::modules::zsh::hooks::init
  p6df::modules::zsh::colors::init
  p6df::modules::zsh::comp::init
}

######################################################################
#<
#
# Function: p6df::modules::zsh::zplug::init()
#
#  Environment:	 ZPLUG_HOME
#>
######################################################################
p6df::modules::zsh::zplug::init() {

  p6_env_export "ZPLUG_HOME" "$P6_DFZ_SRC_DIR/zplug/zplug"
  p6_file_load "$ZPLUG_HOME/init.zsh"
}

######################################################################
#<
#
# Function: p6df::modules::zsh::hooks::init()
#
#>
######################################################################
p6df::modules::zsh::hooks::init() {

  autoload -Uz add-zsh-hook
}

######################################################################
#<
#
# Function: p6df::modules::zsh::colors::init()
#
#>
######################################################################
p6df::modules::zsh::colors::init() {

  autoload -U colors && colors
}

######################################################################
#<
#
# Function: p6df::modules::zsh::comp::init()
#
#>
######################################################################
p6df::modules::zsh::comp::init() {``

  autoload -Uz compaudit
  compaudit
  autoload -Uz compinit
  compinit -C -d $__p6_dir/share/.zcompdump
}

######################################################################
#<
#
# Function: p6df::modules::zsh::off()
#
#  Environment:	 ZDOTDIR
#>
######################################################################
p6df::modules::zsh::off() {

  p6_file_unlink "${ZDOTDIR}/.zshrc"
  p6_file_unlink "${ZDOTDIR}/.zshenv"
  p6_file_create "${ZDOTDIR}/.zshrc"
}

######################################################################
#<
#
# Function: p6df::modules::zsh::on()
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR ZDOTDIR
#>
######################################################################
p6df::modules::zsh::on() {

  p6_file_remove "${ZDOTDIR}/.zshrc"
  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-core/conf/zshrc" "${ZDOTDIR}/.zshrc"
  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-core/conf/zshenv" "${ZDOTDIR}/.zshenv"
}

######################################################################
#<
#
# Function: p6df::modules::zsh::reload()
#
#  Environment:	 PATH
#>
######################################################################
p6df::modules::zsh::reload() {

  local pair 
  for pair in $(p6_env_list | grep -Ev "^PATH=|P6_DFZ_MODULES|MYSQL_PS1"); do
    local k=$(echo $pair | awk -F= '{print $1}')
    p6_env_export_un "$k"
  done

  exec zsh -li
}

######################################################################
#<
#
# Function: str info = p6df::modules::zsh::std::prompt::line()
#
#  Returns:
#	str - info
#
#>
######################################################################
p6df::modules::zsh::std::prompt::line() {

  local tty=$fg[cyan]%l$reset_color
  local user=$fg[blue]%n$reset_color
  local host=$fg[yellow]%M$reset_color

  local info="[$tty]$user@$host rv=%?"

  p6_return_str "$info"
}

######################################################################
#<
#
# Function: str dir = p6df::modules::zsh::dir::prompt::line()
#
#  Returns:
#	str - dir
#
#>
######################################################################
p6df::modules::zsh::dir::prompt::line() {

  local dir=$fg[green]%/$reset_color

  p6_return_str "$dir"
}

######################################################################
#<
#
# Function: p6df::modules::zsh::fpath::current()
#
#  Environment:	 FPATH IFS SAVED_IFS
#>
######################################################################
p6df::modules::zsh::fpath::current() {

  local fp
  local SAVED_IFS=$IFS
  local IFS=:
  for fp in $(echo $FPATH); do
    echo "$fp"
  done
  IFS=$SAVED_IFS
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
}
