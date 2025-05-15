pipeline {
  agent any

  parameters {
    string(name: 'USERNAME', defaultValue: 'eren', description: 'Basic Auth Username')
    password(name: 'PASSWORD', defaultValue: 'secretpassword', description: 'Basic Auth Password')
  }

  environment {
    IMAGE_NAME = "portfolio-site"
  }

  stages {
    stage('Clone Repo') {
      steps {
        git branch: 'dev', url: 'https://github.com/Erendmrkndmr/automated-portfolio-static-site.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh """
            docker build --build-arg USERNAME=${params.USERNAME} --build-arg PASSWORD=${params.PASSWORD} -t \$IMAGE_NAME .
          """
        }
      }
    }

    stage('Run Container') {
      steps {
        script {
          sh """
            docker rm -f \$IMAGE_NAME || true
            docker run -d -p 80:80 --name \$IMAGE_NAME \$IMAGE_NAME
          """
        }
      }
    }
  }
}
