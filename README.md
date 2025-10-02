jenkins code: pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKER_IMAGE = "joniikrz/task3jenkins"
        DOCKER_TAG = "latest"
    }

    stages {
        stage("Checkout code") {
            steps {
                git branch: 'main', credentialsId: 'githubtoken', url: 'https://github.com/joniikrz/Task3.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                bat 'echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin'
            }
        }

        stage('Push Docker Image') {
            steps {
                bat 'docker push %DOCKER_IMAGE%:%DOCKER_TAG%'
            }
        }

        stage('Cleanup (optional)') {
            steps {
                bat 'docker rmi %DOCKER_IMAGE%:%DOCKER_TAG%'
            }
        }
    }
}
