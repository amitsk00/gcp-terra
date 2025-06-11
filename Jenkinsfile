
pipeline {
    agent any

    environment {
        GCP_SETUP_CREDS = 'false'
        GCP_SETUP_KEYFILE = 'true'

        PROJECT_ID = 'ask-proj-35'
        REGION = 'us-central1'
        SA_NAME = 'cicd-terra@ask-proj-35.iam.gserviceaccount.com'
        KEY_FILE_PATH = '/home/amit/sandbox/gcp-ask-proj-25'
        KEY_FILE_NAME = 'key.json'
        
        REPO_NAME = 'ar-py'
        IMAGE_NAME = 'py-v1'
    }    

    stages {
        stage('Start') {
            steps {
                echo 'Starting the pipeline'
            }
        }

        stage('key-file-copy') {
            steps {
                sh '''
                    cp $KEY_FILE_PATH/$KEY_FILE_NAME  $WORKSPACE/$KEY_FILE_NAME
                '''
            }
        }
 

        stage('gcp-setup1'){
            when {
                expression { return env.GCP_SETUP_CREDS == 'true' }
            }            
            steps {
                withCredentials([file(credentialsId: 'cicd_terra_key', variable: 'KEY_FILE')]) {
                
                    sh '''
                        gcloud auth activate-service-account --key-file=$KEY_FILE_NAME 
                        gcloud config set project $PROJECT_ID
                        gcloud config set compute/region $REGION                    
                                        
                    '''
                }

            }
        }

        stage('gcp-setup2'){
            when {
                expression { return env.GCP_SETUP_KEYFILE == 'true' }
            }            
            steps {

                sh '''
                    gcloud auth activate-service-account --key-file=$KEY_FILE_NAME 
                    gcloud config set project $PROJECT_ID
                    gcloud config set compute/region $REGION                    
                                    
                '''
                }

            
        }        

        stage('GCP1'){
            steps {
                sh '''
                echo 'GCP1'
                gcloud config list 
                '''
            }
        }
        stage('GCP2'){
            steps {
                sh '''
                echo 'GCP2' 
                gcloud compute instances list  
                '''
            }
        }

        stage('End') {
            steps {
                echo 'Pipeline completed'
            }
        }
        
    }
}

