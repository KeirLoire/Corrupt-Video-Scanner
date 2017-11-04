ECHO "SCAN IN PROGRESS - PRESS CTRL + C TO CANCEL THE BATCH PROCESS."
@ECHO OFF
SET "filtro=%1"
IF [%filtro%]==[] (
    SET "filtro=*.mp4"
    )

FOR /R %%a IN (%filtro%) DO CALL :doWork "%%a"

    C:\ffmpeg\corrupt-videos.log
    EXIT /B

:doWork
    C:\ffmpeg\bin\ffmpeg.exe -v error -i %1 -f null - > "C:\ffmpeg\temp.log" 2>&1
    FOR /f %%i IN ("C:\ffmpeg\temp.log") DO SET size=%%~zi	
	if %size% gtr 0 echo %1 is corrupt. >> "C:\ffmpeg\corrupt-videos.log"
