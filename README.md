# 201-multi-vm-lbint-zones-scriptext
Create Multiple Azure VMs in different Availability Zones with internal Standard Load Balancer and custom script extension

INSTALL STEPS:
Below assumes using the Azure Cloud Shell (PowerShell), with AZ ACCOUNT SET pointing to the correct subscription. 

          Step1: Copy the template and parameter json files to your Azure Cloud Shell folder, as well as the deploy-vmazloop.ps1 file

          Step1: Edit the parameter file as needed with SubnetRefId, admin username & password, VM quantities, etc. 
                    ex:  PS /home/clouduser> code ./azuredeploy-vmazloop.parameters.json

          Step2: Download locally and review / edit the configure-server.ps1 file to execute desired PowerShell script as desired
                    note:  this will end up being the command to execute in the VM once started as an "extension"

          Step3: Create a new Resource Group in the location that matches the values in the parameters file

          Step4: Deploy using the provided / uploaded PS script file
                    ex:  PS /home/clouduser> ./deploy-vmazloop.ps1
                 or deploy using the Azure Portal by copy & paste of the raw values from the json file contents
                    using: New> Template deployment (deploy using custom templates)
          
This does not create a public IP, so you will need to either attach one on the NIC resource, or use a Bastion Host, or connect via RDP from another VM available on the target network. 

VMAZ-DNS Template:
          This template deploys a Windows DNS server role and add Conditional Forwarder entries from the CSV file
          

TROUBLESHOOTING:
- Important is having an effective route on the target subnet that can reach the FileUri specified to download the configure-server.ps1 script. For example, reaching the Azure Storage Account can be achieved various ways, such as using Service Endpoint, or ensuring there is no BGP and forced-tunneling of the default 0.0.0.0/0 route to on-premise by overriding it with a custom UDR, etc. 
- There is no support for a proxy in this example
