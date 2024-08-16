/*PowerShell script to bulk exempt resources in MDFC*/
Set-AzContext -Subscription <SubscriptionId>
$Assignment = Get-AzPolicyAssignment -Name '<PolicyAssignmentName>' /* Run Get-AzPolicyAssignment to list out all the names */
/* The resource ID of all the resources are derived */
$ResourceIds = Search-AzGraph -Query @"
securityresources
| where type == "microsoft.security/assessments"
| extend source = trim(' ', tolower(tostring(properties.resourceDetails.Source)))
| extend resourceId = trim(' ', tolower(tostring(case(source =~ "azure", properties.resourceDetails.Id,extract('^(.+)/providers/Microsoft.Security/assessments/.+$',1,id)))))
| extend status = trim(" ", tostring(properties.status.code))
| extend cause = trim(" ", tostring(properties.status.cause))
| extend assessmentKey = tostring(name)
| where assessmentKey == "<assessmentkey?"
| where subscriptionId == "<SubscriptionKey>"
| where status == "Unhealthy"
|project resourceId
"@ 
/* Create exemption */
foreach ($ResourceId in $ResourceIds) {New-AzPolicyExemption -Name 'VulnerabilitySolutionExempt' -PolicyAssignment $Assignment -PolicyDefinitionReferenceId serverVulnerabilityAssessment -Scope
$ResourceId 
-ExemptionCategory Waiver | Out-Null
Write-Host $ResourceId -NoNewline
Write-Host " is exempted"
}
