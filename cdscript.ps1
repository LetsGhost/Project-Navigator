param(
    [string]$ProjectName
)

# Set the path to the directory where your project paths are stored
$ProjectsDir = "C:\Users\Ehrling\Documents\WindowsPowerShell\Scripts\CD-Script\projects"

# Function to display text in red color
function Write-ColorText($text, $color) {
    Write-Host $text -ForegroundColor $color
}

function Create-PathFile($projectName, $projectPath) {
    $pathFilePath = Join-Path $ProjectsDir "$projectName.txt"
    $projectPath | Set-Content -Path $pathFilePath
    Write-Host "Created path file for '$projectName'." -ForegroundColor Green
}

# Function to delete a path file
function Delete-PathFile($projectName) {
    $pathFilePath = Join-Path $ProjectsDir "$projectName.txt"
    if (Test-Path -Path $pathFilePath -PathType Leaf) {
        Remove-Item -Path $pathFilePath -Force
        Write-ColorText "Deleted path file for '$projectName'." "Green"
    } else {
        Write-ColorText "Path file for '$projectName' not found." "Red"
    }
}

# Check if the -help flag is used
if ($ProjectName -eq "--help") {
    # List all available projects
    $ProjectsList = Get-ChildItem -Path $ProjectsDir -Filter *.txt | ForEach-Object { $_.BaseName }
    
    Write-ColorText "Usage: cdscript [project name]" "DarkGray"
    Write-Host "Options:"
    Write-ColorText "  --help   Display this help message" "DarkGray"
    Write-ColorText "  --open   Open the 'projects' directory in File Explorer" "DarkGray"
    Write-ColorText "  --paths  Display available projects" "DarkGray"
    Write-ColorText "  --create      Create a new path file for a project" "DarkGray"
    Write-ColorText "  --delete      Delete a path file for a project" "DarkGray"

    exit 0
}

# All the checks for the flags

# Check if the -open flag is used
if ($ProjectName -eq "--open") {
    Invoke-Item $ProjectsDir  # Open the 'projects' directory in File Explorer
    exit 0
}

# Check if the -open flag is used
if ($ProjectName -eq "--paths") {
    $ProjectsList = Get-ChildItem -Path $ProjectsDir -Filter *.txt | ForEach-Object { $_.BaseName }

    Write-Host "Available projects:"

    $ProjectsList | ForEach-Object {
        Write-ColorText "  $_" "Yellow"
    }
    exit 0
}

# Check if the --create flag is used
if ($ProjectName -eq "--create") {
    if ($args.Count -lt 2) {
        Write-ColorText "Usage: navi --create <project_name> <project_path>" "Red"
        exit 1
    }

    $ProjectName = $args[0]
    $ProjectPath = $args[1]

    Create-PathFile $ProjectName $ProjectPath
    exit 0
}

# Check if the --delete flag is used
if ($ProjectName -eq "--delete") {
    if ([string]::IsNullOrEmpty($args[0])) {
        Write-ColorText "Usage: navi --delete <project_name>" "Red"
        exit 1
    }

    $ProjectName = $args[0]

    Delete-PathFile $ProjectName
    exit 0
}

# Check if a project name was provided as an argument
if ([string]::IsNullOrEmpty($ProjectName)) {
    Write-ColorText "No project name provided." "Red"
    exit 1
}

# Construct the project file path
$ProjectFilePath = Join-Path $ProjectsDir "$ProjectName.txt"

# Check if the project file exists
if (-not (Test-Path -Path $ProjectFilePath -PathType Leaf)) {
    Write-ColorText "Project '$ProjectName' does not exist." "Red"
    exit 1
}

# Load the project path and navigate to it
$ProjectPath = Get-Content -Path $ProjectFilePath
Set-Location -Path $ProjectPath

Write-ColorText "Navigated to '$ProjectName'." "Green"
