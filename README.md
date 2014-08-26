UMich CAEN Hacks
================

A bunch of recipes for [University of Michigan's CAEN Linux](http://caen.engin.umich.edu/faqs/linux). Contributions are welcome!

* Recipes
  * [Change your shell to ZSH](#change-your-shell-to-zsh)
  * [Change your shell to CSH](#change-your-shell-to-csh)


************


Change your shell to ZSH
------------------------

*In short, run these two commands:*

```sh
echo "zsh && exit" >> ~/.bashrc
echo "setopt no_err_exit" >> ~/.zshrc
```

CAEN [says you can't change your shell from Bash](http://caen.engin.umich.edu/faqs/linux#switchshell), and you're not allowed to run `chsh`. But you can run ZSH on CAEN! All you have to do is run ZSH within Bash.

Add the following line to `~/.bashrc`:

```bash
# Start ZSH and exit when ZSH exits
zsh && exit
```

Then add the following to your `~/.zshrc`:

```zsh
# Tell ZSH not to exit when an error happens; only exit on quit
setopt no_err_exit
```

Change your shell to CSH
------------------------

*In short, run this command:*

```sh
echo "csh -l && exit" >> ~/.bashrc
```

Like the above, you can run CSH from within Bash. Add the following line to `~/.bashrc`:


```bash
# Start CSH and exit when CSH exits
csh -l && exit
```
