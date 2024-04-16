function Create-ProjectsDir {
    if (-not (Test-Path $ProjectsDir)) {
        New-Item -ItemType Directory -Path $ProjectsDir | Out-Null
        Write-Host "Racoon crafted the projects folder at '$ProjectsDir'." -ForegroundColor Green
    } else {
        Write-Host "The projects folder already exists at '$ProjectsDir'." -ForegroundColor Yellow
    }
}