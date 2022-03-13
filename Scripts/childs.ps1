if ($IsWindows) {
    $source = "C:\Users\me\devel\dotfiles"
    $childs = @(
        # "$env:LOCALAPPDATA\nvim"
        "$env:OneDrive\Documents\PowerShell"
    )
}
elseif ($IsLinux -eq "True") {
    Write-Host "TODO"
}

if ($args[0] -eq "get") {
    foreach ($child in $childs) {
        Write-Host $child $source
        Copy-Item -Recurse -Force $child $source
    }
}
elseif ($args[0] -eq "push") {
    foreach ($child in $childs) {
        $target = Split-Path $child -leaf
        if (Test-Path $target -PathType Container) {
            $targets = Get-ChildItem($target)
            foreach ($tar in $targets) {
                Copy-Item -Recurse -Force $tar $child
            }
        } else {
            Copy-Item -Recurse -Force "$source\$target" $child
        }
    }
}
else {
    Write-Warning "invalid arguments. Valid arguments are: get, push"
}

