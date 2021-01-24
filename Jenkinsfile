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

                docker tag nodejsdocker anilkari2021/govtech:nodejs_${BRANCH_NAME}_${BUILD_NUMBER}
            docker images
                docker push anilkari2021/govtech:nodejs_${BRANCH_NAME}_${BUILD_NUMBER}
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh 'SELECTION=${BRANCH_NAME}_${BUILD_NUMBER}'
                sh 'sed -i "s/SELECTION/${SELECTION}/g" ${WORKSPACE}/docker-compose.yml'
                sh 'cat  ${WORKSPACE}/docker-compose.yml'
                sh 'scp ${WORKSPACE}/docker-compose.yml ubuntu@3.80.97.156:/home/ubuntu; ssh ubuntu@3.80.97.156; cd /home/ubuntu; docker-compose -d run -e DATA_FILE=Questions-test.json mynodeservice'
                //sshPublisher(publishers: [sshPublisherDesc(configName: 'deployment-node', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'cd /home/ubuntu; docker-compose run -e DATA_FILE=Questions-test.json -e SELECTION=${SELECTION} mynodeservice', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/home/ubuntu', remoteDirectorySDF: false, removePrefix: '', sourceFiles: 'docker-compose.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                //sshPublisher(publishers: [sshPublisherDesc(configName: 'deployment-node', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'cd /home/ubuntu; docker-compose up -d', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/home/ubuntu', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '${WORKSPACE}/docker-compose.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
