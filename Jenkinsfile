pipeline {
    environment {
        IMAGEN = "josemanuel4fernandez/crud-php"
        LOGIN = 'USER_DOCKERHUB'
    }
    agent none
    stages {
        stage("Construccion") {
            agent any
            stages {
                stage('CloneAnfitrion') {
                    steps {
                        git branch:'main',url:'https://github.com/Josemanuel4f/Crud-PHP'
                    }
                }
                stage('BuildImage') {
                    steps {
                        script {
                            newApp = docker.build "$IMAGEN"
                        }
                    }
                }
                stage('UploadImage') {
                    steps {
                        script {
                            docker.withRegistry( '', LOGIN ) {
                                newApp.push()
                            }
                        }
                    }
                }
                stage('RemoveImage') {
                    steps {
                        sh "docker rmi -f $IMAGEN:latest"
                    }
                }
                stage ('SSH') {
    steps{
        sshagent(credentials : ['SSH_JOSEMA']) {
            sh 'ssh -o StrictHostKeyChecking=no josema@race.overcat.es cd /home/josema/crud/'
            sh 'ssh -o StrictHostKeyChecking=no josema@race.overcat.es wget https://raw.githubusercontent.com/Josemanuel4f/Crud-PHP/main/docker-compose.yaml -O docker-compose.yaml'
            sh 'ssh -o StrictHostKeyChecking=no josema@race.overcat.es docker compose up -d --force-recreate'
        }
    }
}
            }
        }           
    }
    post {
        always {
            mail to: 'josemanuel4fernandez@gmail.com',
            subject: "Status of pipeline: ${currentBuild.fullDisplayName}",
            body: "$IMAGEN ${env.BUILD_URL} has result ${currentBuild.result}"
        }
    }
}
