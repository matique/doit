Doit
====

Executes good old shell/bash scripts locally as well as remotely.
The environment is set by a ".yml" configuration file.
An array environment variable triggers multiple calls of the script.

Installation
------------
  gem install doit

Usage
-----
    doit script... [options]
    doit push
    doit deploy tag

Options
-------
    -l, --[no-]list          Lists available scripts
    -r, --remote ["host"]    remote host or comma separated hosts
    -s, --[no-]silent        run silently; suppress output
    -v, --[no-]verbose       Enable verbose output
    -n, --[no-]noop          Suppress execution of commannds
    -h, --help               Show this message
    -V, --version            Print version

File Structure
--------------
    ~/.doit/deploy          # chmod +x .doit/deploy
    ~/.doit/deploy.yml
    $PROJ/.doit/deploy.yml  # overwrites
    $PROJ/.doit/push        # chmod +x .doit/deploy
    $PROJ/.doit/push.yml

$PROJ/.doit/push
----------------
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

~/.doit/deploy
--------------
    uname -a
    git status

~/.doit/deploy.yml
------------------
    env:
      - DIR=tmp OPTION=run
      - DIR=proj OPTION=list
    where:
      - bob@sample.com
      - alice@customer.com

Copyright (c) 2014 [Dittmar Krall], released under the MIT license
