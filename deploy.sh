docker build -t shipster/multi-client:latest -t shipster/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shipster/multi-server:latest -t shipster/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shipster/multi-worker:latest -t shipster/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shipster/multi-client:latest
docker push shipster/multi-server:latest
docker push shipster/multi-worker:latest

docker push shipster/multi-client:$SHA
docker push shipster/multi-server:$SHA
docker push shipster/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shipster/multi-server:$SHA
kubectl set image deployments/client-deployment client=shipster/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shipster/multi-worker:$SHA
