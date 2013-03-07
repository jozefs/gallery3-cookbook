#!/bin/bash

# configure the VM from scratch
vagrant destroy -f
vagrant up
vagrant halt

# remove any boxes left over from previous runs
rm *.box

# create new box
vagrant package --vagrantfile Vagrantfile.pkg
mv package.box gallery3dev-`date +%s`.box
