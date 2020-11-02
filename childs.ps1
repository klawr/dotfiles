if ($IsWindows) {
    $childs = @(
        "$env:LOCALAPPDATA\nvim\init.vim"
        "$env:OneDrive\Documents\PowerShell"
    )
}
elseif ($IsLinux -eq "True") {
    Write-Host "TODO"
}

if ($args[0] -eq "get") {
    foreach ($child in $childs) {
    	$target = Split-Path $child -leaf
        Copy-Item -Recurse -Confirm -Force $child $target
    }
}
elseif ($args[0] -eq "push") {
    foreach ($child in $childs) {
    	$target = Split-Path $child -leaf
        Copy-Item -Recurse -Confirm -Force $target $child
    }
}
else {
    Write-Warning "arguments are get and push" -ForegroundColor Yellow
}

