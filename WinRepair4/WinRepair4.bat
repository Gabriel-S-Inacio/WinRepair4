@echo off
REM =============================================================
REM .Sinopse
REM     Ferramenta de Reparo Avançado para Windows 10/11.
REM 
REM .Descrição
REM     Script em Batch que reúne diversas rotinas de manutenção e diagnóstico
REM     para sistemas Windows. Inclui verificações de sistema, limpeza, restauração,
REM     serviços, e testes de hardware.
REM 
REM .Autor
REM     Gabriel Santos Inácio
REM 
REM .Data de criação
REM     02/02/2025
REM 
REM .Notas
REM     É necessário executar como Administrador.
REM =============================================================

@echo off
echo --------------------------------------
echo Bem-vindo ao WinRepair4!
echo Leia o README.md para instrucoes de uso.
pause
cls

@echo off
title Ferramenta de Reparacao Avancada - Windows 10/11
color 1F
mode con: cols=100 lines=40

:: Verificar permissao de administrador
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo [ERRO] Por favor, execute este script como Administrador!
    pause
    exit
)

:MENU
cls
echo =============================================================
echo         FERRAMENTA PROFISSIONAL DE REPARO DO WINDOWS
echo =============================================================
echo               Compativel com Windows 10 e 11
echo -------------------------------------------------------------
echo [1]  Verificar e reparar arquivos do sistema (SFC)
echo [2]  Reparar imagem do Windows (DISM)
echo [3]  Verificar e corrigir erros no disco (CHKDSK)
echo [4]  Resetar componentes do Windows Update
echo [5]  Limpeza de arquivos temporarios
echo [6]  Restaurar permissoes do sistema
echo [7]  Limpeza avancada com Cleanmgr
echo [8]  Criar ponto de restauracao
echo [9]  Ver uso de disco e memoria
echo [10] Reiniciar servicos essenciais
echo -------------------------------------------------------------
echo [11] Reparar setor de boot (BCD)
echo [12] Reinstalar apps padrao da Microsoft Store
echo [13] Reset total de permissoes NTFS (acesso negado)
echo [14] Backup automatico de logs do sistema
echo [15] Verificar integridade de drivers
echo [16] Reset completo do Firewall do Windows
echo [17] Limpeza de cache (DNS, Store, Windows Update)
echo [18] Sincronizar data e hora automaticamente
echo -------------------------------------------------------------
echo [19] Testes de Hardware
echo [20] Limpeza Profunda Avancada
echo -------------------------------------------------------------
echo [0]  Sair
echo =============================================================
set /p opcao=Digite o numero da opcao desejada: 

if "%opcao%"=="1"  goto SFC
if "%opcao%"=="2"  goto DISM
if "%opcao%"=="3"  goto CHKDSK
if "%opcao%"=="4"  goto WU
if "%opcao%"=="5"  goto LIMPEZA
if "%opcao%"=="6"  goto PERMISSOES
if "%opcao%"=="7"  goto CLEANMGR
if "%opcao%"=="8"  goto PONTO
if "%opcao%"=="9"  goto USO
if "%opcao%"=="10" goto SERVICOS
if "%opcao%"=="11" goto BCD
if "%opcao%"=="12" goto APPS
if "%opcao%"=="13" goto NTFS
if "%opcao%"=="14" goto LOGS
if "%opcao%"=="15" goto DRIVERS
if "%opcao%"=="16" goto FIREWALL
if "%opcao%"=="17" goto CACHE
if "%opcao%"=="18" goto HORA
if "%opcao%"=="19" goto TESTES_HW
if "%opcao%"=="20" goto LIMPEZA_PROFUNDA
if "%opcao%"=="0"  exit
goto MENU

:: Funções principais (1 a 10)
:SFC
cls
echo Verificando arquivos do sistema...
sfc /scannow
pause & goto MENU

:DISM
cls
echo Reparo da imagem do Windows...
DISM /Online /Cleanup-Image /RestoreHealth
pause & goto MENU

:CHKDSK
cls
echo Verificando disco...
chkdsk C: /f /r
pause & goto MENU

:WU
cls
echo Resetando Windows Update...
net stop wuauserv
net stop bits
net stop cryptsvc
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old
net start wuauserv
net start bits
net start cryptsvc
pause & goto MENU

:LIMPEZA
cls
echo Limpando arquivos temporários...
del /q /f /s %TEMP%\*
del /q /f /s C:\Windows\Temp\*
pause & goto MENU

