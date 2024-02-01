#!/bin/bash

# Set the default framerate and resolution
framerate=30
resolution="1280x720"

# Function to start video capture
start_capture() {
    libcamera-vid -o myvideo.h264 -c 0 --framerate $framerate --resolution $resolution &
    capture_pid=$!
}

# Function to stop video capture
stop_capture() {
    kill $capture_pid
}

# Function to start live video streaming
start_live_stream() {
    raspivid -o - -t 0 -n -w $resolution -h $resolution -fps $framerate | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:8554/}' :demux=h264
}

# Create GUI menu
while true; do
    choice=$(dialog --stdout --menu "Video Capture Menu" 12 60 4 "Start Capture" "Start video capture" "Start Live Stream" "Start live video streaming" "Stop Capture" "Stop video capture" "Exit" "Exit script")

    case $choice in
        "Start Capture")
            start_capture
            ;;
        "Start Live Stream")
            start_live_stream
            ;;
        "Stop Capture")
            stop_capture
            ;;
        "Exit")
            stop_capture
            break
            ;;
    esac
done
