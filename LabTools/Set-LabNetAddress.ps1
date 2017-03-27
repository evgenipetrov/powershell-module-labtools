function Set-LabNetAddress
{
  #Content
  param
  (
    [String]
    [Parameter(Mandatory)]
    $IPv4Address,
    
    [String]
    [Parameter(Mandatory)]
    $PrefixLength,
    
    [String]
    [Parameter(Mandatory)]
    $DNS
  )
  
  $netIpConfiguration = Get-NetIPConfiguration
  if(($netIpConfiguration | Where-Object {$_.IPv4Address -eq $IPv4Address}) -eq $null){
    $alias = ($netIpConfiguration | Where-Object {$_.IPv4DefaultGateway -eq $null} | Select-Object -First 1).InterfaceAlias
    Remove-NetIPAddress -InterfaceAlias $alias -AddressFamily IPv4 -Confirm:$false
    New-NetIPAddress -InterfaceAlias $alias -AddressFamily IPv4 -IPAddress $IPv4Address -PrefixLength $PrefixLength 
    Set-DnsClientServerAddress -InterfaceAlias $alias -ServerAddresses $DNS
  }
}