// Declarative //
pipeline {
    agent any
    tools {nodejs 'node'}
    stage('update version') {
      when{
         branch 'release'
          }
    steps {
    echo 'Updating the package version'
        sh 'sed -i "s/DEPLOY_VESION/1.0.0_${BUILD_NUMBER}/g" package.json 
            }
        } 
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

                docker tag nodejsdocker anilkari2021/govtech:nodejs_${BRANCH_NAME}_${BUILD_NUMBER}
                docker images
                docker push anilkari2021/govtech:nodejs_${BRANCH_NAME}_${BUILD_NUMBER}
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
