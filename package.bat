
@echo off
setlocal

echo Creating package for Video Parser Project...
if exist deploy_package.zip del deploy_package.zip

:: List of files and folders to include
set "files=main.py requirements.txt DEPLOY.md"
set "folders=parser templates utils resources static"

:: Create a temporary directory for packaging
set "temp_dir=temp_deploy_package"
if exist "%temp_dir%" rmdir /s /q "%temp_dir%"
mkdir "%temp_dir%"

:: Copy files
for %%f in (%files%) do (
    if exist "%%f" (
        copy "%%f" "%temp_dir%\" >nul
    ) else (
        echo Warning: File %%f not found.
    )
)

:: Copy folders
for %%d in (%folders%) do (
    if exist "%%d" (
        xcopy "%%d" "%temp_dir%\%%d\" /E /I /Q >nul
    ) else (
        echo Warning: Folder %%d not found.
    )
)

:: Zip the temporary directory content
powershell -Command "Compress-Archive -Path '%temp_dir%\*' -DestinationPath 'deploy_package.zip' -Force"

:: Clean up
rmdir /s /q "%temp_dir%"

echo.
echo Package created successfully: deploy_package.zip
echo You can unzip this file on your server to deploy the project.
echo.
pause
