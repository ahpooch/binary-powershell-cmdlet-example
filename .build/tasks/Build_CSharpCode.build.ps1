task BuildCSharpCode {
    Push-Location 
}

# Synopsis: Deleting the content of the Build Output folder, except ./modules
task Clean {
    $OutputDirectory =  Get-SamplerAbsolutePath -Path $OutputDirectory -RelativeTo $BuildRoot
    $FolderToExclude = Split-Path -Leaf -Path $RequiredModulesDirectory

    Write-Build -Color Green "Removing $OutputDirectory\* excluding $FolderToExclude"

    Get-ChildItem -Path $OutputDirectory -Exclude $FolderToExclude | Remove-Item -Force -Recurse
}

# Synopsis: Removes the Modules from OutputDirectory\Modules folder, might fail if there's an handle on one file.
task CleanModule {
    $OutputDirectory =  Get-SamplerAbsolutePath -Path $OutputDirectory -RelativeTo $BuildRoot

    Write-Build -Color Green "Removing $OutputDirectory\*"

    Get-ChildItem $OutputDirectory | Remove-Item -Force -Recurse -ErrorAction 'Stop'
}
