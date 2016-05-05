#!powershell

# WANT_JSON
# POWERSHELL_COMMON

#Get the args
$params = Parse-Args $args $true;

$rgName = Get-Attr $params "ResourceGroup" -failifempty $true
$name = Get-Attr $params "Name" -failifempty $true
$newTags = Get-Attr $params "Tags" -failifempty $true
$action = Get-Attr $params "Action" "Add"


$result = New-Object psobject @{
    changed = $false
};

#Check if all the pre-reqs are in place, e.g. required paramaters
If ("Script should not run?")
{
    Exit-Json $result;
}

#If pre-reqs are valid then run the powershell code
#Get resource
try {
    $resource = Get-AzureRmResource -ResourceGroupName $rgname -ResourceName $name
    $tags = $resource.tags
}
catch {
    Fail-Json $result $_.Exception.Message
}
#What will be done to the tags

switch ($action) {
    "Read" { 
        #Do nothing       
        }
    "Delete" { 
        #Delete each new tag
        foreach ($newTag in $newTags) {
                $tags.Remove($newTag)
            }        
    }
    Default {
        #Add and Update are the same thing
        foreach ($newTag in $newTags) {
                $tags += $newTag
            }
    }
}

# Tell ansible that the script has run
Set-Attr $result "changed" $true;

#Add the current list of tags to the output
$tags = $resource.tags | Out-String
Set-Attr $result "tags" $tags

#Exit the script and write the output back to Ansible
Exit-Json $result;