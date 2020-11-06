docker build -t yong9900/multi-client:latest -t yong9900/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yong9900/multi-server:latest -t yong9900/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yong9900/multi-worker:latest -t yong9900/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push -t yong9900/multi-client:latest
docker push -t yong9900/multi-client:$SHA
docker push -t yong9900/multi-server:latest
docker push -t yong9900/multi-server:$SHA
docker push -t yong9900/multi-worker:latest
docker push -t yong9900/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yong9900/multi-server:$SHA
kubectl set image deployments/client-deployment server=yong9900/multi-client:$SHA
kubectl set image deployments/worker-deployment server=yong9900/multi-worker:$SHA