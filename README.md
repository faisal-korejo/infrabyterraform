 Jenkins Terraform Pipeline
This repository contains a Jenkins pipeline configuration to automate the deployment of infrastructure using Terraform on AWS. The pipeline follows a standard DevOps workflow for managing infrastructure as code (IaC), and it is designed to automate tasks like initializing, planning, and applying Terraform configurations.

*Overview*
This Jenkins pipeline automates the process of managing AWS infrastructure using Terraform. The pipeline consists of multiple stages, including checkout, initialization, planning, and action. It connects Jenkins to AWS via access credentials and allows seamless integration with Terraform for infrastructure provisioning or destruction.

Prerequisites
Before using this pipeline, ensure that the following prerequisites are met:

Jenkins: Jenkins must be installed and configured to run pipelines. You can download Jenkins from Jenkins Official Site.

Terraform: Ensure Terraform is installed on the Jenkins agent where the pipeline will run. You can download it from Terraform Download.

AWS Credentials: AWS access credentials (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) are needed for the pipeline to authenticate and interact with AWS services.

GitHub Repository: This pipeline expects a GitHub repository with Terraform configurations. In this example, the repository is https://github.com/faisal-korejo/infrabyterraform.git. You can replace this with your own repository if necessary.

Jenkins Plugins:

Git Plugin: For pulling the repository.
Pipeline Plugin: For running pipeline jobs.
Credentials Plugin: For storing and managing AWS credentials.
Pipeline Configuration
The Jenkins pipeline is defined in the Jenkinsfile in this repository, and it follows the Declarative Pipeline Syntax. Below is the full configuration:

groovy
Copy
pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('access_key')
        AWS_SECRET_ACCESS_KEY = credentials('secret_key')
    }
    
    stages {
        stage ('one') {
            steps{
                git 'https://github.com/faisal-korejo/infrabyterraform.git'
            }
        }
        stage ('init') {
            steps{
                sh 'terraform init'
            }
        }
        stage ('plan') {
            steps{
                sh 'terraform plan'
            }
        }
        stage ('action') {
            steps{
                sh 'terraform $action --auto-approve'
            }
        }
    }
}
Setup AWS Credentials
For the pipeline to interact with AWS, you must set up the AWS credentials in Jenkins:

Steps to Add AWS Credentials to Jenkins:
Log into Jenkins: Open Jenkins in your browser and log in with your credentials.

Navigate to Jenkins Credentials: Go to Manage Jenkins → Manage Credentials.

Add Credentials:

Kind: Choose "Secret Text".
ID: Use access_key for the AWS Access Key ID and secret_key for the AWS Secret Access Key.
Secret: Provide your AWS Access Key and Secret Key.
Use Credentials in Jenkinsfile: The pipeline will use these credentials by referencing AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as shown in the environment block of the pipeline.

Running the Pipeline
To trigger the pipeline and deploy infrastructure on AWS:

Clone this Repository: Clone this repository into your Jenkins workspace or connect your GitHub repository to Jenkins.

bash
Copy
git clone https://github.com/your-username/your-repository.git
Create a New Pipeline Job in Jenkins:

Open Jenkins and click on New Item.
Select Pipeline, give it a name, and click OK.
In the Pipeline section, select Pipeline script from SCM.
Configure your repository (e.g., GitHub) and provide the repository URL.
Save and trigger the pipeline.
Pipeline Execution: Once you trigger the job, Jenkins will start the pipeline execution. You can monitor the progress and logs in the Jenkins interface.

Pipeline Stages Explained
1. Stage: 'one' (Checkout Repository)
Objective: This stage pulls the Terraform code from the GitHub repository.
Command:
groovy
Copy
git 'https://github.com/faisal-korejo/infrabyterraform.git'
2. Stage: 'init' (Terraform Initialization)
Objective: Initializes the Terraform configuration. It sets up the Terraform working directory and downloads the necessary provider plugins.
Command:
groovy
Copy
sh 'terraform init'
3. Stage: 'plan' (Terraform Plan)
Objective: Runs terraform plan to show the execution plan for the infrastructure changes.
Command:
groovy
Copy
sh 'terraform plan'
4. Stage: 'action' (Apply or Destroy Terraform Changes)
Objective: Depending on the $action variable, this stage will apply or destroy the infrastructure. The action (apply or destroy) is specified at runtime.
Command:
groovy
Copy
sh 'terraform $action --auto-approve'
Customizing the Pipeline
You can customize the pipeline according to your needs:

Add More Stages: If you need additional steps such as running tests or deploying other services, you can add more stages to the pipeline.

Change Infrastructure Action: By default, the pipeline uses the action variable (which can be set to apply or destroy). You can customize this to fit your specific use case, e.g., using terraform refresh or terraform validate.

Add More Environment Variables: You can add other environment variables such as TF_VAR_* for passing configuration variables to Terraform.

Error Handling and Troubleshooting
Here are a few common errors you might encounter while running this pipeline and their solutions:

1. Terraform Initialization Issues
Error: Terraform fails during the terraform init stage.
Solution: Make sure the correct version of Terraform is installed on the Jenkins agent and that the required AWS provider plugin is available.
2. AWS Credentials Issues
Error: AWS authentication fails during the pipeline run.
Solution: Ensure that your AWS access keys are properly configured in Jenkins as "Secret Text" credentials. Double-check the permissions of the IAM user associated with the access keys.
3. Port Conflicts or Network Issues
Error: If the AWS resources depend on specific ports (e.g., EC2 instances), the Terraform apply might fail.
Solution: Check your network security settings (such as VPC and security groups) to ensure no conflicts or misconfigurations.
4. Terraform Plan Shows Unexpected Changes
Error: Terraform plan shows resources that should not be modified.
Solution: Run terraform validate locally to ensure your Terraform files are correct. Check for any discrepancies between your local and remote configurations.
Notes
AWS Permissions: Ensure that the IAM user linked with your AWS credentials has sufficient permissions to create, modify, and delete resources in your AWS account. Common permissions include AmazonEC2FullAccess, IAMFullAccess, and AmazonS3FullAccess.

Terraform State: The Terraform state file is crucial in tracking infrastructure changes. Make sure it is securely stored, preferably in a remote backend like S3 with DynamoDB for state locking.

Pipeline Performance: For large infrastructure deployments, Terraform can take time to plan and apply. You might want to optimize your pipeline for performance by using Terraform modules and workspaces.

Contributing
Feel free to open issues and submit pull requests if you'd like to contribute improvements to this pipeline or share your experience.
