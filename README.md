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

* Next, configure and set up Terraform Cloud.
   * Terraform cloud has a free tier that can be used to manage your Infrastructure as code deployments!
   * If you haven't already (and, you're not using GCP's Cloudshell), [install the Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli).
   * Next, Set up [Terraform Cloud](https://app.terraform.io/app) following [this guide](https://learn.hashicorp.com/tutorials/terraform/github-actions?in=terraform/automation#set-up-terraform-cloud).
     Make sure you choose "API Driven workflow"
   * Create your workspace, and then create a couple of necessary variables
   * Create GOOGLE_CREDENTIALS as an environment variable, mark as sensistive, and paste contents of json key file you created using the ```sed``` command.
   * Create a terraform (not envrionment) variable value called ```project_id```, and use the ID of the GCP project that you want terraform to deploy into as the value, including quotes.  IE ```"gcp-terraform"```.
   * On the [Tokens page](https://app.terraform.io/app/settings/tokens), create a new API Token named ```github-actions-token```.  Copy and save the token which will be used in the next section

* Now, we have to link the Github repo to the Terraform Cloud instance we created in the previous step.
   * Visit github.com and sign in
   * Fork this repository as your own
   * In the ```main.tf``` file, update the Terraform Cloud workspace and organization settings on line 13 and 16 respectively
   * In the forked version of the repository, visit the ```Settings``` tab and select ```Secrets```
   * Create a new secret called ```TF_API_TOKEN```, paste the value from the Terraform cloud ```github-actions-token``` step in the previous section.
   * Clone the forked verision of the repository to your local dev environment with Visual Studio or similar, or preferably leverage Google Cloudshell and Cloud editor
   * Using the text editor of your choice, set the appropriate variables across the `variables.tf`
      * Or, you can also set them on the "Variables" section of back at [Terraform Cloud](https://app.terraform.io/app) as shown below.  Note the use of ```TF_VAR_``` in the key names, which enables terraform to reference those variables in the workspace build environment. If you notice the variable names not being referenced in your builds, this is likely the culprit
      
      ![](support-files/terraform-cloud-vars.png?raw=true)

* Lastly, Review the ```terraform-gcp-infra.yaml``` file in the .github/workflows directory
   * Note the branch naming; which commits and merges will kick off the run of this pipeline
   * This job runner will instruct Terraform Cloud build agents to execute the following steps:
      * git pull the repository
      * Run a ```terraform fmt``` to check formatting and syntax
      * Initialize via ```terraform init```
      * Run a plan using ```terraform plan```
      * Apply the changes via ```terraform apply```
      * Output the job status at the end

* Now you're ready to test your run!
      * Commit the changes you've made in your local copy to your forked repo.
      * This can be done via command line: ```git commit -m "commit message"```
      * Once you've committed the change, it should kick off the pipeline.  You can monitor by clicking on ```Actions``` tab, or https://github.com/vanberge/<your-forked-repo-name>/actions

      ![](support-files/github-actions.png?raw=true)


* That's a wrap!  You've now built some infrastructure using Terraform, worked with Terraform Modules for increased automation, and finally fully automated Infrastructure as Code with Github Actions and Terraform Cloud!
      * You should be able to view the run and see the components created by looking at your Terraform Cloud instance

      ![](support-files/terraform-run.png?raw=true)

   