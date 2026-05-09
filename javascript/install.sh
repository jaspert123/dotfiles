curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

nodeversion='24.15.0'

if nvm ls | grep -q $nodeversion
then
  echo "node version $nodeversion is already installed"
else
  echo "installing node version $nodeversion"
  nvm install $nodeversion 
fi
echo "setting $nodeversion as default"
nvm use $nodeversion