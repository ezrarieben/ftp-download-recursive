# ftp-download-recursive
A PowerShell script to recursively download files via FTP
## Configuring PowerShell script
 > **NOTE:** This script requires the PSFTP 1.7 Module: https://www.powershellgallery.com/packages/PSFTP/1.7
1. Edit `ftp-download-recursive.ps1`
2. Set the required options (Line 18-22)
> **NOTE:** Check the script head for an explanation of how to set the options/variables correctly
  ```ps1
$ftp = "ftp://ftp.example.com"
$user = 'username'
$pass = 'password'
$folder = ''
$destination = "C:/temp/"
  ```
3. Execute `ftp-download-recursive.vbs` to download files
---
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
