/*PowerShell script to Delete a specific extension on all the VMs in a subsription*/
$VM=(Get-AzVM).Name 
$RG = (Get-AzResourceGroup).ResourceGroupName 
$Extension = <ExtensionName>
foreach($r in $RG) 
{
	foreach ($i in $VM) 
		{
			Get-AzVMExtension -ResourceGroupName $r -VMName $i -ExtensionName $Extension -ErrorAction SilentlyContinue | Remove-AzVMExtension -Force 
   			Write-Host "$Extension deleted from $i"
		}
}
