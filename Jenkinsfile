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
                echo"------------------- build started -------------------"
                sh "mvn clean deploy -Dmaven.test.skip=true"
                echo"------------------- build completed -----------------"
            }
        }
        stage("test") {
            steps {
                echo "-------------------unit test started-----------------"
                sh "mvn surefire-report:report"
                echo "--------------------unit test completed--------------"
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