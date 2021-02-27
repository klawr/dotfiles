Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-Theme egoista

$paths = @(
    "$env:ProgramData\Miniconda3\Scripts\conda.exe"
    "$env:ProgramFiles\Mozilla Firefox\firefox.exe"
    "$env:OneDrive\Documents\nvim-win64\Neovim\bin\nvim.exe"
    "$env:LocalAppData\Microsoft\Edge SxS\Application\msedge.exe"
)

foreach ($path in $paths) {
    $leaf = [System.IO.Path]::GetFileNameWithoutExtension($path)
    if (Test-Path $path) {
        Set-Alias $leaf $path;
    } else {
        Write-Host "$leaf not installed at $path" -ForegroundColor Yellow
    }
}

Set-Alias c clear

Function lsd {
    ls | Select-Object -ExpandProperty Name | Join-String -Separator "`t"
}

Function .. { Set-Location .. }
Function ... { Set-Location ../.. }
Function .... { Set-Location ../../.. }
Function ..... { Set-Location ../../../.. }

Function gs { git status }
Function gd { git diff $args }

Function ddg {
    $arg = $args | Join-String -Separator "+"
    msedge "https://duckduckgo.com/?q=$arg"
}

Function CLEANTEMP {
    Remove-Item -Recurse -Force -ErrorAction Ignore $env:TEMP
}

Function DEV {
    $path = "$HOME\devel"

    foreach ($arg in $args) {
        $result = @(Get-ChildItem($path) -Directory).BaseName -match $arg
        if ($result.length -eq 0 -or $result -eq $False) {
            Write-Host No match found -ForegroundColor Red
            Write-Host (Get-ChildItem($path) -Directory).BaseName -Separator `n -ForegroundColor Yellow
        }
        elseif ($result.Length -gt 1) {
            Write-Host Ambiguity -ForegroundColor Red
            Write-Host $result -ForegroundColor Yellow -Separator `n
            foreach ($res in $result) {
                if ($arg -eq $res) {
                    Write-Host "Navigating to $res" -ForegroundColor Green
                    $path = "$path\$res"
                }
            }
        }
        else {
            $path = "$path\$result"
        }
    }

    Set-Location "$path"
}

Set-Variable PROFILEPATH $HOME\OneDrive\Documents\PowerShell
Function PROFILE {
    nvim $PROFILEPATH\profile.ps1
}

Function nvimconfig {
    nvim $HOME\AppData\Local\nvim\init.vim
}

Function vi {
    nvim $args
}
            
# # This command is used for the deepmech project, where certain webpack stuff is not working...
Set-Variable -Name DEVPATH -Value $HOME\devel\deepmech\gh-pages 
Function LAZY {
    Get-ChildItem -Path $DEVPATH\dist\dist -Recurse -File | Move-Item -Destination $DEVPATH\dist
    Remove-Item $DEVPATH\dist\dist
}
# Figured I repeat this too often in said project:
Function BUILD {
    if ((Get-Location).path -eq $DEVPATH) {
        yarn run build
        LAZY
        git add -A
        git commit -m "Build bundle"
        git push
        Write-Host "Finished 😊" -ForegroundColor Green
    } else {
        Write-Host "You are not in " $DEVPATH -ForegroundColor Red
        Write-Host "Type DEV to get there..." -ForegroundColor Red
    }
}

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\ProgramData\Miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

