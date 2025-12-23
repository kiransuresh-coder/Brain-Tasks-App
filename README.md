# Brain Tasks App – CI/CD on AWS EKS

This repository demonstrates an **end-to-end CI/CD pipeline** to build, containerize, and deploy application (**Brain Tasks App**) on **Amazon EKS** using **AWS CodePipeline, CodeBuild, Amazon ECR, Kubernetes, and CloudWatch**.

---

## 🛠️ Tech Stack

* **Cloud**: AWS
* **Containerization**: Docker
* **Orchestration**: Kubernetes (EKS)
* **CI/CD**: AWS CodePipeline, AWS CodeBuild
* **Container Registry**: Amazon ECR
* **Logging & Monitoring**: Amazon CloudWatch

---
## 🚀 Steps

### 1. Clone the Repository
```bash
git clone https://github.com/Vennilavan12/Brain-Tasks-App.git
cd Brain-Tasks-App
```

### 2. Build Docker Image
Build the app Docker image served by Nginx:
```bash
docker build -t brain-tasks-app .
```

### 3. Run Locally
Run the Docker container locally to verify:
```bash
docker run --rm -p 3000:3000 brain-tasks-app:local
```
Access the app at: [http://localhost:3000](http://localhost:3000)

---

### 4. Push to Amazon ECR
**Create ECR repository:**
```bash
aws ecr create-repository --repository-name brain-tasks-app --region us-east-1
```

**Authenticate Docker to ECR and tag image:**
```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 085165114613.dkr.ecr.us-east-1.amazonaws.com

docker tag docker tag brain-tasks-app:v1 \ 085165114613.dkr.ecr.us-east-1.amazonaws.com/brain-tasks-app:v1
```

**Push image:**
```bash
docker push 085165114613.dkr.ecr.us-east-1.amazonaws.com/brain-tasks-app:v1
```

---

### 5. Deploy to Amazon EKS
**Create EKS cluster:**
```bash
eksctl create cluster --name brain-task-cluster --region us-east-1 --nodes 2 --node-type t3.medium
```

**Update kubeconfig:**
```bash
aws eks update-kubeconfig --region us-east-1 --name brain-task-cluster
```

---

### 6. CI/CD Pipeline
- The pipeline uses **AWS CodeBuild** and **CodePipeline** to automate build and deployment.
- `buildspec.yaml` handles Docker build, tag, and push to ECR.
- CodePipeline triggers build and deploy steps.

---

### 7. IAM & Access
- Ensure CodePipeline/CodeBuild IAM roles have access to EKS.
- Modify `aws-auth` ConfigMap if needed to add roles with `system:masters` group.

---

### 8. Monitoring & Verification
Use **CloudWatch Logs** to monitor pipeline and build logs.


```

**Verify service:**
```bash
kubectl get svc brain-tasks-service
```

---

## ✅ Outcome
- Application is deployed on **Amazon EKS** and accessible via **LoadBalancer**.
- Pipeline automates build and deployment.
- Logs and status visible in **AWS CloudWatch**.

---

## 📝 Additional Notes
- The app is served on **port 3000** via Nginx.
- Kubernetes service maps **port 80 → container port 3000**.
- `appspec.yaml` is not required unless using **CodeDeploy lifecycle hooks**.


---



