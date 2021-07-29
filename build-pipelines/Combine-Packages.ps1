Param(
    [Parameter(Mandatory=$true)]
    [string] $OutputDirectory,

    [Parameter(Mandatory=$false)]
    [string] $InputDirectory,

    [Parameter(Mandatory=$false)]
    [string] $Version
)

$ErrorActionPreference = "Stop"

$ExcludeFiles = New-Object -TypeName System.Collections.Generic.List[string]
$ExcludeFiles.Add("GECU.Environment.$Version.nupkg")
$ExcludeFiles.Add("GECU.Foundation.PublishingService.$Version.nupkg")

#Unpack all archives into the temp folder
Write-Host "Extracting the NuGet packages..."
Get-ChildItem $InputDirectory -Filter "*.nupkg" | Where-Object {!$ExcludeFiles.Contains($_.Name)} | Rename-Item -NewName { "$($_.Name -replace '.nupkg', '.zip')" } -PassThru | Expand-Archive -DestinationPath "$OutputDirectory" -Force

#Delete all nuspec files
Write-Host "Deleting the existing nuspec files."
Get-ChildItem $OutputDirectory -Filter "*.nuspec" | Remove-Item -Force

Write-Host "Deleting web.config file (if it exists)"
Get-ChildItem $OutputDirectory -Filter "web.config" | Remove-Item -Force

Write-Host "Done!"