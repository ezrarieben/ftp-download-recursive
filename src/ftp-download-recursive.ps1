# REQUIRES PSFTP 1.7 Module: https://www.powershellgallery.com/packages/PSFTP/1.7

#####
#
# This script downloads all files recursively from a FTP server
#
# @author Ezra Rieben
#
# @var $ftp --> FTP Server URL (e.g.: ftp://ftp.example.com) (NO TRAILING SLASH!)
# @var $user --> FTP User
# @var $pass --> FTP User Password
# @var $folder --> FTP folder to download from (e.g.: /uploads) (Leave empty for root) (NO TRAILING SLASH!)
# @var $destination --> Local folder to download FTP folder contents to (e.g.: C:/temp/) (TRAILING SLASH REQUIRED!)
#
#####

# Define Variables
$ftp = "ftp://ftp.example.com"
$user = 'username'
$pass = 'password'
$folder = ''
$destination = "C:/temp/"

# Import PSFTP Module
Import-Module -Name PSFTP -RequiredVersion 1.7

# Set credentials (PSCredentials) used to connect to FTP server
$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($user, $secpasswd)

# Set the default FTP connection for PSFTP to use
$connection = Set-FTPConnection -Credentials $credentials -Server $ftp -EnableSsl -ignoreCert -UsePassive

# Get all FTP files (recursively)
$files = Get-FTPChildItem -path $folder -Recurse -Filter "*.*"

# Create directories that don't exist yet
foreach ($file in $files){
	$subFolder = $file.Parent -replace $ftp
	$newFolder = $destination + $subFolder
	
	if(!(Test-Path -Path $newFolder)){
		$newDir = New-Item -ItemType Directory -Force -Path $newFolder
		Write-Host "Created directory: $($newFolder)"
	}
}

# Download all files and save them in the given $target directory
$webclient = New-Object System.Net.WebClient 
$webclient.Credentials = New-Object System.Net.NetworkCredential($user, $pass) 
$counter = 0
foreach ($file in $files){
	$source = $file.FullName
	$newFile = $destination + $file.FullName -replace $ftp
	$webclient.DownloadFile($source, $newFile)

	# Log download count and downloaded file
	$counter++
	Write-Host "Downloaded file: $($source) to $($newFile)"
	Write-Host "$($counter)/$($files.Count) downloaded"
}

