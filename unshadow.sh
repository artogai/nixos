#!/usr/bin/env bash
gpg --decrypt local.key.asc | git-crypt unlock -
