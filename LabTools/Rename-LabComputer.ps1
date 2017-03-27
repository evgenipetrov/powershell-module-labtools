function Rename-LabComputer
{
  param
  (
    [String]
    [Parameter(Mandatory,HelpMessage = 'Specify new computer name.')]
    $NewName
  )
  
  if ($env:COMPUTERNAME -notlike $NewName)
  {
    Rename-Computer -NewName $NewName
    Restart-Computer -Force
  }
}