# learn-gcp-terraform

### Intro
Terraform is a tool to automate the building of infrastructure (or, infrastructure-as-code or "IaC")
The goal is for this repository to serve as a guide, helping learn the use of Terraaform on Google Cloud Platform (GCP) beginning with an intro and building up to more advanced concepts. 
To get started with Terraform on GCP, you can leverage the built in [CloudShell](https://cloud.google.com/shell) tool which has Terraform and git integration built in.
If you'd like to start locally, you can [install the Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli) and leverage the [Google Cloud SDK](https://cloud.google.com/sdk/docs/install).

Terraform leverages HCL syntax configuration files as templates to build repeatable infrasatructure in an automated way.  This reduces the potential for user error while enabling speed, agility, and standardization.

Some of the most common Terraform commands used:
* ``terraform init`` - Initializes the Terraform environment including providers, authentication, and the files/subfolders in the working directory
* ``terraform validate`` - Performs a check on the configuration files in the working directory to ensure they have correct consistency and syntax.
* ``terraform fmt`` - Adjusts the format and style of the configuration files for style, alignment, and readability.
* ``terraform plan`` - Creates an execution plan that allows you to review the infrastructure and resources you will create.
* ``terraform apply`` - This applies the plan generated from the above command, and will create resources as defined in the Terraform configuration files

## Stage 1.  Terraform to create Network and VM
### Set Up the Environment
* Log into the console at https://console.cloud.google.com
* Create a new project, or select the project you'd like to use
* Open a CloudShell session by clicking the ``>_`` icon in the upper right menu
* Clone the repo by running:
  ```
  git clone https://github.com/vanberge/learn-gcp-terraform.git
  ```
* Change into the directory:
  ```
  cd learn-gcp-terraform/
  ```
* Click "Open Editor" button to launch the Cloud code editor, and break it out into a new tab.
* On the original tab, select the ``Open terminal`` button so you now have a CloudShell terminal and a visual code editor on separate tabs.
* On the editor tab, open ``main.tf`` and edit line 10 to paste in your GCP project ID, replacing **<PROJECT_ID>**

### Initialize Terraform and Create Base Infrastructure
* From the ``learn-gcp-terraform directory``, initialize the Terraform environment
  ```
  terraform init
  ``` 
  * You should see **Terraform has been successfully initialized!**
* Next, let's check that ``main.tf`` is a valid configuration file. 
  ```
  terraform validate
  ```
  * You should see the message **Error: Unsupported attribute**. The error text points you to line 30, underlining an issue.
  * View the ``main.tf`` file in your code editor tab, review line 30.  Fix the typo.
  * Re-run the ``terraform validate`` command from above.  You should now see **Success! The configuration is valid.**

* With the configuration valid, let's check the formatting.
  * Execute the following command, which will check the formatting of **main.tf** and show you potential changes.
    ```
    terraform fmt -check -diff
    ```
  * Note the alignment of the ``=`` is what will be adjusted.
  * Apply the formatting changes to main.tf by running 
    ```
    terraform fmt main.tf
    ```
  * Look at ``main.tf`` in the cloud editor now, and notice the alignment changes made to teh ``=`` signs.

With our configuration seemingly in order, let's create and apply a plan:
* Run the following command and hit enter.  You may have to click to authorize CloudShell to execute
  ```
  terraform plan
  ```
* Review the output to take note of what the terraform automation will create. It should look like this: 
  ```
  # google_compute_instance.vm_instance will be created
  + resource "google_compute_instance" "vm_instance" {
      + can_ip_forward       = false
      + cpu_platform         = (known after apply)
      + current_status       = (known after apply)
      + deletion_protection  = false
      + guest_accelerator    = (known after apply)
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + label_fingerprint    = (known after apply)
      + machine_type         = "f1-micro"
      + metadata_fingerprint = (known after apply)
      + min_cpu_platform     = (known after apply)
      + name                 = "terraform-instance"
      + project              = (known after apply)
      + self_link            = (known after apply)
      + tags_fingerprint     = (known after apply)
      + zone                 = (known after apply)
  ```
* The plan looks good to create a VM instance and VPC network.  So, now run the command 
  ```
  terraform apply
  ```
  * At the ``Enter a value:`` prompt, type ``yes`` and hit enter.  
  * After 1-2 minutes, your infrastructure should be created.  Leaving the following output:
    ```
    google_compute_network.vpc_network: Creating...
    google_compute_network.vpc_network: Still creating... [10s elapsed]
    google_compute_network.vpc_network: Still creating... [20s elapsed]
    google_compute_network.vpc_network: Still creating... [30s elapsed]
    google_compute_network.vpc_network: Creation complete after 32s 
    google_compute_instance.vm_instance: Creating...
    google_compute_instance.vm_instance: Still creating... [10s elapsed]
    google_compute_instance.vm_instance: Creation complete after 13s
    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
    ```
* Now that the infrastructure plan has been applied, let's view it in the GCP console:
  * From the left hand Cloud console hamburger menu, select ``Compute Engine``, and then ``VM Instances``
  * Note the VM ``terraform-instance`` has been created. Click the VM and review the settings.  
  * The VM is attached to the ``terraform-network`` VPC network which was also created by the infrastructure plan.

### Updating Existing Infrastructure with Terraform
* Now we'll update existing infrastrucutre with a modified plan.
* Navigate to the code editor tab to make a change to ``main.tf``
* Uncomment line 36 ``tags        = ["web", "dev"]``, enabling the tags of **web** and **dev** to be applied to the VM.
* In your CloudShell, cd into the working directory by running ``cd ~/learn-gcp-terraform`` if you are not still in it.
* Run the following command to recreate the Terraform plan
  ```
  terraform plan 
  ``` 
* Note the addition of tags dev, web as they will be updated on the existing VM intance as shown below:
  ```
  Terraform will perform the following actions:

    # google_compute_instance.vm_instance will be updated in-place
    ~ resource "google_compute_instance" "vm_instance" {
          id                   = "projects/../../terraform-instance"
          name                 = "terraform-instance"
        ~ tags                 = [
            + "dev",
            + "web",
          ]
  ```
* Run the following command to execute the latest version of the config
  ```
  terraform apply -auto-approve
  ```
  * Note, with the additional command argument, you did not have the the ``Enter a value:``
  * Note the ``Apply complete! Resources: 0 added, 1 changed, 0 destroyed.``
* Click onto the VM from the Console, scroll down to the **Network tags** section.  Note the dev, web tags are visible on the console
* You have updated the infrastructure using Terraform!

### Replacing Existing Infrastructure with Terraform
In the previous section, the changes to the infrastructure were able to edit the existing VM instance. However, some changes will require replacing the infrastructure.
We'll explore one of those changes now.
* Now we'll update existing infrastrucutre with a modified p
* Navigate to the ``main.tf`` file in your code editor tab.
* find the **image = "debian-cloud/debian-9"** at line 26.  Edit this line to read ``image = "ubuntu-os-cloud/ubuntu-minimal-2004-lts"``
This will change the base OS image our VM is based from Debian to Ubuntu.  Although similar operating systems, this change is destructive.
* Re-run the command ``terraform plan`` from your CloudShell terminal.
* Review the command output by scrolling up.  Note the plan output verbiage and warnings:
  ```
  Terraform will perform the following actions:

    # google_compute_instance.vm_instance must be replaced
  ```
* Run ``terraform apply`` and then enter ``yes`` when prompted.  
* The terraform plan will apply, destroying and recreating the ``terraform-instance`` virtual machine.
* Once completed, change the main.tf line 26 back to read ``image = "debian-cloud/debian-9"``

Let's save this finaly stage-1 plan to a stateful file.
* Run the following command from your CloudShell terminal to save the Terraform plan
  ```
  terraform plan -out=mytfplan
  ```
* The terraform plan command runs as normal. However, if you execute ``ls`` command, you will now see a **mytflplan** file in your working directory
* To apply this plan, execute ``terraform apply "mytfplan"`` from the CloudShell terminal.
* You have now deployed your terraform plan from both a working directory, as well as a stateful file.

### Destroy the Environment
* Now that you have created a repeatable infrastructure, you can destroy it.
* From within the ``~/learn-gcp-terraform`` folder, type run the destroy command from your CloudShell terminal
  ```
  terraform destroy
  ```
* Note the command output indicating the environment network and VM will be destroyed.
* At the **Enter a value:** prompt, type ``yes`` and hit enter
* The compute VM is destroyed first, followed by network. 

**Congratulations!**  
To learn more, continue on to the [stage-2 branch](https://github.com/vanberge/learn-gcp-terraform/tree/stage-2) to start leveraging modules, varibles, and more complex configurations!

**Credits**
* Based on the HashiCorp Learn Intro, [Build Infrastructure - Terraform GCP Example](https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-build)
* Inspired by [Infrastructure as Code with Terraform](https://www.cloudskillsboost.google/quests/159), a Google Cloud skills boost quest.