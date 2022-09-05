echo "------------------------------------------"
echo "--- Install helm chart marquezProject  ---"
echo "------------------------------------------"

echo "start up minikube cluster"
echo "-------------------------"
minikube start

echo "creating airflow-marquez-space"
echo "------------------------------"
kubectl create namespace airflow-marquez-ns

echo "creating temporary folder"
echo "-------------------------"
if [ -d "~/marquez-temporary" ];then
	sudo rm -rf ~/marquez-temporary
fi

mkdir ~/marquez-temporary
cd ~/marquez-temporary

echo "Cloning repository"
echo "------------------"
git clone https://github.com/MarquezProject/marquez.git

echo "Going to th chart folder"
echo "------------------------"
cd marquez/chart/

echo "Start up a postgres container"
echo "-----------------------------"
docker-compose -f ./../docker-compose.postgres.yml -p marquez-postgres up -d

echo "set postgres IP address into a variable environment"
echo "---------------------------------------------------"
marquez_db_ip=$(docker inspect marquez-postgres-db-1 -f '{{range.NetworkSettings.Networks}}{{.Gateway}}{{end}}')

echo "Installing marquez chart on airflow-marquez-ns namespace"
echo "--------------------------------------------------------"
helm install marquez . --dependency-update --set marquez.db.host=$marquez_db_ip  --namespace airflow-marquez-ns

echo "marquezAPI port forwarding: kubectl -n airflow-marquez-ns port-forward svc/marquez 5000:80"
echo "marquezWeb port forwarding: kubectl -n airflow-marquez-ns port-forward svc/marquez-web 3000:80"
kubectl -n airflow-marquez-ns port-forward svc/marquez 5000:80 & kubectl -n airflow-marquez-ns port-forward svc/marquez-web 3000:80