:PERMISSOES
cls
echo Restaurando permissões padrão do sistema...
secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose
pause & goto MENU

:CLEANMGR
cls
echo Executando Cleanmgr...
cleanmgr /sagerun:1
pause & goto MENU

:PONTO
cls
echo Criando ponto de restauração...
powershell -command "Checkpoint-Computer -Description 'ReparoAvancado' -RestorePointType 'MODIFY_SETTINGS'"
pause & goto MENU

:USO
cls
echo Uso de disco e memória:
wmic logicaldisk get caption,freespace,size
systeminfo | findstr /C:"Memória física"
pause & goto MENU

:SERVICOS
cls
echo Reiniciando serviços essenciais...
net start trustedinstaller
sc config wuauserv start= auto
sc config bits start= auto
pause & goto MENU

:: Funções extras (11 a 18)
:BCD
cls
echo Reparando setor de inicialização...
bootrec /fixmbr
bootrec /fixboot
bootrec /scanos
bootrec /rebuildbcd
pause & goto MENU

:APPS
cls
echo Reinstalando apps padrão da Microsoft Store...
powershell -command "Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register '$($_.InstallLocation)\AppXManifest.xml'}"
pause & goto MENU

:NTFS
cls
echo Resetando permissões NTFS...
icacls C:\ /T /Q /C /RESET
pause & goto MENU

:LOGS
cls
echo Gerando log do sistema...
systeminfo > "%~dp0log_sistema.txt"
echo Log salvo em %~dp0log_sistema.txt
pause & goto MENU

:DRIVERS
cls
echo Verificando drivers com problemas...
driverquery /FO TABLE /SI
pause & goto MENU

:FIREWALL
cls
echo Resetando firewall...
netsh advfirewall reset
pause & goto MENU

:CACHE
cls
echo Limpando cache DNS, Store e Update...
ipconfig /flushdns
powershell -command "Clear-WindowsUpdateDownloadCache"
powershell -command "wsreset.exe"
pause & goto MENU

:HORA
cls
echo Sincronizando data e hora com servidor online...
w32tm /resync
pause & goto MENU

:TESTES_HW
cls
echo =====================================================
echo                  TESTES DE HARDWARE                 
echo =====================================================
echo [1] Verificar uso da CPU
echo [2] Diagnostico de Memoria (RAM)
echo [3] Verificar status do disco (SMART)
echo [4] Exibir informacoes da GPU
echo [0] Voltar ao menu principal
echo -----------------------------------------------------
set /p thw=Escolha uma opcao: 

if "%thw%"=="1" (
    echo Uso da CPU:
    wmic cpu get loadpercentage
    pause
    goto TESTES_HW
)
if "%thw%"=="2" (
    echo Executando diagnóstico de memória (requer reinicialização)...
    mdsched.exe
    goto MENU
)
if "%thw%"=="3" (
    echo Status do disco (SMART):
    wmic diskdrive get status
    pause
    goto TESTES_HW
)
if "%thw%"=="4" (
    echo Informações da GPU:
    wmic path win32_VideoController get name
    pause
    goto TESTES_HW
)
if "%thw%"=="0" goto MENU
goto MENU

:LIMPEZA_PROFUNDA
cls
echo =====================================================
echo               LIMPEZA PROFUNDA AVANCADA             
echo =====================================================
echo [1] Limpar arquivos de log do sistema
echo [2] Limpar cache de miniaturas
echo [3] Limpar Prefetch
echo [4] Esvaziar Lixeira e Temp com PowerShell
echo [0] Voltar ao menu principal
echo -----------------------------------------------------
set /p limp=Escolha uma opcao: 

if "%limp%"=="1" (
    echo Limpando logs do sistema...
    del /f /s /q C:\Windows\Logs\*.*
    pause
    goto LIMPEZA_PROFUNDA
)
if "%limp%"=="2" (
    echo Limpando cache de miniaturas...
    del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*"
    pause
    goto LIMPEZA_PROFUNDA
)
if "%limp%"=="3" (
    echo Limpando Prefetch...
    del /f /s /q C:\Windows\Prefetch\*.*
    pause
    goto LIMPEZA_PROFUNDA
)
if "%limp%"=="4" (
    echo Executando limpeza com PowerShell...
    powershell -command "Get-ChildItem -Path $env:TEMP -Recurse | Remove-Item -Force -Recurse"
    powershell -command "Clear-RecycleBin -Force"
    pause
    goto LIMPEZA_PROFUNDA
)
if "%limp%"=="0" goto MENU
goto MENU


