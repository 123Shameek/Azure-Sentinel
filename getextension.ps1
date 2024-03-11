/*PowerShell script to list our a specific extension on all the VMs in a subsription*/
$VM=(Get-AzVM).Name 
$RG = (Get-AzResourceGroup).ResourceGroupName 
foreach($r in $RG) 
{
	foreach ($i in $VM) 
		{
			Get-AzVMExtension -ResourceGroupName $r -VMName $i -ExtensionName "<ExtensionName>" -ErrorAction SilentlyContinue | select VMName,Name
		}
}
