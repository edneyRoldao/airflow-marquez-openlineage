# Airflow startup locally
All tests were made with airflow 2.3.0

## Requirements
- docker
- docker-compose
- helm
- minikube
- kubectl

## Files 
- values.yaml (here you need to change the repositories where DAGs will be read)
- variables.yaml

## Follow this step de deploy arflow

- step 1
```
minikube start
```

- step 2
```
kubectl create namespace airflow-marquez-ns
```

- step 3
```
helm repo add apache-airflow https://airflow.apache.org
```

- step 4
```
helm repo update
```

- step 5
```
helm install airflow apache-airflow/airflow --namespace airflow-marquez-ns --debug --timeout 10m0s
```

- step 6
```
kubectl apply -f variables.yaml -n airflow-marquez-ns
```

- step 7
```
helm upgrade --install airflow apache-airflow/airflow -n airflow-marquez-ns -f values.yaml --debug
```

- step 8 (you should see)
```
Thank you for installing Apache Airflow 2.3.0!

Your release is named airflow.
You can now access your dashboard(s) by executing the following command(s) and visiting the corresponding port at localhost in your browser:

Airflow Webserver:     kubectl port-forward svc/airflow-webserver 8080:8080 --namespace airflow-marquez-ns
Default Webserver (Airflow UI) Login credentials:
    username: admin
    password: admin
Default Postgres connection credentials:
    username: postgres
    password: postgres
    port: 5432
```
