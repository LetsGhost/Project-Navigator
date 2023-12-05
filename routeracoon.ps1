param(
    [string]$ProjectName
)

# Set the path to the directory where your project paths are stored
$ProjectsDir = Join-Path $env:USERPROFILE "Documents\projects"

# Functions 

# Writes the given string with a prefered color
function Write-ColorText($text, $color) {
    Write-Host $text -ForegroundColor $color
}

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

# Check for all flags

# Check if the -help flag is used
if ($ProjectName -eq "--help") {
    # List all available projects
    $ProjectsList = Get-ChildItem -Path $ProjectsDir -Filter *.txt | ForEach-Object { $_.BaseName }
    
    Write-ColorText "Usage: rr [project name] --[flag]" "DarkGray"
    Write-Host "The avalable options to command your RouteRaccon:"
    Write-ColorText "  --help       Display this help message" "DarkGray"
    Write-ColorText "  --open       Open the 'projects' directory in File Explorer" "DarkGray"
    Write-ColorText "  --list      Display available projects" "DarkGray"
    Write-ColorText "  --create     Create a new path file for a project" "DarkGray"
    Write-ColorText "  --delete     Delete a path file for a project" "DarkGray"
    Write-ColorText "  --setup      To create the 'projects' directory" "DarkGray"

    exit 0
}

# Check if the -open flag is used
if ($ProjectName -eq "--open") {
    Invoke-Item $ProjectsDir  # Open the 'projects' directory in File Explorer
    exit 0
}

# Check if the -open flag is used
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
    if (-not (Test-Path $ProjectsDir)) {
        New-Item -ItemType Directory -Path $ProjectsDir | Out-Null
        Write-Host "Racoon crafted the projects folder at '$ProjectsDir'." -ForegroundColor Green
    }
    exit 0
}

# Check if the --rename flag is used
if ($ProjectName -eq "--rename") {
    if ([string]::IsNullOrEmpty($args[1]) -or [string]::IsNullOrEmpty($args[2])) {
        Write-ColorText "Usage: rr --rename <project_name> <new_project_name>" "Red"
        exit 1
    }

    $ProjectName = $args[1]
    $NewProjectName = $args[2]

    Rename-PathFile $ProjectName $NewProjectName
    exit 0
}

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

# Logic to navigate

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
