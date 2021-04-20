pipeline {
  environment {
    registry = "elenazhelezova/exam_devops"
    registryCredential = 'docker_id'
    dockerImage = 'web_app'
  }
  agent any
  stages {
    stage('Cloning git repo'){
      steps{
        git "https://github.com/ElenaZhelezova/student-exam2.git"
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Testing app') {
      steps{
        sh 'coverage run -m pytest'
        sh 'coverage report'
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}