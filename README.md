UMich CAEN Hacks
================

A bunch of recipes for [University of Michigan's CAEN Linux](http://caen.engin.umich.edu/faqs/linux). Contributions are welcome!

* Recipes
  * [Change your shell to ZSH](#change-your-shell-to-zsh)
  * [Change your shell to CSH](#change-your-shell-to-csh)
  * [Install Node.js](#install-nodejs)


************


Change your shell to ZSH
------------------------

*In short, run these two commands:*

```sh
echo "exec zsh" >> ~/.bashrc
echo "setopt no_err_exit" >> ~/.zshrc
```

CAEN [says you can't change your shell from Bash](http://caen.engin.umich.edu/faqs/linux#switchshell), and you're not allowed to run `chsh`. But you can run ZSH on CAEN! All you have to do is run ZSH within Bash.

Add the following line to `~/.bashrc`:

```bash
# Start ZSH and exit when ZSH exits
exec zsh
```

Then add the following to your `~/.zshrc`:

```zsh
# Tell ZSH not to exit when an error happens; only exit on quit
setopt no_err_exit
```

That's it!

Change your shell to CSH
------------------------

*In short, run this command:*

```sh
echo "exec csh -l" >> ~/.bashrc
```

Like the above, you can run CSH from within Bash. Add the following line to `~/.bashrc`:


```bash
# Start CSH and exit when CSH exits
exec csh -l
```

Install Node.js
---------------

We can install Node.js without root privileges using the [Node Version Manager](https://github.com/creationix/nvm).

First, we'll need to install NVM:

```sh
# If you're using Bash...
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash

# If you're using ZSH...
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | PROFILE=~/.zshrc bash
```

Then we'll start it up. You can also do the below by restarting your terminal.

```sh
source ~/.nvm/nvm.sh
```

Next, install your desired version of Node and set it as the default:

```
nvm install v0.10
nvm alias default v0.10
# You can also install v0.11 or other versions
```

Now you should be able to use Node, NPM, and more!
