# [NWRUG.ORG](http://nwrug.org)

![Build status](https://github.com/nwrug/nwrug.org/actions/workflows/test-suite.yml/badge.svg)

The website of the North West Ruby User Group, a Manchester-based user group for
folk interested in the Ruby programming language.

## Setup

After cloning the repository, run `bin/setup` to install the gme dependencies, prepare the database and start the
server. Note you will need MySQL installed and running locally.

## Running the tests

```shell
  bundle exec rake
```

## Security checks

Check gems for known vulnerabilities:

```shell
  bundle exec bundle-audit check --update
```

Run static code analysis on codebase to identify common vulnerabilities:

```shell
  bundle exec brakeman -z
```

All contributions welcome!
