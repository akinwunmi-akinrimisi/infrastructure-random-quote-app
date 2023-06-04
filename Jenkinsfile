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

        stage('Clone Repository') {
            steps {
                // Cloning the repository containing the app files and Terraform templates
                git credentialsId: '8bd673b8-5538-4c5b-9b78-b5618f83fef8', url: 'https://github.com/akinwunmi-akinrimisi/infrastructure-random-quote-app.git'
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
