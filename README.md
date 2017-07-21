University of Michigan CAEN Hacks
=================================

A bunch of recipes for [University of Michigan's CAEN Linux](http://caen.engin.umich.edu/faqs/linux).

* Recipes
  * [Change your shell to ZSH](#change-your-shell-to-zsh)
  * [Change your shell to CSH](#change-your-shell-to-csh)
  * [Install packages](#install-packages)
  * [Install Node.js](#install-nodejs)
  * [Install Python packages globally with Pip](#install-python-packages-globally-with-pip)
  * [Install new versions of Ruby with RVM](#install-new-versions-of-ruby-with-rvm)
  * [Install Golang](#install-golang)


************


Change your shell to ZSH
------------------------

CAEN [says you can't change your shell from Bash](http://caen.engin.umich.edu/faqs/linux#switchshell), and you're not allowed to run `chsh`. But you can run ZSH on CAEN! All you have to do is run ZSH within Bash.

Add the following line to `~/.bashrc`:

```bash
# Start ZSH and exit when ZSH exits
exec zsh
```

Then add the following to your `~/.zshrc`:

```sh
# Tell ZSH not to exit when an error happens; only exit on quit
setopt no_err_exit
```

That's it!

Change your shell to CSH
------------------------

Like the above, you can run CSH from within Bash. Add the following line to `~/.bashrc`:


```bash
# Start CSH and exit when CSH exits
exec csh -l
```

Install packages
---------------

We don't get root access on CAEN computers - so no, we can't use existing package managers such as RPM.

So basically every package you need - compile it yourself and add to path!

I like to approach this by creating a new install location under user's $HOME.

```bash
mkdir $HOME/usr
```

Then add the following to your shell startup script:

```bash
export $PATH="$PATH:/home/[uniquename]/usr/bin/"
export $LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/[uniquename]/usr/lib/"
```

When you install a library:

```bash
# CMake example:
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$HOME/usr [Path to CMake source]
make
make install

# Configure example:
./configure --prefix=$HOME/usr
make
make install
```

Install Node.js
---------------

We can install Node.js without root privileges using the [Node Version Manager](https://github.com/creationix/nvm).

First, we'll need to install NVM:

```sh
# If you're using Bash...
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.17.3/install.sh | bash

# If you're using ZSH...
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.17.3/install.sh | PROFILE=~/.zshrc bash
```

Then we'll start it up. You can also do the below by restarting your terminal.

```sh
source ~/.nvm/nvm.sh
```

Next, install your desired version of Node and set it as the default:

```
nvm install 8
nvm alias default 8
# You can also install other versions
```

Now you should be able to use Node, NPM, and more!

Install Python packages globally with Pip
-----------------------------------------

*Note: Virtualenv is already installed on CAEN, so unless you need to install packages globally, you don't need to do this.*

We can install Pip (and then Python packages) by making a "dummy" virtualenv, because Pip lives inside these virtual environments.

First, create your dummy virtualenv wherever you like:

```sh
virtualenv ~/my-dummy-venv  # Feel free to put this somewhere else.
```

Next, add it to your PATH. Add this to your `~/.bashrc` or your `~/.zshrc`:

```sh
export PATH="~/my-dummy-venv/bin:$PATH"
```

Restart your terminal or reload your `rc` file, and then you can install things as you please!

```sh
# For example, install Flake8.
pip install flake8
flake8 my_file.py
```

Install new versions of Ruby with RVM
-------------------------------------

CAEN comes with Ruby 1.8.7, which is several years old. We can use [RVM](http://rvm.io/) to install newer versions.

```sh
# Install RVM
\curl -sSL https://get.rvm.io | bash -s stable

# Start RVM (you can also do this by restarting your shell)
source ~/.rvm/scripts/rvm

# Ignore missing dependencies
rvm autolibs read-only

# Install Ruby 2.1.x! This takes awhile because it has to compile.
rvm install 2.1
```

Now you'll have the newest Ruby!

```sh
ruby --version
gem install rails
```

Install Golang
--------------

First, go to [golang.org/dl](https://golang.org/dl/) and download the latest 64-bit Go distribution for Linux. Put it wherever you want, but we'll be adding the folder to your PATH so we can run Go. Then extract it:

```sh
cd /path/to/wherever/you/wanna/install/golang
tar xvzf GO_TARBALL.tar.gz
```

Next, add the following to your `~/.bashrc` (or `zshrc`, or whatever):

```sh
export GOROOT=/path/to/wherever/you/wanna/install/golang/go
export PATH=$PATH:$GOROOT/bin
```

Re-source your `rc` or restart the terminal. Now you'll have the `go` executable!
