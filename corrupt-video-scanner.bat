@ECHO OFF
ECHO //////////////////////////////////////////////////////////////////
ECHO SCAN IN PROGRESS - PRESS CTRL + C TO CANCEL THE BATCH PROCESS.
ECHO //////////////////////////////////////////////////////////////////
ECHO.
ECHO A text file will open to show the list of videos that are corrupt.

SET "filtro=%1"
IF [%filtro%]==[] (
	SET "filtro=*.mp4"
	)

FOR /R %%a IN (%filtro%) DO CALL :doWork "%%a"
	DEL "%temp%\corrupt-temp.log"
	START "" "%temp%\corrupt-videos.log"
	EXIT /B

:doWork
	C:\ffmpeg\bin\ffmpeg.exe -v error -i %1 -f null - > "%temp%\corrupt-temp.log" 2>&1
	FOR /f %%i IN ("%temp%\corrupt-temp.log") DO SET size=%%~zi	
	IF [%size%] GTR [0] ( 
		ECHO %1 is corrupt. >> "%temp%\corrupt-videos.log"
		)
