# Pyspark-BDaDP

This folder contains Dockerfile and configuration files. You can use it to create container that runs Hadoop, Python, Spark and Jupyter notebook

Build Hadoop Base Image:
```
docker build . -t hadoop-BDaDP
```

Run Image:
```
docker run --name hadoop -p 8088:8088 -p 9870:9870 -p 9864:9864 -p 10000:10000 -p 8032:8032 -p 8030:8030 -p 8031:8031 -p 9000:9000 -p 8888:8888 -itd hadoop-BDaDP
```

Access container with:
```
docker exec -it -u 0 hadoop /bin/bash
```

# Start and Stop Docker Container:
Stop Container:
```
docker stop hadoop
```

Start Container:
```
docker start hadoop
```

# Start and Stop Hadoop within Container:

Restart ssh
```
service ssh restart
```

Switch to hadoop user:
```
sudo su hadoop
cd
```

Start Hadoop FS and Yarn:
```
start-all.sh
```

Start PySpark Shell (with Yarn Master):
```
pyspark --master yarn
```

Start Jupyter Notebook:
```
jupyter notebook
````

Stop Hadoop FS and Yarn:
```
stop-all.sh
```
