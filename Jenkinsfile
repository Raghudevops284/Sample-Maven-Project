pipeline {
    agent any 
    stages {
        stage ("sample-stage"){
            steps{
                sh "echo Test Stage.; pwd; hostname; ls -lart" 
            }
        }
		stage("Git-checkout") {
		steps{
		git branch: 'main', url: 'https://github.com/Raghudevops284/Sample-Maven-Project.git'
		}
		}
		
    }
}
