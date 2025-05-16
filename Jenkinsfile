pipeline {
  agent any

  parameters {
    string(name: 'USERNAME', defaultValue: 'admin', description: 'Basic Auth Username')
    string(name: 'PASSWORD', defaultValue: 'secret123', description: 'Basic Auth Password')
  }

  environment {
    IMAGE_NAME = "automated-portfolio-site"
    CONTAINER_NAME = "portfolio-site"
    PORT = "9090"
  }

  stages {
    stage('Build Docker Image') {
      steps {
        sh "docker build --build-arg USERNAME=${params.USERNAME} --build-arg PASSWORD=${params.PASSWORD} -t $IMAGE_NAME ."
      }
    }

    stage('Stop Previous Container') {
      steps {
        sh "docker stop $CONTAINER_NAME || true && docker rm $CONTAINER_NAME || true"
      }
    }

    stage('Run Container') {
      steps {
        sh "docker run -d -p ${PORT}:80 --name $CONTAINER_NAME $IMAGE_NAME"
      }
    }
  }
}
