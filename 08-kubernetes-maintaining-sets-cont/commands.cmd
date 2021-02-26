kubectl apply -f client-pod.yaml

kubectl get pods

kubectl describe pod client-pod

kubectl delete -f client-pod.yaml

kubectl apply -f client-deployment.yaml

kubectl get deployments

docker build -t eventhorizn/multi-client:v5 .

docker push eventhorizn/multi-client:v5

kubectl set image deployment/client-deployment client=eventhorizn/multi-client:v5