# Creates the project file for navigation
function Create-PathFile($projectName, $projectPath) {
    try{
        if (-not $projectPath) {
            $projectPath = Get-Location
        }
        $pathFilePath = Join-Path $ProjectsDir "$projectName.txt"
        $projectPath | Set-Content -Path $pathFilePath
        Write-Host "Racoon washed a project file for '$projectName'." -ForegroundColor Green

        exit 1
    } catch {
        Write-ColorText "Racoon couldnt create the project file for '$projectName'." "Red"
        exit 1
    }
}