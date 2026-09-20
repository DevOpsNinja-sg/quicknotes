pipeline {

    agent any

    environment {
        IMAGE_NAME = "sxhilgupta/quicknotes"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Set Git SHA') {
            steps {
                script {
                    env.GIT_SHA = sh(
                        script: 'git rev-parse --short=12 HEAD',
                        returnStdout: true
                    ).trim()

                    echo "Git SHA: ${env.GIT_SHA}"
                }
            }
        }

    

        stage('Docker Build') {
            steps {
                echo "Building image: ${IMAGE_NAME}:${GIT_SHA}"

                sh '''
                    docker build \
                        -t ${IMAGE_NAME}:${GIT_SHA} \
                        .
                '''
            }
        }

        stage('Trivy Scan') {
    steps {
        sh '''
            docker run --rm \
                -v /var/run/docker.sock:/var/run/docker.sock \
                aquasec/trivy:latest \
                image \
                --severity HIGH,CRITICAL \
                --exit-code 1 \
                ${IMAGE_NAME}:${GIT_SHA}
        '''
    }
}

        stage('Docker Push') {
            steps {

                echo "Pushing ${IMAGE_NAME}:${GIT_SHA} to Docker Hub..."

                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {

                    sh '''
                        echo "$DOCKER_PASSWORD" | \
                            docker login \
                            --username "$DOCKER_USERNAME" \
                            --password-stdin

                        docker push ${IMAGE_NAME}:${GIT_SHA}

                        docker logout
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "CI pipeline completed successfully."
            echo "Image: ${IMAGE_NAME}:${GIT_SHA}"
        }

        failure {
            echo "CI pipeline failed."
        }

        always {
            sh 'docker logout || true'
        }
    }
}
