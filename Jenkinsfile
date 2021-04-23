pipeline {
    environment {
        registry = "elenazhelezova/exam_devops"
        registryCredential = 'docker_id'
        dockerImage = 'web_app'
    }

    agent any

    stages {
        stage('Cloning our Git') {
            steps {
                git 'https://github.com/ElenaZhelezova/student-exam2.git'
            }
        }

        stage('Building our image') {
            steps {
                script {
                    customImage = docker.build registry + ":$dockerImage"
                }
            }
        }

        stage('Testing app') {
            steps {
                script {
                    customImage.inside {
                        sh 'coverage run -m pytest'
                        sh 'coverage report'
                    }
                }
            }
        }

        stage('Deploy our image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        customImage.push()
                    }
                }
            }
        }

        stage('Cleaning up') {
            steps {
                sh "docker rmi $registry:$dockerImage"
            }
        }
    }
}