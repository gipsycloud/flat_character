pipeline {
    agent any

    environment {
        IMAGE_NAME = 'aungwin/flat_mate'  // Must be "username/repository" format
        IMAGE_TAG = "${env.BUILD_NUMBER}-${env.GIT_COMMIT_SHORT}"  // Dynamic tagging
        DOCKERHUB_CREDENTIALS = 'hrms'  // Jenkins Credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone your repo
                git 'https://github.com/gipsycloud/flat_character.git'
            }
        }
        
        stage('Test Docker Access') {
            steps {
                script {
                    sh 'docker ps'  // Should list containers (not show errors)
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                        docker.image("${IMAGE_NAME}:${IMAGE_TAG}").push('1.0')
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()  // Clean workspace post-build
        }
        success {
            echo "Successfully pushed ${IMAGE_NAME}:${IMAGE_TAG}"
        }
    }
}
