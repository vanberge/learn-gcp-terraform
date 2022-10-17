# learn-gcp-terraform

### Intro
In this stage, we'll continue building from our modularized [stage-2](https://github.com/vanberge/learn-gcp-terraform/tree/stage-1) Terraform build, but focus on automating infrastructure build and updates with Github Actions.

## Stage 3.  Working with Github Actions, Terraform Cloud, and automating builds.

### Environment Setup
* Visit https://console.cloud.google.com
   * Create a Google Cloud project you wish to automate infrastructure into
   * Since we're going to be using automation, now we must create a service account.  Select IAM from the left hand menu
   * Create a service account
   * Create a key for this service account in JSON format; which will download to your local machine.
   * Remove newline characters from the JSON file by running ```sed -z 's/\n/,/g' <keyfilename>.json```

* Next, configure and set up Terraform Cloud
   * If you haven't already (and, you're not using GCP's Cloudshell), [install the Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli).
   * Next, Set up [Terraform Cloud](https://app.terraform.io/app) following [this guide](https://learn.hashicorp.com/tutorials/terraform/github-actions?in=terraform/automation#set-up-terraform-cloud).
     Make sure you choose "API Driven workflow"
   * Create your workspace, and then create a couple of necessary variables
   * Create GOOGLE_CREDENTIALS as an environment variable, mark as sensistive, and paste contents of json key file you created using the sed command.
   * Create a terraform (not envrionment) variable value called ```project_id```, and use the ID of the GCP project that you want terraform to deploy into as the value, including quotes.  IE ```"gcp-terraform"```.
   * On the organization settings, create a new API Token.  Copy and save the token which will be used in the next section

* Visit github.com and sign in
   * Fork this repository as your own
   * In the forked version of the repository, visit the ```Settings``` tab and select ```Secrets```
   * Create a new secret calld ```TF_
   * Clone this repository to your local workstation or Google Cloudshell
   * Open a terminal and browse to the root folder of the repository (For example /home/myusername/learn-gcp-terraform)
   * Run ```terraform login``` to initialize your cloud session, and to authenticate your environment
   * Run ```terraform validate``` to verify your configuration
   * Next, run ```terraform plan``` to see the plan results
   * Finally, execute ```terraform apply``` to write your infrastructure
      * At the ``Enter a value:`` prompt, type ``yes`` and hit enter
      * Note that similarly to stage 1 and 2, the VPC network is created first followed by the Compute instance. But this time you should see the plan running at the terraform cloud workspace  
      * This time, however, the layout and files allow for greater scale and specific configurations for additonal networks or Compute instance VMs
   * After 1-2 minutes, you will see ```Apply complete! Resources: 2 added, 0 changed, 0 destroyed.```
