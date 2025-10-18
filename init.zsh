# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::zsh::deps()
#
#>
######################################################################
p6df::modules::zsh::deps() {

  # shellcheck disable=2034
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

  p6df::modules::homebrew::cli::brew::install zsh
  p6df::modules::homebrew::cli::brew::install zmap
  p6df::modules::homebrew::cli::brew::install zshdb
  p6df::modules::homebrew::cli::brew::install zssh

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
p6df::modules::zsh::comp::init() {
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
# Function: p6df::modules::zsh::completions::init()
#
#>
######################################################################
p6df::modules::zsh::completions::init() {

 # shellcheck disable=2016
 zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

 p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::zsh::aliases::init()
#
#>
######################################################################
p6df::modules::zsh::aliases::init() {

  p6_alias "p6_zoff" "p6df::modules::zsh::state::off"
  p6_alias "p6_zon" "p6df::modules::zsh::state::on"
  p6_alias "p6_zreload" "p6df::modules::zsh::state::reload"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::zsh::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#>
######################################################################
p6df::modules::zsh::init() {
  local _module="$1"
  local dir="$2"

  p6_bootstrap "$dir"

  p6df::modules::zsh::history::init
  p6df::modules::zsh::hooks::init
  p6df::modules::zsh::colors::init
  p6df::modules::zsh::comp::init "$dir"

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

  # shellcheck disable=2154
  local tty=$fg[cyan]%l$reset_color
  # shellcheck disable=2154
  local user=$fg[blue]%n$reset_color
  # shellcheck disable=2154
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
