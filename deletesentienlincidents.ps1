//The following script bulk deletes all closed Sentinel incidents older than a certain date

$incident = Get-AzSentinelIncident -resourceGroupName <RGName> -workspaceName <WSName> | Where-Object {$_.CreatedTimeUtc -lt (Get-Date).AddDays(-30)}
$incidentgreaterthan90 = ($incident | Where-Object {$_.Status -eq "Closed"}).Name   
foreach ($i in $incidentgreaterthan90)
{
Remove-AzSentinelIncident -ResourceGroupName <RGName> -WorkspaceName <WSName> -Id $i
Write-Host "Incident deleted " -NoNewline
Write-Host $i
}
