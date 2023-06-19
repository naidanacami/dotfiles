#!/bin/bash

# Get the absolute path of the dotfile repository
DOTFILES=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Log file to store existing non-symlink files
LOG_FILE="$DOTFILES/symlink_conflicts.log"

# Create an empty log file
> "$LOG_FILE"

# Find links.prop files recursively and create symlinks
find "$DOTFILES" -name "links.prop" -type f -print0 | while IFS= read -r -d $'\0' file; do
    dirname=$(dirname "$file")
    while IFS='=' read -r source target; do
        source_file=${source//\$DOTFILES/"$DOTFILES"}
        target_file=${target//\$HOME/"$HOME"}

        # Check if the target file exists and is not a symlink
        if [ -e "$target_file" ] && ! [ -L "$target_file" ]; then
            # Append the conflicting file path to the log file
            echo "$target_file" >> "$LOG_FILE"
        else
            # Create necessary folders in the target directory
            mkdir -p "$(dirname "$target_file")"

            # Create the symlink
            ln -sf "$source_file" "$target_file"
            echo "Created symlink: $source_file -> $target_file"
        fi
    done < <(grep -vE '^\s*$|^\s*#' "$file")
done

# Check if any conflicting files were found and log the result
if [ -s "$LOG_FILE" ]; then
    echo "Conflicting files detected. Check $LOG_FILE for details."
else
    rm "$LOG_FILE"
    echo "No conflicting files found."
fi
