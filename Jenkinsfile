pipeline {
    agent any

    stages {
      
        stage ("terraform init") {
            steps {
                sh ('terraform init') 
            }
        }
        
        stage ("terraform Action") {
            steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve') 
           }
        }

        stage('Retrieve Instance ID and IP Address') {
            steps {
                script {
                    // Use AWS CLI to retrieve the instance ID and IP address
                    def instanceIdCommand = "aws ec2 describe-instances --filters Name=tag:Name,Values=webserver --query 'Reservations[0].Instances[0].InstanceId' --region 'us-west-2' --output text"
                    def instanceId = sh(returnStdout: true, script: instanceIdCommand).trim()

                    def ipAddressCommand = "aws ec2 describe-instances --instance-ids ${instanceId} --query 'Reservations[0].Instances[0].PublicIpAddress' --region 'us-west-2' --output text"
                    def ipAddress = sh(returnStdout: true, script: ipAddressCommand).trim()

                    // Store the instance ID and IP address in environment variables
                    env.WEBSERVER_INSTANCE_ID = instanceId
                    env.WEBSERVER_IP = ipAddress
                }
            }
        }

        stage('Clone Repository') {
            steps {
                // Cloning the repository containing the app files and Terraform templates
                git credentialsId: '8bd673b8-5538-4c5b-9b78-b5618f83fef8', url: 'https://github.com/akinwunmi-akinrimisi/infrastructure-random-quote-app.git', branch: 'main'
            }
        }

        stage('Deploy App Files') {
            steps {
                // Copy or sync the app files to the webserver
                sh "rsync -avz --delete app/ user@${env.WEBSERVER_IP}:/var/www/html/"
            }
        }
    }
}
