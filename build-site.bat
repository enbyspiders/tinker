@echo off

:: Builds the website. Use 'npx @11ty/eleventy --serve' for live testing
set Comment=

set /p Comment="[45mGit Commit Message:[0m "

IF "%Comment%"=="" (
	set "errorlevel=No message provided"
	goto :error
)



ECHO.
ECHO [45m. . . . . GIT PUSH  . . . . . . . . .[0m
ECHO.


@echo on

git pull
git add .
git commit -m "%Comment%"
git push

@echo off
ECHO.
ECHO [45m. . . . . BUILDING WEBSITE  . . . . . . . . . .[0m
ECHO.
@echo on

call npx @11ty/eleventy --pathprefix=mysite/

@echo off
ECHO.
ECHO [45m. . . . . FTP UPLOAD  . . . . . . . . .[0m
ECHO.

echo open ftp://insert-ftp-adress-and-login-here.server.com/> ftpcmd.dat
echo lcd "_site">> ftpcmd.dat
echo synchronize remote>> ftpcmd.dat
echo close>> ftpcmd.dat
echo exit>> ftpcmd.dat
"C:\Program Files (x86)\WinSCP\WinSCP.com" /script=ftpcmd.dat


del ftpcmd.dat

:: PAUSE

exit /b

:error
echo Failed with error #%errorlevel%.
exit /b %errorlevel%