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
                sh "sudo docker build -f Dockerfile -t rrs8/sysdig-test:1.0 ."
            }
        }
        stage('Push Image') {
            steps {
                sh "sudo docker login --username ${DOCKER_USR} --password ${DOCKER_PSW}"
                sh "sudo docker push rrs8/sysdig-test:1.0"
                sh "echo docker.io/rrs8/sysdig-test:1.0 > sysdig_secure_images"
            }
        }
        stage('Scanning Image') {
            steps {
                sysdigSecure 'sysdig_secure_images'
            }
        }
   }
}
