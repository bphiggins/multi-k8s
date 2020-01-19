docker build -t sparkymaster/multi-client:latest -t sparkymaster/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sparkymaster/multi-server:latest -t sparkymaster/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sparkymaster/multi-worker:latest -t sparkymaster/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sparkymaster/multi-client:latest
docker push sparkymaster/multi-server:latest
docker push sparkymaster/multi-worker:latest

docker push sparkymaster/multi-client:$SHA
docker push sparkymaster/multi-server:$SHA
docker push sparkymaster/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sparkymaster/multi-server:$SHA
kubectl set image deployments/client-deployment client=sparkymaster/multi-client:$SHA
kubectl set image deployments/worker-deployment server=sparkymaster/multi-worker:$SHA