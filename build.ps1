param(
    [Parameter(Mandatory=$true)]
    [switch] $Publish,
    [Parameter(Mandatory=$true)]
    [string] $NuGetApiKey
)

[string] $name = 'AzStorageTable.TravisEz13'
$path = Join-Path -Path $PSScriptRoot -ChildPath 'src'

$tmpPath = Join-Path -Path ([System.io.path]::GetTempPath()) -ChildPath ([system.io.path]::GetRandomFileName())
$tmpPath = Join-Path -Path $tmpPath -ChildPath $name


if($Publish.IsPresent)
{
    $null = new-item -Path $tmpPath -ItemType Directory
    try{

    Copy-Item -Path "$path\*" -Destination $tmpPath -Recurse

    publish-module -Path $tmpPath -NuGetApiKey $NuGetApiKey
    }
    finally
    {
        remove-item -Path $tmpPath -Recurse -Force
    }
}