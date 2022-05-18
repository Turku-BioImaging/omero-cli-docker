Write-Output "-----------------------------"
Write-Output "#### OMERO Upload Script ####"
Write-Output "-----------------------------"

$server = Read-Host -Prompt "Server address[omero.utu.fi]"
$port = Read-Host -Prompt "Port[4064]"
$username = Read-Host -Prompt "Username"
$password = Read-Host -Prompt "Password" -AsSecureString

if ([string]::IsNullOrWhiteSpace($server)) {
    $server = "omero.utu.fi"
}

if ([string]::IsNullOrWhiteSpace($port)) {
    $port = "4064"
}

docker pull ghcr.io/turku-bioimaging/omero-cli-docker:0.1.0
docker run --mount "type=bind,source=$(Get-Location)/to_upload,target=/upload" -it ghcr.io/turku-bioimaging/omero-cli-docker:0.1.0 /bin/bash -c "omero login $username@${server}:${port} -w ${password}; omero import /upload"

# docker run -it  omero-cli-docker omero group list