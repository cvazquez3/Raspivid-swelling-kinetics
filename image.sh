#!/bin/bash

# Function to capture an image at a specified quality using libcamera
capture_image() {
    local output_file="$1"
    local quality="$2"
    
    libcamera-still -o "$output_file" -c 0 --quality "$quality"
}

# Ask for output file name
dialog --inputbox "Enter output image file name:" 8 40 2> output_file.txt
output_file=$(cat output_file.txt)

# Create GUI menu to select image quality
quality_choice=$(dialog --stdout --menu "Select Image Quality" 10 40 4 "Low (20)" "" "Medium (50)" "" "High (90)" "")

case $quality_choice in
    "Low (20)")
        quality=20
        ;;
    "Medium (50)")
        quality=50
        ;;
    "High (90)")
        quality=90
        ;;
    *)
        echo "Exiting"
        exit 0
        ;;
esac

# Capture image
capture_image "$output_file" "$quality"

echo "Image capture completed."
