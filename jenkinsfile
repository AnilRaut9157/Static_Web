pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/AnilRaut9157/Static_Web.git']])
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Validate'){
            steps {
                sh 'terraform validate'
            }
        }
        stage('Terraform Plan') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: 'Azure_Secret',subscriptionIdVariable: 'SUBS_ID',clientIdVariable: 'CLIENT_ID', clientSecretVariable: 'CLIENT_SECRET',tenantIdVariable: 'TENANT_ID')])
                {
                sh "terraform plan -var 'subscription_id=$SUBS_ID' -var 'tenant_id=$TENANT_ID' -var 'client_id=$CLIENT_ID' -var 'client_secret=$CLIENT_SECRET'"
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: 'Azure_Secret',subscriptionIdVariable: 'SUBS_ID',clientIdVariable: 'CLIENT_ID', clientSecretVariable: 'CLIENT_SECRET',tenantIdVariable: 'TENANT_ID')])
                {
                sh "terraform apply -auto-approve -var 'subscription_id=$SUBS_ID' -var 'tenant_id=$TENANT_ID' -var 'client_id=$CLIENT_ID' -var 'client_secret=$CLIENT_SECRET'"
                }
            }
        }
        
    }
}
