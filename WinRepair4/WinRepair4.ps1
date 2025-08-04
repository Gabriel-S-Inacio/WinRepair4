<#
.Sinopse
    Ferramenta de Reparo Avançado para Windows 10/11.

.Descrição
    Script em PowerShell que reúne diversas rotinas de manutenção e diagnóstico
    para sistemas Windows. Inclui verificações de sistema, limpeza, restauração,
    serviços, e testes de hardware.

.Autor
    Gabriel Santos Inácio

.Data de criação
    10/06/2025

.Notas
    É necessário executar como Administrador.
#>

# Verificar se está em modo administrador

Write-Host "Bem-vindo ao WinRepair4! Leia o README.md para instrucoes de uso." -ForegroundColor Yellow
Start-Sleep -Seconds 3
Clear-Host

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Por favor, execute este script como Administrador!"
    pause
    exit
}

function Mostrar-Menu {
    Clear-Host
    Write-Host "============================================================="
    Write-Host "        FERRAMENTA PROFISSIONAL DE REPARO DO WINDOWS"
    Write-Host "============================================================="
    Write-Host "              Compatível com Windows 10 e 11"
    Write-Host "-------------------------------------------------------------"
    Write-Host "[1]  Verificar e reparar arquivos do sistema (SFC)"
    Write-Host "[2]  Reparar imagem do Windows (DISM)"
    Write-Host "[3]  Verificar e corrigir erros no disco (CHKDSK)"
    Write-Host "[4]  Resetar componentes do Windows Update"
    Write-Host "[5]  Limpeza de arquivos temporários"
    Write-Host "[6]  Restaurar permissões do sistema"
    Write-Host "[7]  Limpeza avançada com Cleanmgr"
    Write-Host "[8]  Criar ponto de restauração"
    Write-Host "[9]  Ver uso de disco e memória"
    Write-Host "[10] Reiniciar serviços essenciais"
    Write-Host "-------------------------------------------------------------"
    Write-Host "[11] Reparar setor de boot (BCD)"
    Write-Host "[12] Reinstalar apps padrão da Microsoft Store"
    Write-Host "[13] Reset total de permissões NTFS (acesso negado)"
    Write-Host "[14] Backup automático de logs do sistema"
    Write-Host "[15] Verificar integridade de drivers"
    Write-Host "[16] Reset completo do Firewall do Windows"
    Write-Host "[17] Limpeza de cache (DNS, Store, Windows Update)"
    Write-Host "[18] Sincronizar data e hora automaticamente"
    Write-Host "-------------------------------------------------------------"
    Write-Host "[19] Testes de Hardware"
    Write-Host "[20] Limpeza Profunda Avançada"
    Write-Host "-------------------------------------------------------------"
    Write-Host "[0]  Sair"
    Write-Host "============================================================="
}

function Executar-Comando($titulo, [scriptblock]$acao) {
    Clear-Host
    Write-Host $titulo -ForegroundColor Cyan
    & $acao
    pause
}

# Funções principais
function Opcao1 { Executar-Comando "Executando SFC..." { sfc /scannow } }
function Opcao2 { Executar-Comando "Executando DISM..." { DISM /Online /Cleanup-Image /RestoreHealth } }
function Opcao3 { Executar-Comando "Executando CHKDSK..." { chkdsk C: /f /r } }
function Opcao4 {
    Executar-Comando "Resetando Windows Update..." {
        net stop wuauserv
        net stop bits
        net stop cryptsvc
        Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "SoftwareDistribution.old" -Force -ErrorAction SilentlyContinue
        Rename-Item -Path "C:\Windows\System32\catroot2" -NewName "catroot2.old" -Force -ErrorAction SilentlyContinue
        net start wuauserv
        net start bits
        net start cryptsvc
    }
}
function Opcao5 {
    Executar-Comando "Limpando arquivos temporários..." {
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    }
}
function Opcao6 {
    Executar-Comando "Restaurando permissões padrão..." {
        secedit /configure /cfg $env:windir\inf\defltbase.inf /db defltbase.sdb /verbose
    }
}
function Opcao7 {
    Executar-Comando "Executando Cleanmgr..." {
        cleanmgr /sagerun:1
    }
}
function Opcao8 {
    Executar-Comando "Criando ponto de restauração..." {
        Checkpoint-Computer -Description "ReparoAvancado" -RestorePointType "MODIFY_SETTINGS"
    }
}
function Opcao9 {
    Executar-Comando "Verificando uso de disco e memória..." {
        Get-PSDrive -PSProvider FileSystem
        systeminfo | findstr /C:"Memória física"
    }
}
function Opcao10 {
    Executar-Comando "Reiniciando serviços essenciais..." {
        net start trustedinstaller
        sc config wuauserv start= auto
        sc config bits start= auto
    }
}

