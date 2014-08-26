UMich CAEN Hacks
================

A bunch of recipes for [University of Michigan's CAEN Linux](http://caen.engin.umich.edu/faqs/linux). Contributions are welcome!

Change your shell to ZSH
------------------------

*In short, run these two commands:*

```sh
echo "zsh && exit" >> ~/.bashrc
echo "setopt no_err_exit" >> ~/.zshrc
```

CAEN [says you can't change your shell from Bash](http://caen.engin.umich.edu/faqs/linux#switchshell), but you (sorta) can. All you have to do is run ZSH within Bash.

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
