function Add-LabActiveDirectory
{
  param
  (
    [String]
    [Parameter(Mandatory)]
    $DomainName,
    
        [String]
    [Parameter(Mandatory)]
    $DomainNetbiosName,
    
        [String]
    [Parameter(Mandatory)]
    $SafeModeAdministratorPassword
  )
  
  $secureString = ConvertTo-SecureString -String $SafeModeAdministratorPassword -AsPlainText -Force

  Import-Module ADDSDeployment
  Install-ADDSForest `
  -CreateDnsDelegation:$false `
  -DatabasePath "C:\Windows\NTDS" `
  -DomainMode "Win2012" `
  -DomainName $DomainName `
  -DomainNetbiosName $DomainNetbiosName `
  -ForestMode "Win2012" `
  -InstallDns:$true `
  -LogPath "C:\Windows\NTDS" `
  -NoRebootOnCompletion:$true `
  -SysvolPath "C:\Windows\SYSVOL" `
  -Force:$true `
  -SafeModeAdministratorPassword:$secureString

  Restart-Computer -Force
}