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
                git 'https://github.com/akinwunmi-akinrimisi/infrastructure-random-quote-app.git'
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
