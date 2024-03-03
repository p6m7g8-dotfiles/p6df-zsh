# shellcheck shell=bash
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
		zsh-users/zsh-syntax-highlighting # must be before below (wikipedia)
		zsh-users/zsh-history-substring-search
		zsh-users/zsh-autosuggestions

		hlissner/zsh-autopair
#		zdharma/fast-syntax-highlighting # XXX: complex install

		ohmyzsh/ohmyzsh:lib/diagnostics

		ohmyzsh/ohmyzsh:plugins/encode64
    ohmyzsh/ohmyzsh:plugins/nmap
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

  p6_return_void
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

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::zsh::init(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6df::modules::zsh::init() {
  local dir="$1"

  p6df::core::path::cd::if "$dir/plugins"

  p6df::modules::zsh::history::init
  p6df::modules::zsh::hooks::init
  p6df::modules::zsh::colors::init
  p6df::modules::zsh::comp::init "$dir"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::zsh::history::init()
#
#  Environment:	 BANG_HIST EXTENDED_HISTORY HISTFILE HISTSIZE HIST_BEEP HIST_EXPIRE_DUPS_FIRST HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS HIST_VERIFY SAVEHIST SHARE_HISTORY
#>
######################################################################
p6df::modules::zsh::history::init() {

  setopt BANG_HIST                 # Treat the '!' character specially during expansion.
  setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
  setopt SHARE_HISTORY             # Share history between all sessions.
  setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
  setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
  setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
  setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
  setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
  setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
  setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
  setopt HIST_BEEP                 # Beep when accessing non-existent history.

  p6_env_export HISTFILE "$ZDOTDIR/.zsh_history"
  p6_env_export HISTSIZE 100000
  p6_env_export SAVEHIST 100000

  p6_return_void
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

  p6_return_void
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

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::zsh::comp::init(dir)
#
#  Args:
#	dir -
#
#>
######################################################################
p6df::modules::zsh::comp::init() {``
  local dir="$1"

  autoload -Uz compaudit
  compaudit
  autoload -Uz compinit
  compinit -C -d $dir/share/.zcompdump

  p6_return_void
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

  p6_return_void
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

  p6_return_void
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
    local k=$(p6_echo $pair | awk -F= '{print $1}')
    p6_env_export_un "$k"
  done

  exec zsh -li

  # Not reached
  p6_return_void
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
