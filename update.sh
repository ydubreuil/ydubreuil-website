#!/bin/bash

HERE=$(dirname $(readlink -f "$0"))

DEST="$HERE/../ydubreuil.github.io"

[[ -d "$DEST" ]] && hugo -d "$DEST"
