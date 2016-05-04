#!powershell

# WANT_JSON
# POWERSHELL_COMMON

#Get the args
$params = Parse-Args $args $true;

$newFileSystemLabel = Get-Attr $params "NewFileSystemLabel" "Data"

$result = New-Object psobject @{
    changed = $false
};

#Check if there are any RAW disks
$disks = Get-Disk | Where-Object PartitionStyle -eq "RAW"
If ($disks.count -eq 0)
{
    #No RAW disks, exit without changing anything
    Exit-Json $result;
}


foreach($disk in $disks){
    #Initialise the disk
    Try {
        Initialize-disk $disk.Number
    }
    Catch{
        Fail-Json $result $_.Exception.Message
    }
    #Create a new partition on the disk and format it
    Try {
        New-Partition -DiskNumber $disk.Number -UseMaximumSize -AssignDriveLetter | Format-Volume -NewFileSystemLabel $newFileSystemLabel -FileSystem NTFS
    }
    Catch{
        Fail-Json $result $_.Exception.Message
    }   

}

# Tell ansible that the script has run and made a change
Set-Attr $result "changed" $true;

$disks = Get-Disk | Out-String
Set-Attr $result "Disks" $disks;

#Exit the script and write the output back to Ansible
Exit-Json $result;
