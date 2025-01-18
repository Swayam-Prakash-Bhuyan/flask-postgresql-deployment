pipeline {
    agent any
    environment {
        SCANNER = tool 'sonar-scanner'
    }
    stages {
        stage('Git Checkout') {
            steps {
                echo 'SCM Checkout'
                git 'https://github.com/Swayam-Prakash-Bhuyan/flask-postgresql-deployment.git'
            }
        }
        stage('Trivy') {
            steps {
                echo 'Trivy scan'
                sh 'trivy fs --format table -o fs.html .'
            }
        }
       stage('Docker Build & Tag') {
            steps {
                script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh 'docker build -t swayam0/flask:latest .'
                    }
                }
            }
        }
        stage('Docker image Scan') {
            steps {
                sh 'trivy image --format table -o image.html swayam0/flask:latest'
            }
        }
        stage('Docker Push') {
            steps {
                script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh 'docker push swayam0/flask:latest'
                    }
                }
            }
        }
       stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: ' swayam-dev-cluster', contextName: '', credentialsId: 'k8-token', namespace: 'myapps', restrictKubeConfigAccess: false, serverUrl: 'https://580349F34EA67759A1820479D11E7704.gr7.us-east-1.eks.amazonaws.com') {
                    sh 'kubectl apply -f manifest.yml -n myapps'
                    sleep 30
                }
            }
        }
        stage('Verify Deployment') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: ' swayam-dev-cluster', contextName: '', credentialsId: 'k8-token', namespace: 'myapps', restrictKubeConfigAccess: false, serverUrl: 'https://580349F34EA67759A1820479D11E7704.gr7.us-east-1.eks.amazonaws.com') {
                    sh 'kubectl get pods -n myapps'
                    sh 'kubectl get svc -n myapps'
                }
            }
        }
    }
}
