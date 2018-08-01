# lock_and_disconnect.ps1 - Toggles physical network adapters on/off when unlocking/locking Windows
# Run in background upon boot as a privileged user as changing NIC states requires administrative privileges
# Tom Van de Wiele 2018 (@0xtosh)

while($true) {
	$status = (Get-Process logonui -ComputerName $env:computername -ErrorAction SilentlyContinue) -and (whoami)
	if ($status -eq "Locked") {
		if (Get-NetAdapter -Physical | Format-Table -HideTableHeaders -Property "Status" | Out-String | Select-String -Pattern "Up") {
			Disable-NetAdapter -Name "WiFi" -Confirm:$False   # set the name to "*" for all adapters for all Disable-NetAdapter references
			Disable-NetAdapter -Name "Ethernet" -Confirm:$False
		}	
	}
	else {
		if (-Not (Get-NetAdapter -Physical |Format-Table -HideTableHeaders -Property "Status" | Out-String | Select-String -Pattern "Up")) {
			Enable-NetAdapter -Name "WiFi" -Confirm:$False
			Enable-NetAdapter -Name "Ethernet" -Confirm:$False
		}
	}
	Start-Sleep 2
}