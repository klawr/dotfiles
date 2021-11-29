Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-Theme egoista
Set-Alias browser firefox
Set-Alias editor code

$paths = @(
    "$env:ProgramFiles\Mozilla Firefox\firefox.exe"
    # "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
    # "$env:OneDrive\Documents\nvim-win64\Neovim\bin\nvim.exe"
)
foreach ($path in $paths) {
    $leaf = [System.IO.Path]::GetFileNameWithoutExtension($path)
    if (Test-Path $path) {
        Set-Alias $leaf $path;
    } else {
        Write-Host "$leaf not installed at $path" -ForegroundColor Yellow
    }
}

Function take {
    if (-not (Test-Path($args[0]))) {
        mkdir $args[0] > $null
    }
    cd $args[0]
}

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
    browser "https://duckduckgo.com/?q=$arg"
}

Function DEV {
    $optionA = "D:\devel"
    $optionB = "C:\Users\me\devel"
    $path = if (Test-Path $optionA) { $optionA } else { $optionB }

    foreach ($arg in $args) {
        $base = (Get-ChildItem($path) -Directory).BaseName
        $result = $base -match $arg
        
        if ($result.length -eq 0 -or $result -eq $False) {
            Write-Host No match found -ForegroundColor Red
            Write-Host base -Separator `n -ForegroundColor Yellow
        }
        # If only 1 element is returned, $result is True
        if ($result -eq $True) {
            $path = "$path\$base"
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

Set-Variable PROFILEPATH $env:OneDrive\Documents\PowerShell
Function PROFILE {
    editor $PROFILEPATH\profile.ps1
}

Function nvimconfig {
    editor $HOME\AppData\Local\nvim\init.vim
}

Function vi {
    nvim $args
}

Function gh {
    $a = git remote -v | Select -First 1
    if (!$a) {
        return
    }
    $b = $a.indexOf('@')
    $c = $a.indexOf(' (fetch)')
    $d = $a.Substring($b+1, $c-$b)
    $e = $d.Replace(":", "/")
    browser "https://$e"
}
 
# I am sorry.
Function trottel {
    $command, $rest = $args
    if ($command -eq "hinzufügen") {
        git add $rest
    } elseif ($command -eq "bestätigen") {
        git commit $rest
    } elseif ($command -eq "unterscheiden") {
        git diff $rest
    } elseif ($command -eq "drücken") {
        git push $rest
    } elseif ($command -eq "ziehen") {
        git pull $rest
    } else {
        git $command $rest
    }
}

Function dot {
    try
    {
        $script, $arguments = $args

        pushd .
        dev dotfiles Scripts
        $leaf = (Split-Path @(Get-ChildItem(".")) -leaf)
        $result =  $leaf -match $script
        # Write-Host $result   
        if ($result.Length -eq 1) {
            switch ((Get-Item $result).Extension)
            {
                .py {
                    conda activate dotfiles
                    python $result $arguments
                    conda deactivate
                }
                .ps1 {
                    pwsh.exe $result $arguments
                }
                .bat {
                    pwsh.exe $result $arguments
                }
            }
        }
        elseif ($result.Length -gt 1) {
            Write-Host Ambiguity -ForegroundColor Red
            Write-Host $result -ForegroundColor Yellow -Separator `n
        }
        else {
            Write-Host "No match for $script" -ForegroundColor Red
        }
    }
    finally
    {
        popd
    }
}

Function esp {
    dev esp esp-idf
    ./export.ps1
    cd -
}


#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\Users\me\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion

