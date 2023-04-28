#!/usr/bin/env sh


usage() {
    echo "Usage: $0 [build|apply]" >&2
}

if [ $# -eq 0 ]; then
    COMMAND=apply
elif [ $# -eq 1 ]; then
    COMMAND="$1"
else
    usage
    exit 1
fi


case $COMMAND in
    "apply")
        CMD="switch"
        ;;
    "build")
        CMD="build"
        ;;
    *)
        usage
        exit 1
        ;;
esac

actual_hostname="${HOSTNAME:-$(hostname)}"

if ! type home-manager > /dev/null; then
    echo "home-manager not found, running via nix"
    nix run . "$CMD" -- --flake ".#$actual_hostname"
    exit 0
fi

home-manager --max-jobs auto "$CMD" --flake ".#$actual_hostname"
