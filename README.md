# P6's POSIX.2: p6df-zsh

## Table of Contents

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)

## Summary

## Contributing

- [How to Contribute](<https://github.com//.github/blob/main/CONTRIBUTING.md>)

## Code of Conduct

- [Code of Conduct](<https://github.com//.github/blob/main/CODE_OF_CONDUCT.md>)

## Usage

### Aliases

- p6_zoff IS p6df::modules::zsh::state::off
- p6_zon IS p6df::modules::zsh::state::on
- p6_zreload IS p6df::modules::zsh::state::reload
### Functions

## p6df-zsh

### p6df-zsh/init.zsh

- p6df::modules::zsh::aliases::init()
- p6df::modules::zsh::colors::init()
- p6df::modules::zsh::comp::init(dir)
- p6df::modules::zsh::completions::init()
- p6df::modules::zsh::deps()
- p6df::modules::zsh::external::brew()
- p6df::modules::zsh::external::yum()
- p6df::modules::zsh::history::init()
- p6df::modules::zsh::hooks::init()
- p6df::modules::zsh::init(_module, dir)
- str dir = p6df::modules::zsh::dir::prompt::mod()
- str info = p6df::modules::zsh::std::prompt::mod()
- str str = p6df::modules::zsh::prompt::mod()

## p6df-zsh/lib

### p6df-zsh/lib/fpath.zsh

- p6df::modules::zsh::fpath::current()
- p6df::modules::zsh::fpath::if(dir)

### p6df-zsh/lib/history.zsh

- p6df::modules::zsh::history::stats()

### p6df-zsh/lib/profile.zsh

- p6df::modules::zsh::profile::off()
- p6df::modules::zsh::profile::on(name)

### p6df-zsh/lib/state.zsh

- p6df::modules::zsh::state::off()
- p6df::modules::zsh::state::on()
- p6df::modules::zsh::state::reload()

## Hierarchy

```text
.
├── init.zsh
├── lib
│   ├── fpath.zsh
│   ├── history.zsh
│   ├── profile.zsh
│   └── state.zsh
└── README.md

2 directories, 6 files
```

## Author

Philip M . Gollucci <pgollucci@p6m7g8.com>
