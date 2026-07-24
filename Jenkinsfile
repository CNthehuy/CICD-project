pipeline {
    agent any

    triggers {
        pollSCM('H/2 * * * *')
    }

    environment {
        IMAGE_NAME = 'class-proj-app:latest'
        CONTAINER_NAME = 'flask-app-container'
        APP_URL = 'http://host.docker.internal:5000'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify Environment') {
            steps {
                sh '''
                    echo "Git version:"
                    git --version

                    echo "Docker version:"
                    docker --version

                    echo "Terraform version:"
                    terraform version
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build \
                        --pull \
                        -t "${IMAGE_NAME}" \
                        .
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Format Check') {
            steps {
                dir('terraform') {
                    sh 'terraform fmt -check'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh '''
                        terraform apply \
                            -input=false \
                            -auto-approve \
                            -replace="docker_container.flask_app"
                    '''
                }
            }
        }

        stage('Smoke Test') {
            steps {
                sh '''
                    echo "Waiting for the Flask application..."

                    for attempt in 1 2 3 4 5 6 7 8 9 10
                    do
                        if curl --fail --silent "${APP_URL}" > /dev/null
                        then
                            echo "Flask application is responding."
                            exit 0
                        fi

                        echo "Attempt ${attempt} failed; retrying..."
                        sleep 3
                    done

                    echo "Flask application did not respond."
                    docker ps
                    docker logs "${CONTAINER_NAME}" || true
                    exit 1
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully.'
            echo 'Application: http://localhost:5000'
        }

        failure {
            echo 'Pipeline failed. Review the stage logs above.'
        }

        always {
            sh 'docker ps || true'
        }
    }
}