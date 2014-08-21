#!/bin/bash
#
# Script for creating new cluster
vagrant destroy -f
NEWTOKEN=$(curl -s https://discovery.etcd.io/new|cut -d "/" -f4)
cp user-data.sample user-data
cp config.rb.sample config.rb
sed -i tmp -e's/\#\$num_instances=1/\$num_instances=7/' config.rb
sed -i tmp -e's/\#\$update_channel='alpha'/\$update_channel='alpha'/' config.rb
sed -i tmp -e"s/#discovery/discovery/" user-data
sed -i tmp -e"s/<token>/$NEWTOKEN/" user-data
vagrant up --parallel
