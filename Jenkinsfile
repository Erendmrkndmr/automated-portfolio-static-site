pipeline {
    agent any
    environment {
        IMAGE_NAME = 'portfolio-site'
        CONTAINER_NAME = 'portfolio-container'
        PORT_MAP = '8080:80'
    }
    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/Erendmrkndmr/automated-portfolio-static-site.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "🔧 Docker imajı build ediliyor..."
                    sh "docker build -t $IMAGE_NAME ."
                }
            }
        }

        stage('Stop Previous Container') {
            steps {
                script {
                    echo "🛑 Önceki container varsa durduruluyor..."
                    sh """
                    if [ \$(docker ps -aq -f name=$CONTAINER_NAME) ]; then
                        docker stop $CONTAINER_NAME || true
                        docker rm $CONTAINER_NAME || true
                    fi
                    """
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo "Yeni container başlatılıyor..."
                    sh "docker run -d --name $CONTAINER_NAME -p $PORT_MAP $IMAGE_NAME"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Başarıyla tamamlandı. Siteye EC2-IP:8080 ile erişebilirsin."
        }
        failure {
            echo "❌ Pipeline başarısız oldu. Hataları kontrol etmelisin."
        }
    }
}
