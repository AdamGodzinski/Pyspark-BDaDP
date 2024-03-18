FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install sudo 
RUN apt-get install -y curl 
RUN apt-get install -y wget
RUN apt-get install -y nano
RUN apt-get install -y ssh pdsh openssh-client openssh-server

RUN apt-get install -y python python3 python3-pip


RUN useradd -ms /bin/bash hadoop

USER hadoop
WORKDIR /home/hadoop

RUN pip3 install --upgrade pip
RUN pip3 install jupyter 
RUN pip3 install findspark 
RUN pip3 install matplotlib 
RUN pip3 install pandas
RUN pip3 install notebook
RUN pip3 install pyspark==2.3.4

RUN mkdir /home/hadoop/.ssh
RUN ssh-keygen -t rsa -N "" -f /home/hadoop/.ssh/id_rsa
RUN cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys
RUN chmod 0600 /home/hadoop/.ssh/authorized_keys

RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz && tar -xzf hadoop-3.1.2.tar.gz && rm hadoop-3.1.2.tar.gz && mv hadoop-3.1.2 hadoop

RUN wget https://archive.apache.org/dist/spark/spark-2.3.4/spark-2.3.4-bin-hadoop2.7.tgz && tar -xvzf spark-2.3.4-bin-hadoop2.7.tgz && rm spark-2.3.4-bin-hadoop2.7.tgz && mv spark-2.3.4-bin-hadoop2.7 spark

COPY .bashrc .bashrc
COPY spark-env.sh /home/hadoop/spark/conf/spark-env.sh
COPY slaves /home/hadoop/spark/conf/slaves
COPY yarn-site.xml hadoop/etc/hadoop/yarn-site.xml
COPY core-site.xml hadoop/etc/hadoop/core-site.xml
COPY hadoop-env.sh hadoop/etc/hadoop/hadoop-env.sh
COPY hdfs-site.xml hadoop/etc/hadoop/hdfs-site.xml
COPY mapred-site.xml hadoop/etc/hadoop/mapred-site.xml

USER root
WORKDIR /

RUN mkdir /home/hadoop/.jupyter/ 
COPY jupyter_notebook_config.py /home/hadoop/.jupyter/jupyter_notebook_config.py 

EXPOSE 8088
EXPOSE 9870
EXPOSE 9000
EXPOSE 10000
EXPOSE 4040
EXPOSE 8042
EXPOSE 8030
EXPOSE 8031
EXPOSE 8032
EXPOSE 8888
EXPOSE 30000-50000

RUN /home/hadoop/hadoop/bin/hdfs namenode -format




 