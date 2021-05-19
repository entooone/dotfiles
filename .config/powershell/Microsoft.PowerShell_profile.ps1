# $MaximumHistoryCount = 1000000
function ls { exa -F $args }
function ll { ls -l $args }
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }
function ..... { Set-Location ../../../.. }

Remove-Alias history
function history { 
    [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems().CommandLine
}

function Prompt {
    Write-Host
    Write-Host "$(Get-Date -UFormat "%H:%M:%S")" -ForegroundColor Magenta -NoNewline
    Write-Host " " -NoNewline
    Write-Host "$([Environment]::UserName)@$([Environment]::UserDomainName)" -ForegroundColor Green -NoNewline
    Write-Host " " -NoNewline
    Write-Host $(Get-Location).Path.Replace("$home", "~") -ForegroundColor Yellow
    return "$ "
}