@echo off
@chcp 949
:: init
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
IF NOT %VERSION% == 10.0 (
    echo 이 스크립트는 윈도우 10에서만 지원됩니다.
    pause
    exit
)
call :setESC
cls
echo %ESC%[0m
echo.
echo.
echo.
echo.
echo.  Clip Studio Paint 바로 가기 생성 시스템
echo.               %ESC%[107;36mby Pindang2%ESC%[0m
echo.
echo.
echo.
echo.
echo ============================================

:: BatchGotAdmin from https://superuser.com/questions/788924/is-it-possible-to-automatically-run-a-batch-file-as-administrator
REM 퍼미션 체크
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM 에러 메시지 분석
if '%errorlevel%' NEQ '0' (
    echo %ESC%[107;91m!^>%ESC%[0m 이 작업은 관리자 권한을 필요로 합니다. 권한을 기다리는 중..
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:: --------------------------------------


:: Got code from https://www.computerhope.com/forum/index.php?topic=80659.0 Start
Set Shortcut=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\CLIP STUDIO\CLIP STUDIO.lnk
Echo %ESC%[107;36m#^>%ESC%[0m 분석 중: %shortcut%
timeout 3 >NUL
IF exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\CLIP STUDIO\CLIP STUDIO.lnk" ( 
    echo.
) else (
    cls
    echo ============================================
    echo.
    echo %ESC%[107;91m!^>%ESC%[0m Clip Studio를 찾을 수 없습니다. 해당 프로그램을 설치하셨는지 확인해주세요.
    echo %ESC%[107;91m!^>%ESC%[0m 설치하셨다면, 프로그램을 설치할 때 시작 메뉴에 추가하지 않으셨는지 확인해주세요.
    echo %ESC%[107;91m!^>%ESC%[0m 프로그램을 종료합니다. 감사합니다.
    echo.
    echo ============================================
    echo.
    pause
    exit
)

echo set WshShell = WScript.CreateObject("WScript.Shell")>DecodeShortCut.vbs
echo set Lnk = WshShell.CreateShortcut(WScript.Arguments.Unnamed(0))>>DecodeShortCut.vbs
echo wscript.Echo Lnk.TargetPath>>DecodeShortCut.vbs
set vbscript=cscript //nologo DecodeShortCut.vbs
For /f "delims=" %%T in ( ' %vbscript% "%Shortcut%" ' ) do set target=%%T
del DecodeShortCut.vbs
Echo %ESC%[107;36m#^>%ESC%[0m%ESC%[92m Clip Studio 감지됨: "%target%"
timeout 3 >NUL
:: End

powershell -Command "\"%target%\".length" > targetlen
set /p targetlen= < targetlen
del targetlen
echo %ESC%[107;36m#^>%ESC%[0m 파일 위치를 계산하는 중..

set forcutn=%targetlen%-26
powershell -Command "\"%target%\".Substring(0, %forcutn%)" > targettolnk
set /p targettolnk= < targettolnk
del targettolnk
echo %ESC%[107;36m#^>%ESC%[0m 목표 패스: %targettolnk%\CLIP STUDIO PAINT\
IF exist "%targettolnk%\CLIP STUDIO PAINT\CLIPStudioPaint.exe" ( 
    Echo %ESC%[107;36m#^>%ESC%[0m Clip Studio Paint를 찾았습니다.
    timeout 1 >NUL
) else (
    cls
    echo %ESC%[0m ============================================
    echo.
    echo %ESC%[107;91m!^>%ESC%[0m Clip Studio는 찾았으나 Clip Studio Paint를 찾을 수 없습니다.
    echo %ESC%[107;91m!^>%ESC%[0m 해당 프로그램을 설치하지 않으셨다면, Clip Studio 프로그램을 이용해 Paint를 설치해주세요.
    echo %ESC%[107;91m!^>%ESC%[0m 설치하셨다면, 프로그램을 설치할 때 Clip Studio와 다른 경로로 설치하진 않으셨는지 확인해주세요.
    echo %ESC%[107;91m!^>%ESC%[0m 프로그램을 종료합니다. 감사합니다. %ESC%[0m
    echo.
    echo ============================================
    echo.
    pause
    exit
)

Echo %ESC%[107;36m#^>%ESC%[0m Clip Studio Paint의 바로가기를 시작 메뉴에 추가하는 중..
echo =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
echo %ESC%[107;36m#^>%ESC%[0m 스크립트를 만드는 중..
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\CLIP STUDIO\CLIP STUDIO Paint.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%targettolnk%\CLIP STUDIO PAINT\CLIPStudioPaint.exe" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
echo %ESC%[107;36m#^>%ESC%[0m 스크립트 실행..%ESC%[96m 
echo.
cscript CreateShortcut.vbs
del CreateShortcut.vbs
echo %ESC%[0m =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
timeout 2 >NUL
Echo %ESC%[107;36m#^>%ESC%[0m%ESC%[92m 완료 %ESC%[0m
timeout 3 >NUL

echo ============================================
echo.
echo %ESC%[107;36m#^>%ESC%[0m%ESC%[96m 설정을 마쳤습니다. Clip Studio Paint 프로그램을 시작 메뉴에서 찾거나 검색하여 바로 실행하실 수 있습니다.%ESC%[0m
echo %ESC%[107;36m#^>%ESC%[0m 혹시 시작프로그램에 Clip Studio Paint가 없다면, 
echo %ESC%[107;36m#^>%ESC%[0m 프로그램을 종료합니다. 감사합니다.
echo.
echo ============================================
echo.
pause
exit

:: CMD Color per character
:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)