# Use the official Ubuntu base image
FROM ubuntu:20.04

# Set the working directory in the container
WORKDIR /app

# Update the libraries on the Ubuntu OS
RUN apt-get update && \
    apt-get install -y git wget tar default-jre python3-pip

# Clone the GitHub repo
RUN git clone https://github.com/paulovn/ml-vm-notebook

# Change the working directory to ml-vm-notebook
WORKDIR /app/ml-vm-notebook

# List the files in this directory (for debugging purposes, can be removed in production)
RUN ls

# Install Jupyter Notebook
RUN apt-get install -y jupyter-notebook

# Install py4j module
RUN pip3 install py4j --break-system-packages

# Download the Hadoop setup file from the Apache website
RUN wget https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz

# Unzip the tar file
RUN tar -zxvf spark-3.5.1-bin-hadoop3.tgz

# Move the unzipped file to a different directory for ease of access
RUN mv spark-3.5.1-bin-hadoop3 /home/ubuntu/

# Set up the paths for starting up PySpark
ENV SPARK_HOME=/home/ubuntu/spark-3.3.1-bin-hadoop3
ENV PATH=$SPARK_HOME/bin:$PATH
ENV PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH

# Verify the PySpark shell setup
CMD ["pyspark"]
