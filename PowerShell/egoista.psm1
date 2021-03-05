#requires -Version 2 -Modules posh-git

function Write-Theme {
    $computername = $env:COMPUTERNAME.toLower()
    $prompt = ""
    $prompt += Write-Host -Object "$env:USERNAME" -ForegroundColor Green -NoNewline
    $prompt += Write-Host -Object "@" -ForegroundColor Cyan -NoNewline
    $prompt += Write-Host -Object "$computername " -ForegroundColor Red -NoNewline
    $prompt += Write-Host -Object "$pwd " -ForegroundColor Cyan -NoNewline

    $status = Get-VCSStatus
    if ($status) {
        $themeInfo = Get-VcsInfo -status ($status)
        $prompt += Write-Prompt -Object "<$($themeInfo.VcInfo)>" -ForegroundColor $themeInfo.BackgroundColor
    }

    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object "(env: $(Get-VirtualEnvName))"
    }

    $time = Get-Date -Format HH:mm:ss
    # $prompt += Set-CursorForRightBlockWrite -textLength $time.Length
    $prompt += Write-Prompt " $time" -ForegroundColor LightBlue

    $prompt += Set-Newline
    $prompt += "λ "

    $prompt
}

$s1 = $global:ThemeSettings
$s1.GitSymbols.BranchSymbol = ''
$s1.GitSymbols.BranchIdenticalStatusToSymbol = ''

