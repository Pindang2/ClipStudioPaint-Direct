@echo off
@chcp 949
:: init
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
IF NOT %VERSION% == 10.0 (
    echo �� ��ũ��Ʈ�� ������ 10������ �����˴ϴ�.
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
echo.  Clip Studio Paint �ٷ� ���� ���� �ý���
echo.               %ESC%[107;36mby Pindang2%ESC%[0m
echo.
echo.
echo.
echo.
echo ============================================

:: BatchGotAdmin from https://superuser.com/questions/788924/is-it-possible-to-automatically-run-a-batch-file-as-administrator
REM �۹̼� üũ
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM ���� �޽��� �м�
if '%errorlevel%' NEQ '0' (
    echo %ESC%[107;91m!^>%ESC%[0m �� �۾��� ������ ������ �ʿ�� �մϴ�. ������ ��ٸ��� ��..
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
Echo %ESC%[107;36m#^>%ESC%[0m �м� ��: %shortcut%
timeout 3 >NUL
IF exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\CLIP STUDIO\CLIP STUDIO.lnk" ( 
    echo.
) else (
    cls
    echo ============================================
    echo.
    echo %ESC%[107;91m!^>%ESC%[0m Clip Studio�� ã�� �� �����ϴ�. �ش� ���α׷��� ��ġ�ϼ̴��� Ȯ�����ּ���.
    echo %ESC%[107;91m!^>%ESC%[0m ��ġ�ϼ̴ٸ�, ���α׷��� ��ġ�� �� ���� �޴��� �߰����� �����̴��� Ȯ�����ּ���.
    echo %ESC%[107;91m!^>%ESC%[0m ���α׷��� �����մϴ�. �����մϴ�.
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
Echo %ESC%[107;36m#^>%ESC%[0m%ESC%[92m Clip Studio ������: "%target%"
timeout 3 >NUL
:: End

powershell -Command "\"%target%\".length" > targetlen
set /p targetlen= < targetlen
del targetlen
echo %ESC%[107;36m#^>%ESC%[0m ���� ��ġ�� ����ϴ� ��..

set forcutn=%targetlen%-26
powershell -Command "\"%target%\".Substring(0, %forcutn%)" > targettolnk
set /p targettolnk= < targettolnk
del targettolnk
echo %ESC%[107;36m#^>%ESC%[0m ��ǥ �н�: %targettolnk%\CLIP STUDIO PAINT\
IF exist "%targettolnk%\CLIP STUDIO PAINT\CLIPStudioPaint.exe" ( 
    Echo %ESC%[107;36m#^>%ESC%[0m Clip Studio Paint�� ã�ҽ��ϴ�.
    timeout 1 >NUL
) else (
    cls
    echo %ESC%[0m ============================================
    echo.
    echo %ESC%[107;91m!^>%ESC%[0m Clip Studio�� ã������ Clip Studio Paint�� ã�� �� �����ϴ�.
    echo %ESC%[107;91m!^>%ESC%[0m �ش� ���α׷��� ��ġ���� �����̴ٸ�, Clip Studio ���α׷��� �̿��� Paint�� ��ġ���ּ���.
    echo %ESC%[107;91m!^>%ESC%[0m ��ġ�ϼ̴ٸ�, ���α׷��� ��ġ�� �� Clip Studio�� �ٸ� ��η� ��ġ���� �����̴��� Ȯ�����ּ���.
    echo %ESC%[107;91m!^>%ESC%[0m ���α׷��� �����մϴ�. �����մϴ�. %ESC%[0m
    echo.
    echo ============================================
    echo.
    pause
    exit
)

Echo %ESC%[107;36m#^>%ESC%[0m Clip Studio Paint�� �ٷΰ��⸦ ���� �޴��� �߰��ϴ� ��..
echo =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
echo %ESC%[107;36m#^>%ESC%[0m ��ũ��Ʈ�� ����� ��..
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\CLIP STUDIO\CLIP STUDIO Paint.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "%targettolnk%\CLIP STUDIO PAINT\CLIPStudioPaint.exe" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
echo %ESC%[107;36m#^>%ESC%[0m ��ũ��Ʈ ����..%ESC%[96m 
echo.
cscript CreateShortcut.vbs
del CreateShortcut.vbs
echo %ESC%[0m =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
timeout 2 >NUL
Echo %ESC%[107;36m#^>%ESC%[0m%ESC%[92m �Ϸ� %ESC%[0m
timeout 3 >NUL

echo ============================================
echo.
echo %ESC%[107;36m#^>%ESC%[0m%ESC%[96m ������ ���ƽ��ϴ�. Clip Studio Paint ���α׷��� ���� �޴����� ã�ų� �˻��Ͽ� �ٷ� �����Ͻ� �� �ֽ��ϴ�.%ESC%[0m
echo %ESC%[107;36m#^>%ESC%[0m Ȥ�� �������α׷��� Clip Studio Paint�� ���ٸ�, 
echo %ESC%[107;36m#^>%ESC%[0m ���α׷��� �����մϴ�. �����մϴ�.
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