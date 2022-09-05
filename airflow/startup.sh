echo "----------------------------------------"
echo " Installing AIRLFLOW 2.3.0 via Minikube "
echo "----------------------------------------"

echo "starting minikube"
echo "-----------------"
minikube start

echo "creating namespace - airflow-marquez-ns"
echo "---------------------------------------"
kubectl create namespace airflow-marquez-ns

echo "getting apache-airflow repo via helm"
echo "------------------------------------"
helm repo add apache-airflow https://airflow.apache.org

echo "updating helm repo"
echo "------------------"
helm repo update

echo "applying variables.yaml"
echo "-----------------------"
kubectl apply -f variables.yaml -n airflow-marquez-ns

echo "Installing airflow helm chart"
helm install airflow apache-airflow/airflow --namespace airflow-marquez-ns -f values.yaml --debug --timeout 10m0s

echo "Expose airflow port: 8080"
echo "-------------------------"
kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow-marquez-ns
