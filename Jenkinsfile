pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Cloning the repository containing the app files and Terraform templates
                git 'https://github.com/akinwunmi-akinrimisi/infrastructure-random-quote-app.git'
            }
        }

        stage('Build and Deploy Infrastructure') {
            steps {
                // Change to the directory containing the Terraform templates
                dir('terraform') {
                    // Run Terraform commands to deploy or update the infrastructure
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy App Files') {
            steps {
                // Copy or sync the app files to the webserver
                sh 'rsync -avz --delete app/ user@webserver:/var/www/html/'
            }
        }
    }
}