# Ações adicionais
function Opcao11 {
    Executar-Comando "Reparando setor de boot..." {
        bootrec /fixmbr
        bootrec /fixboot
        bootrec /scanos
        bootrec /rebuildbcd
    }
}
function Opcao12 {
    Executar-Comando "Reinstalando apps padrão..." {
        Get-AppxPackage -AllUsers | ForEach-Object {
            Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"
        }
    }
}
function Opcao13 {
    Executar-Comando "Resetando permissões NTFS..." {
        icacls C:\ /T /Q /C /RESET
    }
}
function Opcao14 {
    Executar-Comando "Gerando log do sistema..." {
        systeminfo > "$PSScriptRoot\log_sistema.txt"
        Write-Host "Log salvo em $PSScriptRoot\log_sistema.txt"
    }
}
function Opcao15 {
    Executar-Comando "Verificando drivers..." {
        driverquery /FO TABLE /SI
    }
}
function Opcao16 {
    Executar-Comando "Resetando Firewall..." {
        netsh advfirewall reset
    }
}
function Opcao17 {
    Executar-Comando "Limpando cache DNS e outros..." {
        ipconfig /flushdns
        Clear-WindowsUpdateDownloadCache
        Start-Process -FilePath "wsreset.exe"
    }
}
function Opcao18 {
    Executar-Comando "Sincronizando data/hora..." {
        w32tm /resync
    }
}

# Testes de hardware
function Opcao19 {
    Clear-Host
    Write-Host "TESTES DE HARDWARE"
    Write-Host "[1] Uso da CPU"
    Write-Host "[2] Diagnóstico de Memória"
    Write-Host "[3] Status do Disco (SMART)"
    Write-Host "[4] Informações da GPU"
    Write-Host "[0] Voltar"
    $sub = Read-Host "Escolha uma opção"
    switch ($sub) {
        "1" { wmic cpu get loadpercentage; pause }
        "2" { Start-Process "mdsched.exe" }
        "3" { wmic diskdrive get status; pause }
        "4" { wmic path win32_VideoController get name; pause }
        "0" { return }
    }
}

# Limpeza Profunda
function Opcao20 {
    Clear-Host
    Write-Host "LIMPEZA PROFUNDA AVANÇADA"
    Write-Host "[1] Limpar logs do sistema"
    Write-Host "[2] Limpar cache de miniaturas"
    Write-Host "[3] Limpar Prefetch"
    Write-Host "[4] Limpar Temp e Lixeira (PowerShell)"
    Write-Host "[0] Voltar"
    $deep = Read-Host "Escolha uma opção"
    switch ($deep) {
        "1" { Remove-Item "C:\Windows\Logs\*" -Recurse -Force -ErrorAction SilentlyContinue; pause }
        "2" { Remove-Item "$env:LOCALAPPDATA\Microsoft\Windows\Explorer\thumbcache*" -Force -ErrorAction SilentlyContinue; pause }
        "3" { Remove-Item "C:\Windows\Prefetch\*" -Force -Recurse -ErrorAction SilentlyContinue; pause }
        "4" {
            Get-ChildItem -Path $env:TEMP -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
            Clear-RecycleBin -Force
            pause
        }
        "0" { return }
    }
}

# Loop principal
do {
    Mostrar-Menu
    $escolha = Read-Host "Digite o número da opção desejada"
    switch ($escolha) {
        "1"  { Opcao1 }
        "2"  { Opcao2 }
        "3"  { Opcao3 }
        "4"  { Opcao4 }
        "5"  { Opcao5 }
        "6"  { Opcao6 }
        "7"  { Opcao7 }
        "8"  { Opcao8 }
        "9"  { Opcao9 }
        "10" { Opcao10 }
        "11" { Opcao11 }
        "12" { Opcao12 }
        "13" { Opcao13 }
        "14" { Opcao14 }
        "15" { Opcao15 }
        "16" { Opcao16 }
        "17" { Opcao17 }
        "18" { Opcao18 }
        "19" { Opcao19 }
        "20" { Opcao20 }
        "0"  { break }
        default { Write-Host "Opção inválida!" -ForegroundColor Red; pause }
    }
} while ($true)
