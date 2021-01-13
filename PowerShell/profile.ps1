
function global:prompt {
    $Drive = $pwd.Drive.Name
    $Pwds = $pwd -split "\\" | Where-Object { -Not [String]::IsNullOrEmpty($_) }
    $PwdPath = if ($Pwds.Count -gt 3) {
        $ParentFolder = Split-Path -Path (Split-Path -Path $pwd -Parent) -Leaf
        $CurrentFolder = Split-Path -Path $pwd -Leaf
        "..\$ParentFolder\$CurrentFolder"
    }
    elseif ($Pwds.Count -eq 3) {
        $ParentFolder = Split-Path -Path (Split-Path -Path $pwd -Parent) -Leaf
        $CurrentFolder = Split-Path -Path $pwd -Leaf
        "$ParentFolder\$CurrentFolder"
    }
    elseif ($Pwds.Count -eq 2) {
        Split-Path -Path $pwd -Leaf
    }
    else { "" }
 
    $Path = "$Drive`:\$PwdPath"
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    if ($IsAdmin) {          
        Write-Host -Object $Path -NoNewline -ForegroundColor DarkRed
    }
    else {
        Write-Host -Object $Path -NoNewline -ForegroundColor DarkGray
    }
 
    return "> "
}

$paths = @(
    "$env:ProgramData\Miniconda3\Scripts\conda.exe"
    "$env:ProgramFiles\Mozilla Firefox\firefox.exe"
    "$env:OneDrive\Documents\nvim-win64\Neovim\bin\nvim.exe"
    "$env:ProgramFiles (x86)\Microsoft\Edge\Application\msedge.exe"
)

foreach ($path in $paths) {
    $leaf = [System.IO.Path]::GetFileNameWithoutExtension($path)
    if (Test-Path $path) {
        Set-Alias $leaf $path;
    } else {
        Write-Host "$leaf not installed at $path" -ForegroundColor Yellow
    }
}

Function .. {
    cd ..
}

Function vim_cheatsheet {
    nvim $HOME/devel/dotfiles/docs/vim_cheatsheet.md
}

Function ddg {
    $arg = $args | Join-String -Separator "+"
    firefox "https://duckduckgo.com/?q=$arg"
}

Function CLEANTEMP {
    Remove-Item -Recurse -Force -ErrorAction Ignore $env:TEMP
}

Function lsd {
    ls | Select-Object -ExpandProperty Name | Join-String -Separator " "
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

    if (Test-Path "$path\.git") {
        LOAD_GIT_MODULE
    }
}

Set-Variable PROFILEPATH $HOME\OneDrive\Documents\PowerShell
Function PROFILE {
    nvim $PROFILEPATH\profile.ps1
    # code -n $PROFILEPATH -g $PROFILEPATH\profile.ps1
}

Set-Variable NVIMPROFILE $HOME\AppData\Local\nvim\init.vim
Function nvimconfig {
    nvim $NVIMPROFILE
}

Function vi {
    nvim $args
}

Function LOAD_GIT_MODULE {
    Write-Progress "Loading posh-git"
    Import-Module "$PROFILEPATH\Modules\posh-git\1.0.0\posh-git.psd1"
}
New-Alias -Name lgit -Value LOAD_GIT_MODULE


# This command is used for the deepmech project, where certain webpack stuff is not working...
Set-Variable -Name DEVPATH -Value $HOME\devel\deepmech\gh-pages 
Function LAZY {
    Move-Item -Force $DEVPATH\dist\dist\deepmech_bundle.js $DEVPATH\dist\deepmech_bundle.js
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

