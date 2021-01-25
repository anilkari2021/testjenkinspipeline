// Declarative //
pipeline {
    agent any
    tools {nodejs 'node'}
    stages {
        stage('update version') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'staging') {
                        
                        echo 'I only execute on the staging branch'
                        sh '''
                        sed -i 's/buildtime_variable/Questions-test.json/g' ${WORKSPACE}/Dockerfile
                        '''
                        
                    } else {
                        echo 'I execute elsewhere'
                        sh '''
                        sed -i 's/buildtime_variable/Questions.json/g' ${WORKSPACE}/Dockerfile
                        '''
                    }
                }
            }
        }    
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
                docker tag nodejsdocker anilkari2021/govtech:${BRANCH_NAME}_${BUILD_NUMBER}
                docker images
                docker push anilkari2021/govtech:${BRANCH_NAME}_${BUILD_NUMBER}
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                echo 'Deploying....'
                SELECTION=${BRANCH_NAME}_${BUILD_NUMBER}
                sed -i "s/SELECTION/${SELECTION}/g" ${WORKSPACE}/docker-compose.yml
                cat  ${WORKSPACE}/docker-compose.yml
                scp ${WORKSPACE}/docker-compose.yml ubuntu@34.236.144.86:/home/ubuntu; ssh ubuntu@34.236.144.86 "cd /home/ubuntu && docker-compose stop && docker-compose rm -f && docker image prune -a -f && docker-compose -f /home/ubuntu/docker-compose.yml up -d"
                '''
             }
        }
    }
     post {

      success {
        sh 'echo "This will run only if successful"'
       }
      failure {
       sh 'echo "This will run only if failed"'
       emailext attachLog: true, body: 'Jenkins build failed for $BRANCH_NAME_$BUILD_NUMBER, please verify', subject: 'Jenkins failed ', to: 'anilkari2021@gmail.com'
 }
       unstable {
         sh 'echo "This will run only if the run was marked as unstable"'
 }
}
}
