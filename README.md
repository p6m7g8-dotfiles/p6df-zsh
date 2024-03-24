# p6df-zsh

## Table of Contents


### p6df-zsh
- [p6df-zsh](#p6df-zsh)
  - [Badges](#badges)
  - [Distributions](#distributions)
  - [Summary](#summary)
  - [Contributing](#contributing)
  - [Code of Conduct](#code-of-conduct)
  - [Usage](#usage)
  - [Author](#author)

### Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/p6m7g8/p6df-zsh)
[![Mergify](https://img.shields.io/endpoint.svg?url=https://gh.mergify.io/badges/p6m7g8/p6df-zsh/&style=flat)](https://mergify.io)
[![codecov](https://codecov.io/gh/p6m7g8/p6df-zsh/branch/master/graph/badge.svg?token=14Yj1fZbew)](https://codecov.io/gh/p6m7g8/p6df-zsh)
[![Known Vulnerabilities](https://snyk.io/test/github/p6m7g8/p6df-zsh/badge.svg?targetFile=package.json)](https://snyk.io/test/github/p6m7g8/p6df-zsh?targetFile=package.json)
[![Gihub repo dependents](https://badgen.net/github/dependents-repo/p6m7g8/p6df-zsh)](https://github.com/p6m7g8/p6df-zsh/network/dependents?dependent_type=REPOSITORY)
[![Gihub package dependents](https://badgen.net/github/dependents-pkg/p6m7g8/p6df-zsh)](https://github.com/p6m7g8/p6df-zsh/network/dependents?dependent_type=PACKAGE)

## Summary

## Contributing

- [How to Contribute](CONTRIBUTING.md)

## Code of Conduct

- [Code of Conduct](https://github.com/p6m7g8/.github/blob/master/CODE_OF_CONDUCT.md)

## Usage


### Aliases

- p6_zoff -> p6df::modules::zsh::state::off
- p6_zon -> p6df::modules::zsh::state::on
- p6_zreload -> p6df::modules::zsh::state::reload

### Functions

### p6df-zsh:

#### p6df-zsh/init.zsh:

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
- str dir = p6df::modules::zsh::dir::prompt::line()
- str info = p6df::modules::zsh::std::prompt::line()


### p6df-zsh/lib:

#### p6df-zsh/lib/fpath.zsh:

- p6df::modules::zsh::fpath::current()
- p6df::modules::zsh::fpath::if(dir)

#### p6df-zsh/lib/history.zsh:

- p6df::modules::zsh::history::stats()

#### p6df-zsh/lib/profile.zsh:

- p6df::modules::zsh::profile::off()
- p6df::modules::zsh::profile::on(name)

#### p6df-zsh/lib/state.zsh:

- p6df::modules::zsh::state::off()
- p6df::modules::zsh::state::on()
- p6df::modules::zsh::state::reload()



## Hier
```text
.
├── fpath.zsh
├── history.zsh
├── profile.zsh
└── state.zsh

1 directory, 4 files
```
## Author

Philip M . Gollucci <pgollucci@p6m7g8.com>
