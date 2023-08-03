pipeline {
  agent {
    node {
      label 'terraform'
    }
  }
  tools {
    git 'Gittool' 
  }
  stages {
    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }
    stage('Terraform format') {
      steps {
        sh 'terraform fmt'
      }
    }
    stage('Terraform validate') {
      steps {
        sh 'terraform validate'
      }
    }
    stage('Terraform Plan') {
      steps {
        sh 'terraform plan -out tf.plan'
      }
    }
    stage('Terraform Policy Check') {
      steps {
        sh 'terraform show -json tf.plan  > tf.json '
        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE')
        {
            sh '/home/ubuntu/.local/bin/checkov -f tf.json'
        }
      }
    }
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }
}
