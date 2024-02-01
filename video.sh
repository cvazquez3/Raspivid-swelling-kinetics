#!/bin/bash

# Set the default framerate and resolution
framerate=60
resolution="1280x720"

# Function to start video capture using libcamera
start_capture() {
    local duration="$1"
    local output_file="$2"
    local time=$((duration * 1000))

    libcamera-vid -o "$output_file" -c 0 --framerate $framerate -t $time --width 1440 --height 1080 --shutter 50000 --gain 3.0
}




# Create GUI menu to select video duration
choice=$(dialog --stdout --menu "Select Video Duration" 10 40 4 "30 Seconds" "" "1 Minute" "" "2 Minutes" "" "5 Minutes" "")

case $choice in
    "30 Seconds")
        duration=30
        ;;
    "1 Minute")
        duration=60
        ;;
    "2 Minutes")
        duration=120
        ;;
    "5 Minutes")
        duration=300
        ;;
    *)
        echo "Exiting"
        exit 0
        ;;
esac

# Ask for output file name
dialog --inputbox "Enter output file name:" 8 40 2> output_file.txt
output_file=$(cat output_file.txt)

# Start video capture
start_capture "$duration" "$output_file"

echo "Video capture completed."



