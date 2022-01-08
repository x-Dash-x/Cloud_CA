Write-Host "creating .aws folder"
mkdir $HOME/.aws

Write-Host "copying config file to .aws folder"
cp config $HOME/.aws/config

Write-Host "done!"


