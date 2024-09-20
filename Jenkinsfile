pipeline {
    agent any

    // stages {
    //     stage('Checkout') {
    //         steps {
    //             git url: 'https://github.com/<your-username>/<your-repo>.git'
    //         }
    //     }

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
                    def image = docker.build("<your-dockerhub-username>/spring-petclinic:${buildNumber}")
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

    post {
        always {
            cleanWs()
        }
    }
}
