# 1) ENSURE THE TARGET RESOURCE GROUP TO DEPLOY INTO EXISTS
# 2) REVIEW THE DEPLOYMENT NAME - CHANGE IF NEW DEPLOYMENT vs DELTA
param(
 [Parameter(Mandatory=$True)]
 [string]
 $resourceGroupName
)

$deploymentName = "vmazdns101"
$templateFilePath = "./azuredeploy-vmaz-dns.json"
$parametersFilePath = "./azuredeploy-vmaz-dns.parameters.json"
# $resourceGroupName = "VMAZLOOP-RG"
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name $deploymentName -TemplateFile $templateFilePath -TemplateParameterFile $parametersFilePath;
