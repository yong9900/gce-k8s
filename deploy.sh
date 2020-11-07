docker build -t yong9900/multi-client:latest -t yong9900/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yong9900/multi-server:latest -t yong9900/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yong9900/multi-worker:latest -t yong9900/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yong9900/multi-client:latest
docker push yong9900/multi-server:latest
docker push yong9900/multi-worker:latest

docker push yong9900/multi-client:$SHA
docker push yong9900/multi-server:$SHA
docker push yong9900/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yong9900/multi-server:$SHA
kubectl set image deployments/client-deployment client=yong9900/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yong9900/multi-worker:$SHA