# Marquez openlineage startup locally


## Requirements
- docker
- docker-compose
- helm
- minikube
- kubectl


## Follow this step de deploy marquez openlineage
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
if [ -d "~/marquez-temporary" ];then
	sudo rm -rf ~/marquez-temporary
fi

mkdir ~/marquez-temporary

cd ~/marquez-temporary
```

- step 4
```
git clone https://github.com/MarquezProject/marquez.git
```

- step 5
```
cd marquez/chart/
```

- step 6
```
docker-compose -f ./../docker-compose.postgres.yml -p marquez-postgres up -d
```

- step 7
```
marquez_db_ip=$(docker inspect marquez-postgres-db-1 -f '{{range.NetworkSettings.Networks}}{{.Gateway}}{{end}}')
```

- step 8
```
helm install marquez . --dependency-update --set marquez.db.host=$marquez_db_ip  --namespace airflow-marquez-ns
```

- step 9 (port forwarding)
```
marquezAPI port forwarding: kubectl -n airflow-marquez-ns port-forward svc/marquez 5000:80 & marquezWeb port forwarding: kubectl -n airflow-marquez-ns port-forward svc/marquez-web 3000:80
```

