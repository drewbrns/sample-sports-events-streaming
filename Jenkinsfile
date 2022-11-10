pipeline {
    agent any 
    
    stages {
        stage("build") {
            steps {
                echo 'Building application'
            }
        }

        stage("test") {
            steps {
                echo 'Testing application'
            }
        }

        stage("deploy") {
            steps {
                retry (5) {
                    echo 'Deploying application'
                }
            }
        }        
    }
}