param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("install", "uninstall")]
    [string]$Command,

    [Parameter(Position = 1)]
    [string]$Script
)

$TaskName = "SmartCapsLock"

function Find-AutoHotkey {
    $cmd = Get-Command "AutoHotkey64.exe" -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    $cmd = Get-Command "AutoHotkey.exe" -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    throw "AutoHotkey v2 not found in PATH."
}

function Resolve-ScriptPath($Path) {
    if (-not $Path) { throw "Script path required" }

    # 展开 ~
    if ($Path.StartsWith("~")) {
        $Path = Join-Path $HOME $Path.Substring(1)
    }

    # 如果是相对路径，优先相对于当前目录
    if (-not [System.IO.Path]::IsPathRooted($Path)) {
        $cwdPath = Join-Path (Get-Location) $Path
        if (Test-Path $cwdPath) {
            return (Resolve-Path $cwdPath).Path
        }

        # fallback：相对于当前 ps1 所在目录
        $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
        $altPath = Join-Path $scriptDir $Path
        if (Test-Path $altPath) {
            return (Resolve-Path $altPath).Path
        }

        throw "Script not found: $Path"
    }

    # 已经是绝对路径
    if (Test-Path $Path) {
        return (Resolve-Path $Path).Path
    }

    throw "Script not found: $Path"
}

if ($Command -eq "install") {
    $Script = Resolve-ScriptPath $Script
    $AhkExe = Find-AutoHotkey

    $Action = New-ScheduledTaskAction `
        -Execute $AhkExe `
        -Argument "`"$Script`""

    $Trigger = New-ScheduledTaskTrigger -AtLogOn

    $Principal = New-ScheduledTaskPrincipal `
        -UserId "$env:USERDOMAIN\$env:USERNAME" `
        -LogonType Interactive `
        -RunLevel Highest

    $Settings = New-ScheduledTaskSettingsSet `
        -ExecutionTimeLimit (New-TimeSpan -Hours 0)

    Register-ScheduledTask `
        -TaskName $TaskName `
        -Action $Action `
        -Trigger $Trigger `
        -Principal $Principal `
        -Settings $Settings `
        -Force | Out-Null

    Start-ScheduledTask -TaskName $TaskName

    Write-Host "Installed:"
    Write-Host "  Script = $Script"
    Write-Host "  AHK    = $AhkExe"
}
elseif ($Command -eq "uninstall") {
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false -ErrorAction SilentlyContinue
    Write-Host "Uninstalled: $TaskName"
}