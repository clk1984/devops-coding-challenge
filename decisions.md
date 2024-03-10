The delivered solution consists of 3 GitHub workflows.

The main one sets up the necessary infrastructure in one step to deploy the application in the following step by uploading the generated Docker image to ECR and updating the ECS task.

I needed to create two additional supporting workflows: one to destroy the infrastructure and the second one to unlock the Terraform state for use in situations where Terraform execution has not gone well.

I know that the deployment part was optional, and what I deliver may not be what you were expecting, but I wanted to take advantage of this test to learn about GitHub Actions, ECR, and Django application deployments, which I had never had the opportunity to work with before.

The pipelines I deliver are functional even though the application does not get deployed as it requires a health endpoint in ECS. I am adding the following steps to make this pipeline truly productive in the todo.md file.

The pipelines can be executed or you can see previous executions on GitHub. If you run them, please execute the infrastructure destruction one first, and then the deployment one will remain paused updating the ECR task due to the limitation described earlier: please stop the pipeline so it doesn't keep running until timeout.

