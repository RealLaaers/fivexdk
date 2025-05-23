@echo off
set source_folder=C:\Users\Administrator\Desktop\server\files\resources\[misc]\fivex_duels
set build_folder=C:\Users\Administrator\Desktop\server\files\resources\[misc]\fivex_duels\build

echo Deleting current open build...
rm "%source_folder%\builds"

echo Copying open files...
xcopy "%source_folder%\client" "%build_folder%\client" /E /I /H /Y
xcopy "%source_folder%\server" "%build_folder%\server" /E /I /H /Y
xcopy "%source_folder%\web\dist" "%build_folder%\web\dist" /E /I /H /Y
copy "%source_folder%\fxmanifest.lua" "%build_folder%"
copy "%source_folder%\import.lua" "%build_folder%"
copy "%source_folder%\locale.lua" "%build_folder%"

echo Build completed.
pause