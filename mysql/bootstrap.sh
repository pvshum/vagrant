#!/bin/bash

#checkout rcfiles
git clone git://github.com/visualdensity/rcfiles.git

cd rcfiles/
./setup.sh

./setup_zsh.sh
