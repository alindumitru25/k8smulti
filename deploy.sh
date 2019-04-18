docker build -t alindumitru255/multicontainer-client:latest -t alindumitru255/multicontainer-client:$SHA -f ./client/Dockerfile ./client
docker build -t alindumitru255/multicontainer-server:latest -t alindumitru255/multicontainer-server:$SHA -f ./server/Dockerfile ./server
docker build -t alindumitru255/multicontainer-worker:latest -t alindumitru255/multicontainer-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alindumitru255/multicontainer-client:latest
docker push alindumitru255/multicontainer-server:latest
docker push alindumitru255/multicontainer-worker:latest

docker push alindumitru255/multicontainer-client:$SHA
docker push alindumitru255/multicontainer-server:$SHA
docker push alindumitru255/multicontainer-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=alindumitru255/multicontainer-client:$SHA
kubectl set image deployments/server-deployment server=alindumitru255/multicontainer-server:$SHA
kubectl set image deployments/worker-deployment worker=alindumitru255/multicontainer-worker:$SHA
