# Writes the given string with a prefered color
function Write-ColorText($text, $color) {
    Write-Host $text -ForegroundColor $color
}