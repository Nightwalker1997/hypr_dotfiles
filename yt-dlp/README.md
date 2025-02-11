yt-dlp-project/
├── yt-dlp.conf # yt-dlp configuration file
├── yt-dlp-format-selector.sh => ytd.sh# Bash script to select formats and download
├── yt-dlp-format-selector.bat => ytd.sh # Batch script (Windows) to select formats and download
├── README.md # Project documentation

Steps

    Create a Symlink in /usr/local/bin/ This will allow you to call ytd (or any name you choose) globally:

sudo rm /usr/local/bin/ytd
sudo ln -s ~/.config/yt-dlp/ytd.sh /usr/local/bin/ytd

Make the Script Executable If you haven’t already made ytd.sh executable, do this:

chmod +x ~/.config/yt-dlp/ytd.sh

Run the Script from Anywhere Now you can run it globally like this:

    ytd "https://www.youtube.com/watch?v=example"

This should set it up so you can run ytd as a universal command from anywhere on your system. Let me know if that works!
