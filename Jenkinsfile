pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred-rawluck')
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t rawluck/rds-status-site:latest .'
            }
        }
        stage('Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push') {
            steps {
                sh 'docker push rawluck/rds-status-site:latest'
            }
        }
        stage('Push to K8s') {
            steps {
                sh 'kubectl apply -f ./k8s/* --kubeconfig ~/.kube/config'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
