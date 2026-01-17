@echo off
REM Add Flutter to PATH and run your app

set FLUTTER_PATH=D:\PROJECTS\group\mobile application development\flutter_windows_3.35.3-stable

REM Add Flutter to PATH
set PATH=%FLUTTER_PATH%\bin;%PATH%

REM Navigate to project
cd /d "d:\PROJECTS\group\mobile application development\resturent app"

REM Get dependencies
echo.
echo ====================================
echo Installing dependencies...
echo ====================================
call flutter pub get

REM Run the app
echo.
echo ====================================
echo Starting Flutter app on web...
echo ====================================
call flutter run -d chrome

pause
