# Use an official Python runtime as a parent image
FROM python:3.7-slim

# Define environment variable
ENV VIP_DOCKER_IMAGE_VERSION 1.0.0

# Set the working directory to /host
WORKDIR /host

# Copy the current directory contents into the container at /host
ADD . /host

RUN apt-get update && apt-get install -y apt-transport-https && apt-get install -y r-base
RUN pip install --trusted-host pypi.python.org -r pythonrequirements.txt

# Make port 80 available to the world outside this container
#EXPOSE 80

# Run app.py when the container launches
#CMD ["python", "test.py"]