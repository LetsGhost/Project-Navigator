# RouteRacoon

![alt text](https://github.com/LetsGhost/RouteRacoon/blob/19d6ae3a28a767facde08668b548440eef263824/logo.png?raw=true)

## Overview
- [Description](#description)
- [How to use](#how-to-use)
  - [Setup](#setup)
  - [Usage](#usage)
- [License](#license)
- [Author](#author)

## Description
This is RouteRacoon your friendly companion that will help you to navigate truth your project folders easly.

## How to use
### Setup:
1. Clone this repository
```PowerShell
git clone https://github.com/LetsGhost/RouteRacoon.git
```
2. Open your PowerShell Profile
```PowerShell
notepad $PROFILE
```
3. Add the following line to your PowerShell Profile
```PowerShell
Set-Alias rr "C:\Path\To\Your\Projects\cdscript.ps1"
```

### Usage:
1. Open your PowerShell Terminal
2. Use the create command
```PowerShell
rr --create [project name] [folder path]
```
3. Type this to navigate to a an projetc folder.
```PowerShell
rr [project name]
```
Use also
```PowerShell
rr --help
```
to see more avalible flags.

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Author
[LetsGhost](https://img.shields.io/twitter/follow/0x1CA3.svg?style=social)