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
    $prompt += Set-Newline
    $prompt += "λ "

    $prompt
}

$s1 = $global:ThemeSettings
$s1.GitSymbols.BranchSymbol = ''
$s1.GitSymbols.BranchIdenticalStatusToSymbol = ''

