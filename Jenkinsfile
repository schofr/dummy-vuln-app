pipeline {
    agent any
    environment {
        DOCKER = credentials('docker-repository-credentials')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Image') {
            steps {
                sh "sudo docker build -f Dockerfile -t msaxena21/sysdig-test ."
            }
        }
        stage('Push Image') {
            steps {
                sh "sudo docker login --username ${DOCKER_USR} --password ${DOCKER_PSW}"
                sh "sudo docker push msaxena21/sysdig-test:1.0"
                sh "echo docker.io/msaxena21/sysdig-test > sysdig_secure_images"
            }
        }
        stage('Scanning Image') {
            steps {
                sysdigSecure 'sysdig_secure_images'
            }
        }
   }
}
