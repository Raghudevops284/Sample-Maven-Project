pipeline {
    agent any

    options {
        buildDiscarder(logRotator(daysToKeepStr: '5', numToKeepStr: '20'))
        timestamps()
        timeout(time: 5, unit: 'MINUTES')
    }

    tools {
        maven 'Maven'
    }

    environment {
        APP_NAME = 'myapp'
        ENVIRONMENT = 'dev'
        EMAIL_RECIPIENT = 'raghavendra.praveen89@gmail.com'
    }

    stages {

        stage("Env Variables") {
            steps {
                echo "==== Environment Info ===="
                sh '''
                    echo "Working Directory: $(pwd)"
                    echo "Hostname: $(hostname)"
                    echo "App Name: $APP_NAME"
                    echo "Environment: $ENVIRONMENT"
                '''
            }
        }

        stage("Print Env") {
            environment {
                SERVER = "10.10.0.0-DEV"
            }
            steps {
                echo "Server Environment: ${env.SERVER}"
            }
        }

        stage('Print Tools Info') {
            steps {
                script {
                    def mvnHome = tool 'Maven'
                    echo "Maven Installed Path: ${mvnHome}"
                    sh "${mvnHome}/bin/mvn -version"
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Raghudevops284/Sample-Maven-Project.git'
            }
        }

        stage('Build') {
            steps {
			catchError(buildResult:'SUCCESS', stageResult:'Failure') {
                script {
                    def mvnHome = tool 'Maven'
                    sh "${mvnHome}/bin/mvn clean install deploy -U -s ${WORKSPACE}/settings.xml"
                }
            }
        }
        }
		
	  stage('sonar-analysis') {
            steps {
                script {
                    def mvnHome = tool 'Maven'
                    sh "${mvnHome}/bin/mvn sonar:sonar -U -s ${WORKSPACE}/settings.xml"
                }
            }
        }
	       stage('Deploy to Tomcat') {
    steps {
        sshagent(['Tomcat-Server-deployments']) {
            sh '''
                scp -o StrictHostKeyChecking=no \
                /var/lib/jenkins/workspace/Pipeline/target/devops111.war \
                ubuntu@50.16.122.151:/opt/apache-tomcat-10.1.48/webapps/
            '''
        }
    }
}	
		
    }

    post {

        success {
            emailext(
                to: "${env.EMAIL_RECIPIENT}",
                subject: "SUCCESS: Job '${env.JOB_NAME}-${env.BUILD_NUMBER}'",
                attachLog: true,
                body: 'Build SUCCESSFUL.\n\nConsole log attached.\n'
            )
            cleanWs()
        }

        failure {
            emailext(
                to: "${env.EMAIL_RECIPIENT}",
                subject: "FAILED: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
                attachLog: true,
                body: 'Build FAILED.\n\nLast 150 log lines:\n\n${BUILD_LOG, maxLines=150, escapeHtml=false}'
            )
        }

        unstable {
            emailext(
                to: "${env.EMAIL_RECIPIENT}",
                subject: "UNSTABLE: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}",
                attachLog: true,
                body: 'Build UNSTABLE.\n\nLast 150 log lines:\n\n${BUILD_LOG, maxLines=150, escapeHtml=false}'
            )
        }
    }
}
