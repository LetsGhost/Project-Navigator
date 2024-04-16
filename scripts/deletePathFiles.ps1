# Deletes the project file
function Delete-PathFile($projectName) {
    $pathFilePath = Join-Path $ProjectsDir "$projectName.txt"
    if (Test-Path -Path $pathFilePath -PathType Leaf) {
        Remove-Item -Path $pathFilePath -Force
        Write-ColorText "Racoon ate the project file for '$projectName'." "Green"
    } else {
        Write-ColorText "Raccon didnt found the project file for '$projectName'." "Red"
    }
}