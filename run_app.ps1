# PowerShell script to run the Flutter Restaurant App

$FlutterPath = "D:\PROJECTS\group\mobile application development\flutter_windows_3.35.3-stable\bin"
$ProjectPath = "d:\PROJECTS\group\mobile application development\resturent app"

# Add Flutter to PATH for this session
$env:PATH = "$FlutterPath;$env:PATH"

# Navigate to project
Set-Location $ProjectPath

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Flutter Restaurant App Setup" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Verify Flutter is accessible
Write-Host "Checking Flutter installation..." -ForegroundColor Yellow
& "$FlutterPath\flutter.bat" --version
Write-Host ""

# Get dependencies
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Installing dependencies..." -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
& "$FlutterPath\flutter.bat" pub get
Write-Host ""

# Run the app
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Starting Flutter app..." -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Opening on Chrome in 3 seconds..." -ForegroundColor Yellow
Start-Sleep -Seconds 3
& "$FlutterPath\flutter.bat" run -d chrome

Write-Host ""
Write-Host "=====================================" -ForegroundColor Green
Write-Host "App is running! Check Chrome." -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green
