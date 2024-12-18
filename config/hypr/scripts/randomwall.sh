#!/bin/bash
# random_image_command.sh

# Directory containing your images
IMAGE_DIR="/home/lildicky/Downloads/"

# Find a random image from the directory and subdirectories
RANDOM_IMAGE=$(find "$IMAGE_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# Execute the sww img command with the selected image
if [ -n "$RANDOM_IMAGE" ]; then
    swww img "$RANDOM_IMAGE"  \
    --transition-bezier .43,1.19,1,.4 \
    --transition-type "grow" \
    --transition-duration 0.7 \
    --transition-fps 60 \
    --invert-y \
    --transition-pos "$( hyprctl cursorpos )"
 
else
    echo "No image found"
fi

