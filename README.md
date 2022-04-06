# learn-gcp-terraform

## Stage 2.  Working with modules, variables, and outputs
### Set up the environment
* Log into the console at https://console.cloud.google.com
* Creat a project, or select the project you'd like to use
* Open a CloudShell session
* If you already completed stage 1, delete that branch locally.
  * ```rm -rf ~/learn-gcp-terraform```
* Clone the stage 2 branch of the repo:
  * ```git clone --branch stage-2 https://github.com/vanberge/learn-gcp-terraform.git```
* Change into the directory:
  * ```cd learn-gcp-terraform/```
* Click "Open Editor" button to launch the Cloud code editor
* The file structure is as follows:
```
learn-gcp-terraform
   |---modules
      - maint.tf
      - outputs.tf
      - variables.tf
      |---instances
             - instances.tf
             - outputs.tf
             - variables.tf
      |---network
             - networks.tf
             - outputs.tf
             - variables.tf
      |---storage
             - outputs.tf
             - storage.tf
             - variables.tf
```
* Note several key difference in the layout from stage-1 introduction, where all settings were located in ```main.tf```
  * The VM instance and Network have each been modularized.  Note that each has its own directory, primary **.tf** file, as well as outputs and variables files.
  * The main.tf file in the root directory references each module
  * The instance module will have to reference the network module in order to attach the VM to the network.
     * To accomplish this, the ```vpc_network``` variable is defined in main.tf, line 21.
     * Additionally, the ```instances/variables.tf``` defines the variable within the module at line 14.
     * Finally, the ```instances/instances.tf``` file sets the value to the network module's vpc, at line 11 with ```network = var.vpc_network```
* Edit each variables.tf file, putting your GCP project id in line 2, replacing ```<project id>```
* Run ```terraform init``` from the CloudShell terminal

             

