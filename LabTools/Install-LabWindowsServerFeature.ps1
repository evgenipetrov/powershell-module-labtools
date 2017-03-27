function Install-LabWindowsServerFeature
{
  param
  (
    [String]
    [Parameter(Mandatory)]
    $Name
  )
  
  $feature = Get-WindowsFeature -Name $Name
  if ($feature.InstallState -eq 'Available')
  {
    Install-WindowsFeature -Name $Name -IncludeManagementTools
  }
}