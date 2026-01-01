pipeline {
  agent any

  environment {
    REGISTRY = "your-docker-user/gitops-demo"
    ENV_REPO = "https://github.com/your/env-repo.git"
  }

  stages {
    stage('Build Image') {
      steps {
        sh 'docker build -t $REGISTRY:$BUILD_NUMBER .'
      }
    }

    stage('Push Image') {
      steps {
        sh 'docker login -u $DOCKER_USER -p $DOCKER_PASSWORD'
        sh 'docker push $REGISTRY:$BUILD_NUMBER'
      }
    }

    stage('Update Manifest Repo') {
      steps {
        sh '''
        git clone $ENV_REPO
        cd env-repo/dev
        sed -i "s|image:.*|image: $REGISTRY:$BUILD_NUMBER|g" deployment.yaml
        git config user.email "ci@devops.com"
        git config user.name "Jenkins"
        git commit -am "Updated image to $BUILD_NUMBER"
        git push
        '''
      }
    }
  }
}
