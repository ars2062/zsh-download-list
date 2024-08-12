#!/bin/bash

__ensure_axel_installed() {
    local cmd="axel"
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd is not installed. Installing..."

        # Identify the package manager and install the package
        if [ -f /etc/debian_version ]; then
            sudo apt update && sudo apt install -y "$cmd"
        elif [ -f /etc/redhat-release ]; then
            sudo yum install -y "$cmd"
        elif [ -f /etc/arch-release ]; then
            sudo pacman -Sy --noconfirm "$cmd"
        elif [ -f /etc/alpine-release ]; then
            sudo apk add "$cmd"
        else
            echo "Unsupported Linux distribution. Please install $cmd manually."
            return 1
        fi
    fi
    return 0
}


download-list() {
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "Usage: download-list <file_with_links> [num_threads]"
        return 1
    fi

    local file="$1"
    local num_threads="${2:-4}"

    if [ ! -f "$file" ]; then
        echo "Error: File $file not found."
        return 1
    fi

    if ! [[ "$num_threads" =~ ^[0-9]+$ ]]; then
        echo "Error: Second argument must be a number."
        return 1
    fi
    __ensure_axel_installed
    if [[ $? == 1 ]]; then
        return 1
    fi

    echo "Downloading links from $file with $num_threads threads..."

    while IFS= read -r link; do
        attempts=3
        while [ $attempts -gt 0 ]; do
            axel -n "$num_threads" "$link" && sed -i "/$link/d" "$file" && break
            attempts=$((attempts-1))
            echo "Retrying download of $link (attempts left: $attempts)..."
        done
        if [ $attempts -eq 0 ]; then
            echo "Failed to download $link after 3 attempts."
        fi
    done < "$file"

    echo "Download complete."
}
