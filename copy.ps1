Write-Output "-----------------------------"
Write-Output "#### OMERO Upload Script ####"
Write-Output "-----------------------------"

$server = Read-Host -Prompt "Server address[omero.cci.sahlgrenska.gu.lcl]"
$port = Read-Host -Prompt "Port[4064]"
$username = Read-Host -Prompt "Username"
$password = Read-Host -Prompt "Password" -AsSecureString
$clearTextPassword = ConvertFrom-SecureString -SecureString $password -AsPlainText

if ([string]::IsNullOrWhiteSpace($server)) {
    $server = "omero.cci.sahlgrenska.gu.lcl"
}

if ([string]::IsNullOrWhiteSpace($port)) {
    $port = "4064"
}

Function Get-Folder($initialDirectory = "") {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select a folder to upload..."
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if ($foldername.ShowDialog() -eq "OK") {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

$uploadPath = Get-Folder

docker pull ghcr.io/turku-bioimaging/omero-cli-docker:0.1.0
docker run --mount "type=bind,source=${uploadPath},target=/upload" -it ghcr.io/turku-bioimaging/omero-cli-docker:0.1.0 /bin/bash -c "omero login $username@${server}:${port} -w ${clearTextPassword}; omero import /upload"