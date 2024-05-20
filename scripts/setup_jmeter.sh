#!/bin/bash -e
sudo yum update -y
sudo yum install git -y
sudo yum install java-17-amazon-corretto-devel
cd ~
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.6.3.tgz
JMETER_DIR="~/apache-jmeter-5.6.3/bin"
tar -xvf apache-jmeter-5.6.3.tgz
if ! grep -q "$JMETER_DIR" ~/.bashrc; then
    echo "export PATH=\$PATH:$JMETER_DIR" >> ~/.bashrc
    source ~/.bashrc
    echo "JMeter path added to .bashrc"
else
    echo "JMeter path already exists in .bashrc"
fi

git clone https://github.com/hasathcharu/persist-sql-load-tests
