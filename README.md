# learn-gcp-terraform

### Terraform Intro
Terraform is a tool to automate the building of infrastructure (or, infrastructure-as-code IaC)
The goal is for this repository to guide through an intro up through more advanced Terraform concepts. 
To get started on Google Cloud Platform (GCP), you can leverage the CloudShell tool which has Terraform integration built in.
If you'd like to start locally, you can [install the Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)

Terraform leverages HCL syntax configuration files as templates to build repeatable infrasatructure in an automated way.  This reduces the potential for user error while enabling speed, agility, and standardization.

Some of the most common Terraform commands used:
* ```terraform init``` - Initializes the Terraform environment including providers, authentication, and the files/subfolders in the working directory
* ```terraform validate``` - Performs a check on the configuration files in the working directory to ensure they have correct consistency and syntax.
* ```terraform fmt``` - Adjusts the format and style of the configuration files for style, alignment, and readability.
* ```terraform plan``` - Creates an execution plan that allows you to review the infrastructure and resources you will create.
* ```terraform apply``` - This applies the plan generated from the above command, and will create resources as defined in the Terraform configuration files

## Stage 1.  Terraform to create Network and VM
### Set up the environment
* Log into the console at https://console.cloud.google.com
* Create a new project, or select the project you'd like to use
* Open a CloudShell session by clicking the ```>_``` icon in the upper right menu
* Clone the repo by running:
  * ```git clone https://github.com/vanberge/learn-gcp-terraform.git```
* Change into the directory:
  * ```cd learn-gcp-terraform/```
* Click "Open Editor" button to launch the Cloud code editor, and break it out into a new tab.
* On the original tab, select the ```Open terminal``` button so you now have a CloudShell terminal and a visual code editor on separate tabs.
* On the editor tab, open ```main.tf``` and edit line 10 to paste in your GCP project ID, replacing **<PROJECT_ID>**

### Initialize Terraform and create base infrastructure

* From the learn-gcp-terraform directory, run ```terraform init``` 
  * You should see **Terraform has been successfully initialized!**
* Next, let's check that ```main.tf``` is a valid configuration file.
  * Run ``terraform validate``
* Enter ```terraform plan``` and hit enter.  You may have to click to authorize CloudShell to execute
  * Review the output to take note of what the terraform automation will create 
* Enter ```terraform apply``` and hit enter
  * At the **Enter a value:** prompt, type ```yes``` and hit enter
  * You should see **google_compute_network.vpc_network: Creating...** followed by **google_compute_instance.vm_instance: Creating...**
  * This may take approximately 2 minutes
  * When done, you will see **Apply complete! Resources: 2 added, 0 changed, 0 destroyed.**
* From the left hand Cloud console menu, select *Compute Engine*, and then *VM Instances*
  * Note the VM **terraform-instance** has been created, attached to the  **terraform-network** VPC

### Updating Infrastructure with Terraform
* CD into the ```~/learn-gcp-terraform``` directory if you are not still in it
* Uncomment line 36, enabling the tags of **web** and **dev** to be applied to the VM
* Run ```terraform plan``` from cli, and note the addition of tags dev, web as they will be updated on the existing VM intance
* Run ```terraform apply``` to execute the latest version of the config
  * At the **Enter a value:** prompt, type ```yes``` and hit enter
  * Note the **Apply complete! Resources: 0 added, 1 changed, 0 destroyed.**
* Click onto the VM from the Console, scroll down to the **Network tags* section.  Note the dev, web tags are visible on the console
* You have updated the infrastructure using Terraform!

### Destroy the environment
* Now that you have a repeatable infrastructure.  You can destroy it.
* From within the ```~/learn-gcp-terraform``` folder, type and run ```terraform destroy```
* Note the command output indicating the environment network and VM will be destroyed
* At the **Enter a value:** prompt, type ```yes``` and hit enter
* The Network is destroyed first, followed by the VM instance. 
