#!/bin/bash -e
set -e
jmeter -n -t ./Test\ Plan.jmx -l row_results/"$TEST_TYPE"/Pass"$PASS".jtl -Jtype="$TEST_TYPE" -Jhost=13.126.1.187