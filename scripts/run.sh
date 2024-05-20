#!/bin/zsh -e
set -e
/home/haritha/Downloads/apache-jmeter-5.6.3/bin/jmeter -n -t ./Test\ Plan.jmx -Jtype="$TEST_TYPE"