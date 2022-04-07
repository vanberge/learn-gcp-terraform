# learn-gcp-terraform

### Intro
In this stage, we'll build on the foundational [stage-1](https://github.com/vanberge/learn-gcp-terraform/tree/stage-1) knowlege, which covers an introduction to Terraform on Google Cloud Platform (GCP).  The stage 2 focus will be breaking the Terraform configuration into separate modules (where stage-1 had everything in a single main.tf), as well as the use of variables and outputs.  We'll also create additional infrastructure services, including a Google Kubernetes Engine (GKE) cluster, and Google Cloud Storage bucket.

The file structure is as follows:
```
|---learn-gcp-terraform  #Main working directory, root module
    - main.tf
    - outputs.tf
    - variables.tf
    |---modules  #Module subfolders
        |---gke  
            - gke.tf
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

## Stage 2.  Working with Terraform modules, variables, and outputs

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
* Edit each variables.tf file, putting your GCP project id in line 2, replacing ``<project id>``
* Validate the configuration:
  ```
  terraform validate
  ```

* Initialize the Terraform working environment by running:
  ```
  terraform init
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