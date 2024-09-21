pipeline {
    agent any

    stages {
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh './mvnw sonar:sonar'
                }
            }
        }

        stage('Build') {
            steps {
                sh './mvnw package'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    def buildNumber = env.BUILD_NUMBER
                    def image = docker.build("shaharlevy2697/spring-petclinic:${buildNumber}")
                    image.push()
                    image.push('latest')
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                kubernetesDeploy(
                    configs: 'k8s/helm-chart',
                    kubeconfigId: 'kubeconfig-credential-id'
                )
            }
        }
    }
}
