#!powershell

# WANT_JSON
# POWERSHELL_COMMON

#Get the args
$params = Parse-Args $args $true;

$arg1 = Get-Attr $params "arg1" -failifempty $true
$arg2 = Get-Attr $params "arg2" "default"
$arg3 = Get-Attr $params "arg3" $false | ConvertTo-Bool


$result = New-Object psobject @{
    changed = $false
};

#Check if all the pre-reqs are in place, e.g. required paramaters
If ("Script should not run?")
{
    Exit-Json $result;
}

#If pre-reqs are valid then run the powershell code

# Tell ansible that the script has run
Set-Attr $result "changed" $true;

# Get the output into a variable, e.g. from a logfile
$logcontents = Get-Content $logfile | Out-String;
#Add the output variable to the script output 
Set-Attr $result "log" $logcontents;

#Exit the script and write the output back to Ansible
Exit-Json $result;