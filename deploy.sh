# Build images on travis with 2 tags
docker build -t ccazin/multi-client:latest -t ccazin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ccazin/multi-server:latest -t ccazin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ccazin/multi-worker:latest -t ccazin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Take those images and push them to docker hub for each tag
docker push ccazin/multi-client:latest
docker push ccazin/multi-server:latest
docker push ccazin/multi-worker:latest

docker push ccazin/multi-client:$SHA
docker push ccazin/multi-server:$SHA
docker push ccazin/multi-worker:$SHA

# kubectl apply -f k8s
# # Change the name of image into the deployments on k8s directory with the name with SHA to get the right image 
# # So second build for these images ( if there is modifications )
# kubectl set image deployments/server-deployment server=ccazin/multi-server:$SHA
# kubectl set image deployments/client-deployment client=ccazin/multi-client:$SHA
# kubectl set image deployments/worker-deployment worker=ccazin/multi-worker:$SHA