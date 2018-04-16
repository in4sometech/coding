#To Vlaidate whether the QFLE# drivers are active are not after rebooting the host when applied with activateqfle3 script



$ESXihost = Read-host "`nPlease type Esxi Host FQDN"

try {
$esxcli=Get-Esxcli -vmhost $Esxihost
$vibs = $esxcli.software.vib.list() | Where {$VibNames -contains "qfle" }

$systemmodule=$esxcli.system.module.list() | where { $_.name -eq "qfle3"} 

if($systemmodule.Isenabled -match "true")

  {
   Write-host "`n The Qfle3 drivers are currently active`n" -ForegroundColor Green

  }

  else {
      
    write-host "`n Qfle3 Drivers not active, Please run the activateqle3 script again or check the host `n " -ForegroundColor Red
    
  }
}
catch 

{ 
    Write-host "Error happened when running script, please check the parameters entered."

}
