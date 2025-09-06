@echo off
setlocal

echo Cleaning old builds...
rmdir /S /Q build 2>nul
rmdir /S /Q dist 2>nul
rmdir /S /Q pandacolor.egg-info 2>nul

echo Building package...
python -m build

if errorlevel 1 (
    echo Build failed!
    exit /b %errorlevel%
)

echo Uploading to PyPI...
twine upload dist/*

if errorlevel 1 (
    echo Upload failed!
    exit /b %errorlevel%
)

echo Done.
endlocal
