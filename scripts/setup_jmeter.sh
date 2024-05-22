#!/bin/bash -e
USER_DIR="/home/ec2-user"
yum update -y
yum install git -y
yum install java-17-amazon-corretto-devel -y
cd $USER_DIR
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.3.tgz
JMETER_DIR="$USER_DIR/apache-jmeter-5.6.3/bin"
tar -xvf apache-jmeter-5.6.3.tgz
if ! grep -q "$JMETER_DIR" $USER_DIR/.bashrc; then
    echo "export PATH=\$PATH:$JMETER_DIR" >> $USER_DIR/.bashrc
    source $USER_DIR/.bashrc
    echo "JMeter path added to .bashrc"
else
    echo "JMeter path already exists in .bashrc"
fi

git clone https://github.com/hasathcharu/persist-sql-load-tests $USER_DIR/persist-sql-load-tests
