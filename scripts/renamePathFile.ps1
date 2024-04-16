# Rename the project file
function Rename-PathFile($projectName, $newProjectName) {
    $pathFilePath = Join-Path $ProjectsDir "$projectName.txt"
    if (Test-Path -Path $pathFilePath -PathType Leaf) {
        $newPathFilePath = Join-Path $ProjectsDir "$newProjectName.txt"
        Rename-Item -Path $pathFilePath -NewName $newPathFilePath -Force
        Write-ColorText "Racoon set the name for '$projectName' to '$newProjectName'." "Green"
    } else {
        Write-ColorText "Raccon didnt found the project file for '$projectName'." "Red"
    }
}