#!/bin/bash

cmd_serve() {
	hugo serve --buildDrafts &
}


cmd_unserve() {
	kill $(pgrep hugo)
}

cmd_generate() {
	hugo
}

cmd_deploy() {
    cmd_generate

    rsync -vau --delete public/ rockbridge:shablag.com
}

cmd_help() {
    for cmd in $(typeset -F | awk '{print $3}' | grep -E '^cmd_'); do
	echo ${cmd#cmd_};
    done
}


if [[ $# -eq 0 ]]; then
    cmd_help
    exit 1;
fi

cmd_$1
