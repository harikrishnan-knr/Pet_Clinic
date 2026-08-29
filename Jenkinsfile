pipeline {
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

        stage('Build') {
            agent {
                label 'worker'
            }
            steps {
                sh 'mvn clean package -DskipTests'
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
                    credentialsId: 'nexus-credentials',
                    repository: 'maven-snapshots',
                    groupId: 'org.springframework.samples',
                    artifactId: 'spring-petclinic',
                    version: '4.0.0-SNAPSHOT',
                    artifacts: [
                        [
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
            echo 'Build and Nexus upload successful!'
        }
        failure {
            echo 'Build or Nexus upload failed.'
        }
    }
}
