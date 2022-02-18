#!/bin/sh
gpg --decrypt local.key.asc | git-crypt unlock -
