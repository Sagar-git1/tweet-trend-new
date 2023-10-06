pipeline{
    agent {
        node {
            label 'maven'
        }
    }
environment {
    PATH = "/opt/apache-maven-3.9.4/bin:$PATH "
}

    stages {
        stage("build") {
            steps {
                sh "mvn clean deploy"
            }
        }
        stage('SonarQube analysis') {
            environment {
               scannerHome = tool 'firstsonarqubescanner'; //need to get it from jenkins tools section
            }
            steps {
                withSonarQubeEnv('first-sonarqube-server') { // under system configuration you can get sonar server name
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }
}