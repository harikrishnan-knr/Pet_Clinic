pipeline {
    agent none

    stages {

        stage('Checkout') {
            agent {
                label 'worker'
            }
            steps {
                git branch: 'main',
                    url: 'https://github.com/harikrishnan-knr/Pet_Clinic.git'
            }
        }

        stage('Check Java') {
            agent {
                label 'worker'
            }
            steps {
                sh '''
                    java -version
                    mvn -version
                '''
            }
        }

        stage('Build') {
            agent {
                label 'worker'
            }
            steps {
                sh 'docker compose -f mysql.yml down || true'
                sh 'mvn clean package -DskipTests'
                sh 'ls -lh target/'
                sh 'docker compose -f mysql.yml up -d'
            }
        }

        stage('Upload to Nexus') {
            agent {
                label 'worker'
            }
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: '3.110.60.91:8081',
                    credentialsId: 'nexus',
                    repository: 'maven-snapshots',
                    groupId: 'org.springframework.samples',
                    version: '4.0.0-SNAPSHOT',
                    artifacts: [
                        [
                            artifactId: 'spring-petclinic',
                            classifier: '',
                            file: 'target/spring-petclinic-4.0.0-SNAPSHOT.jar',
                            type: 'jar'
                        ]
                    ]
                )
            }
        }
    }

    post {
        success {
            echo 'PetClinic built and uploaded to Nexus successfully!'
        }
        failure {
            echo 'Build or Nexus upload failed.'
        }
    }
}
