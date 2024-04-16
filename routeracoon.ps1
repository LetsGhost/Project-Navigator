param(
    [string]$ProjectName
)

# Set the path to the directory where your project paths are stored
$ProjectsDir = Join-Path $env:USERPROFILE "Documents\projects"

# Utils
. .\utils\writeColorText.ps1

# Functions
. .\scripts\createPathFile.ps1
. .\scripts\deletePathFiles.ps1
. .\scripts\renamePathFile.ps1
. .\scripts\setupProject.ps1

# Check for all flags

# Check if the -help flag is used
if ($ProjectName -eq "--help") {
      
    Write-ColorText "Usage: rr [project name] --[flag]" "DarkGray"
    Write-Host "The avalable options to command your RouteRaccon:"
    Write-ColorText "  --help       Display this help message" "DarkGray"
    Write-ColorText "  --open       Open the 'projects' directory in File Explorer" "DarkGray"
    Write-ColorText "  --list       Display available projects" "DarkGray"
    Write-ColorText "  --create     Create a new path file for a project" "DarkGray"
    Write-ColorText "  --delete     Delete a path file for a project" "DarkGray"
    Write-ColorText "  --setup      To create the 'projects' directory" "DarkGray"
    Write-ColorText "  --rename     Rename a path file for a project" "DarkGray"

    exit 0
}

# Check if the -open flag is used
if ($ProjectName -eq "--open") {
    Invoke-Item $ProjectsDir  # Open the 'projects' directory in File Explorer
    exit 0
}

# Check if the --list flag is used
if ($ProjectName -eq "--list") {
    $ProjectsList = Get-ChildItem -Path $ProjectsDir -Filter *.txt | ForEach-Object { $_.BaseName }

    Write-Host "Available projects:"

    $ProjectsList | ForEach-Object {
        Write-ColorText "  $_" "Yellow"
    }
    exit 0
}

# Check if the --create flag is used
if ($ProjectName -eq "--create") {
    if ($args.Count -lt 1) {
        Write-ColorText "Usage: rr --create <project_name> [<project_path>]" "Red"
        exit 1
    }

    $ProjectName = $args[0]
    $ProjectPath = $args[1]

    if (-not $ProjectPath) {
        $ProjectPath = Get-Location
    }

    $pathFilePath = Join-Path $ProjectsDir "$projectName.txt"
    $projectPath | Set-Content -Path $pathFilePath
    Write-Host "Racoon washed a project file for '$projectName'." -ForegroundColor Green
    exit 0
}

# Check if the --delete flag is used
if ($ProjectName -eq "--delete") {
    if ([string]::IsNullOrEmpty($args[0])) {
        Write-ColorText "Usage: rr --delete <project_name>" "Red"
        exit 1
    }

    $ProjectName = $args[0]

    Delete-PathFile $ProjectName
    exit 0
}

# Check if the --setup flag is used
if($ProjectName -eq "--setup") {
    Create-ProjectsDir
    exit 0
}

# Check if the --rename flag is used
if ($ProjectName -eq "--rename") {

    if ([string]::IsNullOrEmpty($args[0]) -or [string]::IsNullOrEmpty($args[1])) {
        Write-ColorText "Usage: rr --rename <project_name> <new_project_name>" "Red"
        exit 1
    }

    $ProjectName = $args[0]
    $NewProjectName = $args[1]

    Rename-PathFile $ProjectName $NewProjectName
    exit 0
}

# Logic to navigate

# Check if the projects folder exists
if (-not (Test-Path $ProjectsDir)) {
    Write-ColorText "Racoon didnt found the projects folder." "Red"
    Write-ColorText "Please run rr --setup to create the folder." "Red"
    exit 0
}

# Check if a project name was provided as an argument
if ([string]::IsNullOrEmpty($ProjectName)) {
    Write-ColorText "You have to say the projects name to RouteRacoon" "Red"
    exit 1
}

# Construct the project file path
$ProjectFilePath = Join-Path $ProjectsDir "$ProjectName.txt"

# Check if the project file exists
if (-not (Test-Path -Path $ProjectFilePath -PathType Leaf)) {
    Write-ColorText "Racoon didnt found '$ProjectName' in the projects folder." "Red"
    exit 1
}

# Load the project path and navigate to it
$ProjectPath = Get-Content -Path $ProjectFilePath
Set-Location -Path $ProjectPath

Write-ColorText "Racoon navigated you to '$ProjectName' at '$ProjectPath'." "Green"
