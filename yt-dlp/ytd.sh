#!/bin/bash
# Check if yt-dlp is installed; if not, install it.
if ! command -v yt-dlp &>/dev/null; then
  echo "yt-dlp is not installed. Installing yt-dlp..."
  sudo pacman -S yt-dlp || { echo "Error: Failed to install yt-dlp. Exiting."; exit 1; }
fi

# Take URL as the first argument passed to the script
VIDEO_ID="$1"
URL="https://www.youtube.com/watch?v=$VIDEO_ID"
# Filter WebM and FLV formats and show the user a warning message
# Use `grep -v` to exclude both WebM and FLV formats from the list
echo "Filtering out WebM and FLV formats..."

# Here we use `grep -v` to exclude both WebM and FLV formats from the list.
# The `-E` flag allows for multiple patterns separated by `|` (OR) to match either WebM or FLV.
AVAILABLE_FORMATS=$(yt-dlp --cookies-from-browser firefox -F "$URL" | grep -vE "webm|flv|mhtml")

# Check if any formats are available after filtering
if [ -z "$AVAILABLE_FORMATS" ]; then
  echo "Error: No valid formats found. Exiting."
  exit 1
fi

# Show the filtered available formats
echo "$AVAILABLE_FORMATS"

# Ask the user to enter the format ID(s) they wish to download (e.g., 140+230):
echo "Enter the format ID(s) you want to download (e.g., 401+140 {video+audio}):"
read FORMAT_IDS

# Check if the entered format ID(s) are valid (must be numbers, and can be multiple IDs separated by '+')
if ! [[ "$FORMAT_IDS" =~ ^([0-9]+(\+([0-9]+))*)$ ]]; then
  echo "Error: Invalid format ID(s) entered. Exiting."
  exit 1
fi


# Set the output directory to $HOME/Downloads/YouTube and create it if it doesn't exist
OUTPUT_DIR="$HOME/Downloads/YouTube"
if [ ! -d "$OUTPUT_DIR" ]; then
  echo "Creating output directory: $OUTPUT_DIR"
  mkdir -p "$OUTPUT_DIR" || { echo "Error: Could not create directory $OUTPUT_DIR. Exiting."; exit 1; }
fi


# Now download the video in the selected format(s) by the user
yt-dlp --cookies-from-browser firefox --embed-subs --write-thumbnail --embed-thumbnail --output "$OUTPUT_DIR/%(title)s.%(ext)s" --merge-output-format mp4 --sub-lang en,fa -f "$FORMAT_IDS" "$URL" || {
  echo "Error: Download failed. Exiting."
  exit 1
}
