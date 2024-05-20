#!/bin/zsh -e
set -e
jmeter -n -t ./Test\ Plan.jmx -Jtype="$TEST_TYPE" -Jhost=13.126.1.187