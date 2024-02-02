# Doit

[![Gem Version](https://badge.fury.io/rb/doit.png)](http://badge.fury.io/rb/doit)

Executes good old shell/bash scripts locally as well as remotely.
The environment is set by a ".yml" configuration file.
An array environment variable triggers multiple calls of the script.

The "where" in the configuration indicates where to run the script.

See examples below.

## Installation

  gem install doit

## Usage

    doit script... [options]
    doit push
    doit deploy tag

## Options

    -l, --[no-]list          Lists available scripts
    -r, --remote ["host"]    remote host or comma separated hosts
    -e, --[no-]each          Lists each remote command (no execution)
    -s, --[no-]silent        run silently; suppress output
    -v, --[no-]verbose       Enable verbose output
    -n, --[no-]noop          Suppress execution of commannds
    -h, --help               Show this message
    -V, --version            Print version


## File Structure

    ~/.doit/deploy          # chmod +x .doit/deploy
    ~/.doit/deploy.yml
    $PROJ/.doit/deploy.yml  # overwrites $HOME(~/) script/configuration
    $PROJ/.doit/push        # chmod +x .doit/push
    $PROJ/.doit/push.yml

## $PROJ/.doit/push

    #! /bin/sh
    if ! (git status | grep 'nothing to commit'); then
      echo "push: commits are pending"
      exit 1
    fi

    current_branch=`git rev-parse --abbrev-ref HEAD`
    echo "**** branch is '$current_branch'"

    case $current_branch in
    development)
      git checkout master && git merge --no-ff development &&
	git push origin master
      git checkout development
      ;;
    master)
      git push origin master
      ;;
    esac

## ~/.doit/deploy

    uname -a
    git status

## ~/.doit/deploy.yml

    env:
      - DIR=tmp OPTION=run
      - DIR=proj OPTION=list
    where:
      - bob@sample.com
      - alice@customer.com

## Miscellaneous

Copyright (c) 2014-2024 Dittmar Krall (www.matiq.com),
released under the MIT license:

* https://opensource.org/licenses/MIT
