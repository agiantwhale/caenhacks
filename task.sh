#!/usr/bin/env bash

pagsh
export KRB5CCNAME=FILE:`mktemp -p /ticket krb5cc_screen_XXXXXX`
kinit -l 4d
aklog
screen -S $1
