# File Navigator 

## Overview
- [Description](#description)
- [How to use](#how-to-use)
  - [Setup](#setup)
  - [Usage](#usage)
- [License](#license)
- [Author](#author)

## Description
This is a simple PowerShell Scripts that helps you navigate trought your projects in you Terminal.

## How to use
### Setup:
1. Clone this repository

```Shell
$configPath = "C:\Path\To\Your\Projects\config.json"
```
and in the config.json file add the path to your projects directory where the project files get stored.
```json
{
    "ProjectsDir": "C:\\Path\\To\\Projects\\Dir\\"
}
```
2. Open your PowerShell Profile
```PowerShell
notepad $PROFILE
```
3. Add the following line to your PowerShell Profile
```PowerShell
Set-Alias navi "C:\Path\To\Your\Projects\cdscript.ps1"
```

### Usage:
1. Open your PowerShell Terminal
2. Use the help command
```PowerShell
navi --help
```

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Author
[LetsGhost](https://img.shields.io/twitter/follow/0x1CA3.svg?style=social)