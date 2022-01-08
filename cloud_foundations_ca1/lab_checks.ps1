# Checks for cloud setup lab

# commands expected
$commands = @( "git", "aws" )
foreach ( $command in $commands ) {
    Write-Host "checking for $command command... " -NoNewline
    if ( Get-command $command ) {
        Write-Host "OK"
    }
    else {
        Write-Host "not found" -ForegroundColor Red
        Write-Host "  -- install and re-run to continue checks"
    }

}

# files expected
$paths = @( "$HOME\.aws", "$HOME\.aws\config", "$HOME\.aws\credentials" )

# check for expected files
foreach ( $path in $paths ) {

if ( Test-Path $path ) {
    Write-Host "$path exists"
}
else {
    Write-Host "$path does not exist" -ForegroundColor Red
    Write-Host " ... fix this error and re-run"
    Return
    }

}

# ensure that the aws CLI is operational
$output = (aws ec2 describe-host-reservations)
Write-Host "output from aws:"
Write-Host $output 
if ( "HostReservationSet" -in ($output | ConvertFrom-Json).PSObject.Properties.Name ) {
    Write-Host "aws CLI works OK"
    }
    else
    {
    Write-Host "aws CLI not working, fix and re-run" -ForegroundColor Red
    Return
    }

# confirmation screen
Write-Host "You have completed AWS setup lab" -ForegroundColor Green

