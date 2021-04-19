#!/bin/bash

yum clean all
yum repolist enabled
yum update
yum -y install gcc-c++
yum -y install libstdc++.i686
yum -y install tcpdump
