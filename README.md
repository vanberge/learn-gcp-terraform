# learn-gcp-terraform

### Intro
In this stage, we'll continue building from our modularized [stage-2](https://github.com/vanberge/learn-gcp-terraform/tree/stage-1) Terraform build, but focus on automating infrastructure build and updates with Github Actions.

## Stage 3.  Working with Github Actions, Terraform Cloud, and automating builds.
* Create a Terraform Cloud free account by visiting: https://cloud.hashicorp.com/products/terraform

### Set up the environment
* Log into the console at https://console.cloud.google.com
* Creat a project, or select the project you'd like to use
* Open a CloudShell session
* If you already completed stage 1, delete that branch locally.
  ```
  rm -rf ~/learn-gcp-terraform
  ```
* Clone the stage 2 branch of the repo:
  ```
  git clone --branch stage-2 https://github.com/vanberge/learn-gcp-terraform.git
  ```
* Change into the directory:
  ```
  cd learn-gcp-terraform/
  ```
* Click "Open Editor" button to launch the Cloud code editor

* Note several key difference in the layout from stage-1 introduction, where all settings were located in ```main.tf```
  * The VM instance and Network have each been modularized.  Note that each has its own directory, primary **.tf** file, as well as outputs and variables files.
  * The main.tf file in the root directory references each module
  * The instance module will have to reference the network module in order to attach the VM to the network.
     * To accomplish this, the ``vpc_network`` variable is defined in main.tf, line 21.
     * Additionally, the ``instances/variables.tf`` defines the variable within the module at line 14.
     * Finally, the ``instances/instances.tf`` file sets the value to the network module's vpc, at line 11 with ``network = var.vpc_network``

### Deploy the cloud infrastructure
* Edit the variables.tf in the root folder, putting your GCP project id in line 2, replacing ``<project id>``
* Initialize the Terraform working environment by running:
  ```
  terraform init
  ```

* Validate the configuration:
  ```
  terraform validate
  ```

* Create the Terraform plan by running:
  ```
  terraform plan
  ```

* Execute the Terraform plan:
  ```
  terraform apply
  ```
   * At the ``Enter a value:`` prompt, type ``yes`` and hit enter
   * Note that similarly to stage-1, the VPC network is created first followed by the Compute instance.  
   * This time, however, the layout and files allow for greater scale and specific configurations for additonal networks or Compute instance VMs
* After 1-2 minutes, you will see ```Apply complete! Resources: 2 added, 0 changed, 0 destroyed.```
