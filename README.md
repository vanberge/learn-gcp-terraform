# learn-gcp-terraform

## Stage 1.  Terraform to create Network and VM
Set up the environment
* Log into the console at https://console.cloud.google.com
* Creat a project, or select the project you'd like to use
* Open a CloudShell session
* Clone the repo:
  * git clone https://github.com/vanberge/learn-gcp-terraform.git
* Change into the directory:
  * cd learn-gcp-terraform/
* Optionally, click "Open Editor" button to launch the Cloud code editor
* Edit line 10 to paste in your project ID, replacing <PROJECT_ID>

Initialize Terraform and create base infrastructure
* From the learn-gcp-terraform directory, run *terraform init*, you should see **Terraform has been successfully initialized!**
* Enter *terraform plan* and hit enter.  You may have to click to authorize CloudShell to execute
  * Review the output to take note of what the terraform automation will create 
* Enter *terraform apply* and hit enter
  * At the **Enter a value:** prompt, type *yes* and hit enter
  * You should see *google_compute_network.vpc_network: Creating...* followed by *google_compute_network.vpc_network: Creating...*
  * This may take approximately 2 minutes
  * When done, you will see **Apply complete! Resources: 2 added, 0 changed, 0 destroyed.**
* From the left hand Cloud console menu, select *Compute Engine*, and then *VM Instances*
  * Note the VM **terraform-instance** has been created, attached to the  **terraform-network** VPC

Updating Infrastructure with Terraform
* CD into the ~/learn-gcp-terraform directory if you are not still in it
* Uncomment line 36, enabling the tags of **web** and **dev** to be applied to the VM
* Run *terraform plan* from cli, and note the addition of tags dev, web as they will be updated on the existing VM intance
* Run *terraform apply* to execute the latest version of the config
  * At the **Enter a value:** prompt, type *yes* and hit enter
  * Note the **Apply complete! Resources: 0 added, 1 changed, 0 destroyed.**
* Click onto the VM from the Console, scroll down to the **Network tags* section.  Note the dev, web tags are visible on the console
* You have updated the infrastructure using Terraform!

Destroy the environment
* Now that you have a repeatable infrastructure.  You can destroy it.
* From within the *~/learn-gcp-terraform* folder, type and run *terraform destroy*
* Note the command output indicating the environment network and VM will be destroyed
* At the **Enter a value:** prompt, type *yes* and hit enter
* The Network is destroyed first, followed by the VM instance. 
