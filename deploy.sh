docker build -t aziz24/multi-client:latest -t aziz24/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aziz24/multi-server:latest -t aziz24/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aziz24/multi-worker:latest -t aziz24/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aziz24/multi-client:latest
docker push aziz24/multi-server:latest
docker push aziz24/multi-worker:latest

docker push aziz24/multi-client:$SHA
docker push aziz24/multi-server:$SHA
docker push aziz24/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aziz24/multi-server:$SHA
kubectl set image deployments/client-deployment client=aziz24/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aziz24/multi-worker:$SHA