// Declarative //
pipeline {
    agent any
    tools {nodejs 'node'}

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'npm test'
            }
        }
         stage('Image Build') {
            steps {
                echo 'Testing..'
                sh '''
                docker build -t nodejsdocker .

                docker tag nodejsdocker anilkari2021/govtech:nodejs_test_${BUILD_NUMBER}
                docker images
                docker push anilkari2021/govtech:nodejs_test_${BUILD_NUMBER}
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
