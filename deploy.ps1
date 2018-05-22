param(
	
  [string]$Spath,
  [string]$Dpath

)

$Command = "\src\WinService.Base\bin\Debug\WinService.Base.exe"

$Runservice = "$Spath" + "$Command"


$pw = convertto-securestring -AsPlainText -Force -String "Certific@te0217"

$credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist "kernel\sa.sharov",$pw

$s = New-PSSession -ComputerName sharov -Credential $credentials

Invoke-Command -Session $s -Command {Stop-Service -Name "spooler"}

Invoke-Command -Session $s -Command {Remove-Item $Using:Dpath -Recurse}

Copy-Item -ToSession $s -Path $spath -Destination $dpath -Recurse

& $Runservice 

