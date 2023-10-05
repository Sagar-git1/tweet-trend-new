pipeline{
    agent {
        node {
            label 'maven'
        }
    }
environment {
    PATH = ":$PATH "
}

    stages {
        stage("build") {
            steps {
                sh "mvn clean deploy"
            }
        }
    }
}