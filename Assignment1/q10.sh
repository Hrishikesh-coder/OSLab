#!/bin/bash
#myrm.sh
#Usage: ./myrm.sh file1 file2...
#       ./myrm.sh -cl (clears my-deleted-files after confirmation)

TRASH_DIR="./my-deleted-files"
mkdir -p "$TRASH_DIR"

#Option b: -cl switch to clear the trash directory
if [ "$1" == "-cl" ]; then
    read -p "Are you sure you want to permanently clear '$TRASH_DIR'? (y/n): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        rm -rf "${TRASH_DIR:?}"/*
        echo "'$TRASH_DIR' has been cleared."
    else
        echo "Clear operation cancelled."
    fi
    exit 0
fi

if [ "$#" -eq 0 ]; then
    echo "Usage: $0 file1 [file2...] OR $0 -cl"
    exit 1
fi

#Option a: move (instead of delete) with version numbering on collision
for target in "$@"; do
    if [ ! -e "$target" ]; then
        echo "Error: '$target' does not exist. Skipping."
        continue
    fi
    
    base=$(basename "$target")
    dest="$TRASH_DIR/$base"
    
    if [ ! -e "$dest" ]; then
        #No collision: simple move
        mv "$target" "$dest"
        echo "Moved '$target' -> '$dest'"
    else
        # Collision handling with version numbers
        # If the existing file in trash has no version suffix yet, rename it to version 0
        if [[ "$dest" != *.v[0-9]+ ]]; then
            mv "$dest" "${dest}.v0"
        fi
        
        #Find the next free version number
        version=1
        while [ -e "${dest}.v${version}" ]; do
            version=$((version + 1))
        done
        
        mv "$target" "${dest}.v${version}"
        echo "Moved '$target' -> '${dest}.v${version}' (name collision resolved)"
    fi
done