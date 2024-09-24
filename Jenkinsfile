pipeline {
    agent any
    stages {
        stage('Docker Build & Push') {
            steps {
                script {
                    def buildNumber = env.BUILD_NUMBER
                      docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {
                        // // Docker login
                        // sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin https://index.docker.io/v1/"
                        
                        // Build the Docker image
                        sh "docker build -t sasnow/spring-petclinic:latest -t sasnow/spring-petclinic:${buildNumber} ."
                        
                        // Push the Docker images
                        sh "docker push sasnow/spring-petclinic:latest"
                        sh "docker push sasnow/spring-petclinic:${buildNumber}"
                }
            }
        }
    }
  }
}
