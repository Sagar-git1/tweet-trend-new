def registry = 'https://sagardevops01.jfrog.io'
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
        stage('Quality gate') {
          steps {
            script {
                timeout(time: 1, unit: 'HOURS') {
                    def qg = waitForQualityGate()
                    if (qg.status != 'OK') {
                        error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
                }
            }
          }
        }
        stage('Jar publish') {
            steps {
                script {
                    echo '<--------------- Jar Publish Started --------------->'
                    def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrog-cred"
                    def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                    def uploadSpec = """{
                        "files": [
                            {
                              "pattern": "target/(*)",
                              "target": "libs-release-local/{1}",
                              "flat": "false",
                              "props" : "${properties}",
                              "exclusions": [ "*.original", "*.exec"]
                            }
                        ]
                     }"""  
                    def buildInfo = server.upload(uploadSpec)
                    buildInfo.env.collect()
                    server.publishBuildInfo(buildInfo)
                    echo '<--------------- Jar Publish Ended --------------->'              
                }
            }
        } 
    }
}