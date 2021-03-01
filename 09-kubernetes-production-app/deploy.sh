docker build -t eventhorizn/multi-client:latest -t eventhorizn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eventhorizn/multi-server:latest -t eventhorizn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eventhorizn/multi-worker:latest -t eventhorizn/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push eventhorizn/multi-client:latest
docker push eventhorizn/multi-server:latest
docker push eventhorizn/multi-worker:latest

docker push eventhorizn/multi-client:$SHA
docker push eventhorizn/multi-server:$SHA
docker push eventhorizn/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=eventhorizn/multi-client:$SHA
kubectl set image deployments/server-deployment server=eventhorizn/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=eventhorizn/multi-worker:$SHA