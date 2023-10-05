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
        stage {
            steps {
                sh "mvn clean deploy"
            }
        }
    }
}