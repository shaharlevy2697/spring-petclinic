pipeline {
    agent any

    stages {
        // stage('SonarQube Analysis') {
        //     steps {
        //         withSonarQubeEnv('SonarQube') {
        //             sh './mvnw sonar:sonar'
        //         }
        //     }
        // }
        stage('Build') {
            steps {
                script {
                    def buildNumber = env.BUILD_NUMBER
                    // Use double quotes for variable interpolation
                    sh "docker build -t sasnow/spring-petclinic:latest -t sasnow/spring-petclinic:${buildNumber} ."
                    sh "docker images"
                    sh "df -h"
                    echo "${buildNumber}"
                    sh "docker push sasnow/spring-petclinic:latest"
                    sh "docker push sasnow/spring-petclinic:${buildNumber}"
                }
            }
        }
        // stage('Build') {
        //     steps {
        //         sh './mvnw package'
        //     }
        // }

        // stage('Docker Build & Push') {
        //     steps {
        //         script {
        //             def buildNumber = env.BUILD_NUMBER
        //             def image = docker.build("shaharlevy2697/spring-petclinic:${buildNumber}")
        //             image.push()
        //             image.push('latest')
        //         }
        //     }
        // }

        // stage('Deploy to Kubernetes') {
        //     steps {
        //         kubernetesDeploy(
        //             configs: 'k8s/helm-chart',
        //             kubeconfigId: 'kubeconfig-credential-id'
        //         )
        //     }
        // }
    }
}
