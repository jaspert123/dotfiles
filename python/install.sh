#!/bin/bash

pythonversion='3.11'

if pyenv versions | grep -q $pythonversion
then
  echo "python version $pythonversion is already installed"
else
  echo "installing python version $pythonversion"
  pyenv install 3.11
fi
echo "setting $pythonversion as default"
pyenv global 3.11
