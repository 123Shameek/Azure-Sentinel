/*The following script bulk deletes all closed Sentinel incidents older than a certain date*/

$Days=<days>
$RG="<Resource Group Name>"
$WS="<Workspace Name>"
$incident = Get-AzSentinelIncident -resourceGroupName $RG -workspaceName <WSName> | Where-Object {$_.CreatedTimeUtc -lt (Get-Date).AddDays(-$Days)}
$incidentgreaterthan = ($incident | Where-Object {$_.Status -eq "Closed"}).Name   
foreach ($i in $incidentgreaterthan)
{
Remove-AzSentinelIncident -ResourceGroupName $RG -WorkspaceName <WSName> -Id $i
Write-Host "Incident deleted " -NoNewline
Write-Host $i
}
