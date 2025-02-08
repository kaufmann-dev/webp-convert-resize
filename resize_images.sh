#!/bin/bash

quality=75
width=0
height=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --quality | -q)
            quality="$2"
            shift 2
            ;;
        --width | -w)
            width="$2"
            shift 2
            ;;
        --height | -h)
            height="$2"
            shift 2
            ;;
        *)
            printf "\e[31mUnknown option: %s\e[0m\n" "$1"
            exit 1
            ;;
    esac
done

shopt -s nullglob extglob

image_files=(*.@(jpg|jpeg|png|bmp|tiff|webp))

if [ ${#image_files[@]} -eq 0 ]; then
    printf "\e[31mError: No image files found.\e[0m\n"
    exit 0
fi

for img in "${image_files[@]}"; do
    [ -f "$img" ] || continue

    printf "%s.webp\n" "${img%.*}"

    cwebp -q "$quality" "$img" -resize "$width" "$height" -o "${img%.*}.webp" >/dev/null 2>&1
done