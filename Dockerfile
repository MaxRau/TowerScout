# For more information, please refer to https://aka.ms/vscode-docker-python
#FROM ubuntu:20.04
# FROM nvidia/cuda:12.6.0-cudnn-runtime-ubuntu20.04
FROM nvidia/cuda:12.6.0-cudnn-devel-ubuntu20.04
EXPOSE 5000

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
COPY requirements.txt .
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgl1\
    libgl1-mesa-glx \ 
    libglib2.0-0 \
    python3.8 \
    python3-pip

RUN python3.8 -m pip install -r requirements.txt

COPY . /app
WORKDIR /app/webapp

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-python-configure-containers
# RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
# USER appuser

# Run towerscout webapp file
CMD ["python3.8", "./towerscout.py"]
