@echo off
REM This batch script will download a video in a selected format using yt-dlp

REM Take the URL as the first argument passed to the script
set URL=%1

REM Check if URL is provided
if "%URL%"=="" (
    echo Please provide a URL as the first argument.
    exit /b
)

REM Display all available formats for the given URL
echo Available formats for %URL%:
yt-dlp -F %URL%

REM Ask the user to enter the format ID they wish to download
echo Enter the format ID you want to download (after reviewing the list above):
set /p FORMAT_ID=

REM Optionally, filter specific formats (e.g., exclude WebM and FLV)
echo Filtering out WebM and FLV formats...
for /f "delims=" %%i in ('yt-dlp -F %URL% ^| findstr /V /I "webm flv"') do echo %%i

REM Now prompt the user again, showing only the available formats after filtering
echo Enter the format ID you want to download (after filtering):
set /p FORMAT_ID=

REM Now download the video in the selected format by the user
yt-dlp -f %FORMAT_ID% %URL%

REM End of script
exit /b
