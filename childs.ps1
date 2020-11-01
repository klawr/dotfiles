if ($IsWindows) {
    $childs = @(
        "$env:LOCALAPPDATA/nvim/init.vim"
        "$env:OneDrive/Documents/PowerShell"
    )
}
elseif ($IsLinux -eq "True") {
    Write-Host "TODO"
}

if ($args[0] -eq "get") {
    foreach ($child in $childs) {
        Copy-Item -Confirm -Force $child "./$((Get-ChildItem $child).name)"
    }
}
elseif ($args[0] -eq "push") {
    # TODO
}
else {
    Write-Warning "arguments are get and push" -ForegroundColor Yellow
}

