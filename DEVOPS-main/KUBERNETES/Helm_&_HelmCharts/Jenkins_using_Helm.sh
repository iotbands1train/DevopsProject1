
# Installing Jenkins application using Helm
# Reference: https://github.com/jenkinsci/helm-charts

kubectl create namespace jenkins
helm repo add jenkins https://charts.jenkins.io   #(to add charts related to jenkins application)
helm repo update                                  #(to update the repository)
helm search repo jenkins                          #(to search 'jenkins' in helm repository)
helm install jenkins jenkins/jenkins -n jenkins
kubectl get pods -n jenkins

kubectl exec -it <pod-name> -n jenkins -- /bin/bash

# To get Jenkins password after helm setup
kubectl exec --namespace jenkins -it svc/my-jenkins-app -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo