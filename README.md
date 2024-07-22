### Kubernetes Web Application

#### Objective
Deploy a simple web application using Kubernetes, expose it via a service, and access it locally.

### Detailed Steps

#### Prerequisites
- A running Kubernetes cluster (This example was built using Docker Desktop. Other options include Minkube or any cloud provider Kubernetes service)
- kubectl CLI installed and configured (included with Docker Desktop)
- Docker installed to build the Docker image

#### Step 1: Start with a Web Application
Feel free to use the provided zip file or clone the web application repository:
```bash
git clone (https://github.com/SeanBryson/DockerWebApp.git
cd DockerWebApp
```

#### Step 2: Build the Docker Image
Build the Docker image for the web application:
```bash
docker build -t dockerwebapp .
```

#### Step 3: Push the Docker Image to DockerHub
Tag and push the Docker image to DockerHub (replace `your-dockerhub-username` with your actual DockerHub username):
```bash
docker tag dockerwebapp your-dockerhub-username/dockerwebapp:latest
docker push your-dockerhub-username/dockerwebapp:latest
```

#### Step 4: Create a Deployment
Create a Kubernetes Deployment to run your Docker container. Create a file named `deployment.yaml` with the following content:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dockerwebapp
spec:
  replicas: 2
  selector:
    matchLabels:
      app: dockerwebapp
  template:
    metadata:
      labels:
        app: dockerwebapp
    spec:
      containers:
      - name: dockerwebapp
        image: your-dockerhub-username/dockerwebapp:latest
        ports:
        - containerPort: 3000
```
Apply the deployment:
```bash
kubectl apply -f deployment.yaml
```

#### Step 5: Expose the Deployment with a Service
Create a service to expose the Deployment. Create a file named `service.yaml` with the following content:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: dockerwebapp-service
spec:
  type: LoadBalancer
  selector:
    app: dockerwebapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
```
Apply the service:
```bash
kubectl apply -f service.yaml
```

#### Step 6: Verify the Deployment and Service
Check the status of the pods:
```bash
kubectl get pods
```
You should see the pods in `Running` status:
```
NAME                            READY   STATUS    RESTARTS   AGE
dockerwebapp-564b7fb9c7-9pbcr   1/1     Running   0          11s
dockerwebapp-564b7fb9c7-sx45x   1/1     Running   0          13s
```

Check the status of the service:
```bash
kubectl get services
```
You should see the service with an external IP:
```
NAME                   TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
dockerwebapp-service   LoadBalancer   10.102.252.50   localhost     80:31883/TCP   103s
kubernetes             ClusterIP      10.96.0.1       <none>        443/TCP        6d4h
```

#### Step 7: Access the Application
If using a LoadBalancer service type and the EXTERNAL-IP is not set to a public IP, you can use port forwarding to access the application:
```bash
kubectl port-forward svc/dockerwebapp-service 8080:80
```
Open your web browser and navigate to:
```
http://localhost:8080
```

## [Optional] Installing Node Modules

It's not necassry to install node modules prior to containerizing the application. With that in mind, here are the steps to run the project locally without Docker:

1. **Navigate to your project directory**: Open a terminal and navigate to the directory of your project where your `package.json` file is located.

2. **Install the modules**: Run the following command to install the modules:

    ```bash
    npm install
    ```

    This command reads the `package.json` file in your project directory and installs all the modules listed under `dependencies` and `devDependencies`. The installed modules will be placed in a folder named `node_modules` in your project directory.

Remember, you need to have Node.js and npm installed on your machine to run this command. If they're not installed, you can download Node.js (which includes npm) from the [official website](https://nodejs.org/).

3. **Start the application**: Run the following command in your terminal:

    ```bash
    npm start
    ```

    This command starts the application. You should see output in your terminal indicating that the application is running.

4. **Access the application**: Open your web browser and navigate to the URL where your application is running (`http://localhost:3000`).
