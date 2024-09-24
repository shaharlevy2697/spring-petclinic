pipeline {
    agent any
    stages {
        stage('Docker Build & Push') {
            steps {
                script {
                    def buildNumber = env.BUILD_NUMBER
                      docker.withRegistry('https://index.docker.io/v1/', 'docker-hub') {                 
                        sh "docker build -t sasnow/spring-petclinic:latest -t sasnow/spring-petclinic:${buildNumber} ."
                        sh "docker push sasnow/spring-petclinic:latest"
                        sh "docker push sasnow/spring-petclinic:${buildNumber}"
                }
            }
        }
    }
  }
}
