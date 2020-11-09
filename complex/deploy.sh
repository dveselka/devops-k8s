docker build -t dveselka/multi-client:latest -t dveselka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dveselka/multi-server:latest -t dveselka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dveselka/multi-worker:latest -t dveselka/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dveselka/multi-client:latest
docker push dveselka/multi-server:latest
docker push dveselka/multi-worker:latest

docker push dveselka/multi-client:$SHA
docker push dveselka/multi-server:$SHA
docker push dveselka/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dveselka/multi-server:$SHA
kubectl set image deployments/client-deployment client=dveselka/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dveselka/multi-worker:$SHA
