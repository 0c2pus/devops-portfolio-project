# GitOps & DevOps: From Code to Kubernetes on macOS

[![CI Pipeline Status](https://github.com/0c2pus/devops-portfolio-project/actions/workflows/ci.yml/badge.svg)](https://github.com/0c2pus/devops-portfolio-project/actions/workflows/ci.yml)
[![Docker Image Version (Backend)](https://img.shields.io/docker/v/ocu2pu5/devops-portfolio-backend?label=backend&logo=docker)](https://hub.docker.com/r/ocu2pu5/devops-portfolio-backend)
[![Docker Image Version (Frontend)](https://img.shields.io/docker/v/ocu2pu5/devops-portfolio-frontend?label=frontend&logo=docker)](https://hub.docker.com/r/ocu2pu5/devops-portfolio-frontend)
[![GitHub license](https://img.shields.io/github/license/0c2pus/devops-portfolio-project)](https://github.com/0c2pus/devops-portfolio-project/blob/main/LICENSE)

**Complete implementation of a DevOps pipeline for a web application using modern practices: CI/CD, Infrastructure as Code, Kubernetes, and GitOps, tailored for a local development environment.**

## Project Overview

This project demonstrates the full deployment cycle of a cloud-native application (Todo App) using a modern DevOps stack. The goal is to create a reliable, automated, and secure pipeline from code to production without relying on paid cloud services. This setup is perfect for local development and portfolio demonstration on a macOS environment.

**Author:** [0c2pus](https://github.com/0c2pus)  
**Repository:** https://github.com/0c2pus/devops-portfolio-project  
**Live Demo:** http://localhost:30080 (Kubernetes) | http://your-vm-ip (VM deployment)

---

## System Architecture

_The architecture is designed to be self-contained and free, leveraging local virtualization and containerization tools on macOS._

### Infrastructure Evolution

```bash
Stage 1-3: Mac → GitHub Actions → DockerHub → Ansible → VM (Docker Compose)
Stage 4:   Mac → GitHub Actions → DockerHub → ArgoCD → Kubernetes (Helm)
```

### Key Components

1. **Source Code:** GitHub repository with GitFlow branching strategy
2. **CI/CD:** GitHub Actions for building, testing, and scanning images
3. **Image Registry:** DockerHub with multi-architecture support (AMD64/ARM64)
4. **Local Infrastructure:** Kind Kubernetes cluster on Docker Desktop
5. **Infrastructure as Code:** Ansible for VM provisioning, Helm for Kubernetes
6. **Containerization:** Docker with multi-stage builds and security scanning
7. **Orchestration:** Kubernetes with resource management and health monitoring
8. **GitOps:** ArgoCD for automated deployments from Git
9. **Monitoring:** Prometheus/Grafana stack for observability

---

## Technology Stack

| Category | Technologies |
|-----------|------------|
| **Local Environment** | macOS, UTM (Ubuntu Server VM), Docker Desktop |
| **Infrastructure as Code** | Ansible, Helm |
| **CI/CD** | GitHub Actions, Hadolint, Trivy |
| **Containers** | Docker, Docker Compose |
| **Orchestration & GitOps** | Kubernetes (Kind), Helm, ArgoCD |
| **Monitoring** | Prometheus, Grafana |
| **Web Servers** | Nginx (Reverse Proxy) |
| **Programming** | Node.js (Express), React (Vite) |
| **Database** | SQLite |
| **Version Control** | Git, GitHub |
| **Image Registry** | DockerHub |

---

## Repository Structure

```
devops-portfolio-project/
├── infrastructure/
│   ├── ansible/
│   │   ├── inventory.ini           # Server inventory and variables
│   │   ├── requirements.yml        # Ansible collections
│   │   └── setup-vm.yml            # Complete VM provisioning playbook
│   └── k8s/
│       ├── argocd-application.yaml # ArgoCD Application manifest
│       ├── portfolio-app/          # Helm chart for application
│       │   ├── Chart.yaml
│       │   ├── values.yaml
│       │   └── templates/          # Kubernetes manifests
│       │       ├── _helpers.tpl
│       │       ├── backend-*.yaml
│       │       ├── frontend-*.yaml
│       │       ├── nginx-*.yaml
│       │       └── ingress.yaml
│       └── monitoring/
│           ├── portfolio-servicemonitor.yaml
│           └── prometheus-values.yaml
├── .github/
│   └── workflows/
│       └── ci.yml                  # CI/CD Pipeline with multi-arch build
├── app/
│   ├── backend/                    # Node.js API server
│   │   ├── src/
│   │   ├── Dockerfile              # Multi-stage production build
│   │   ├── healthcheck.js          # Container health check script
│   │   └── package.json
│   └── frontend/                   # React client
│       ├── src/
│       ├── Dockerfile              # Multi-stage with Nginx
│       ├── nginx.conf              # Frontend Nginx configuration
│       └── package.json
├── nginx/                          # Reverse proxy configuration
│   ├── nginx.conf
│   └── default.conf
├── docker-compose.yml              # Development orchestration
├── docker-compose.prod.yml         # Production orchestration
└── README.md
```

---

## Current Status

### ✅ Stage 0: Preparation (Completed)
- [x] Created public GitHub repository
- [x] Initialized folder structure with GitFlow workflow
- [x] Added base application code (Node.js backend + React frontend)
- [x] Configured `main` and `develop` branches

### ✅ Stage 1: Manual VM Setup and Docker Deployment (Completed)
- [x] VM Configuration: Ubuntu Server 22.04 LTS in UTM with bridged networking
- [x] SSH Access: Passwordless SSH connection from macOS to VM
- [x] Docker Installation: Docker CE and Docker Compose on VM
- [x] Application Containerization:
    + Multi-stage Dockerfile for React frontend with Nginx (port 80)
    + Optimized Node.js backend Dockerfile with security best practices
    + Health checks for all services
- [x] Reverse Proxy Setup: Nginx with load balancing, security headers, rate limiting
- [x] Multi-Container Architecture: Docker Compose with resource limits and health monitoring
- [x] Production Deployment: Full-stack application accessible via VM IP

### ✅ Stage 2: Build and Security Automation (CI) (Completed)
- [x] DockerHub Integration: Public repositories with automated publishing
- [x] GitHub Secrets: Secure credential management (`DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`)
- [x] GitHub Actions CI Pipeline:
    + Dockerfile linting with Hadolint
    + Multi-architecture builds (AMD64/ARM64)
    + Container functionality testing
    + Security vulnerability scanning with Trivy
    + SARIF report upload to GitHub Security
- [x] CI/CD Features:
    + Parallel job execution
    + Docker layer caching for faster builds
    + Conditional publishing (only on push to main/develop)
    + Cross-platform compatibility

### ✅ Stage 3: Infrastructure as Code (Ansible) and Deployment Automation (CD) (Completed)
- [x] Ansible Controller Setup: Configured on macOS with community collections
- [x] Infrastructure Automation:
    + Complete VM provisioning from bare Ubuntu Server
    + Multi-architecture support (ARM64/AMD64)
    + Git-based deployment workflow
    + Dynamic environment configuration via inventory
- [x] Production Pipeline:
    + One-command deployment from clean VM to running application
    + Automated Docker GPG key installation
    + Health verification for all containers
    + Idempotent operations
    + Tagged execution for selective deployment
- [x] DevOps Best Practices:
    + Version-controlled infrastructure
    + Immutable infrastructure principles
    + Centralized configuration management
    + End-to-end automated testing

### ✅ Stage 4: Kubernetes and GitOps (Completed)
- [x] Kubernetes Cluster: Kind cluster on Docker Desktop with port mapping
- [x] Helm Chart Development:
    + Comprehensive chart for backend, frontend, and nginx
    + Parameterized configuration with values.yaml
    + Kubernetes-native health checks (liveness/readiness probes)
    + Resource limits and requests for production readiness
    + Correct port configuration (frontend: 80, backend: 8000)
- [x] ArgoCD GitOps:
    + ArgoCD installation in dedicated namespace
    + Application configured to track GitHub repository (main branch)
    + Automatic synchronization enabled (1-3 minutes)
    + Self-healing and pruning configured
    + Declarative Application manifest in Git
- [x] Monitoring Stack:
    + Prometheus Operator for metrics collection
    + Grafana for visualization and dashboards
    + Kubernetes cluster metrics monitoring
    + Resource usage tracking per namespace

**Key Achievements:**
- Complete GitOps workflow: Git → ArgoCD → Kubernetes
- Declarative infrastructure management
- Automated deployment on Git changes
- Production-grade monitoring and observability
- Zero-downtime deployments with rolling updates

---

## Quick Start

### Prerequisites

**Required tools:**
- macOS (Apple Silicon or Intel)
- [Homebrew](https://brew.sh/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [UTM](https://mac.getutm.app/) (for VM deployment)
- Node.js 18+ (for local development)

### Local Development

```bash
# 1. Clone repository
git clone https://github.com/0c2pus/devops-portfolio-project.git
cd devops-portfolio-project

# 2. Start backend
cd app/backend
npm install
npm run dev
# Available at http://localhost:8000

# 3. Start frontend (in new terminal)
cd app/frontend
npm install
npm run dev
# Available at http://localhost:5173
```

### Docker Compose Deployment

```bash
# Development environment
docker compose up -d

# Production environment
docker compose -f docker-compose.prod.yml up -d

# Access application at http://localhost
```

---

## Kubernetes Deployment

### Architecture Overview

```
Git Repository (main branch)
        ↓
    ArgoCD (GitOps Controller)
        ↓
Kubernetes Cluster (Kind)
        ↓
    Helm Chart Deployment
        ├── Backend Pods (2 replicas)
        ├── Frontend Pods (2 replicas)
        └── Nginx Pod (1 replica)
        ↓
    NodePort Service (30080)
        ↓
    http://localhost:30080
```

### Setup Instructions

#### 1. Install Required Tools

```bash
brew install kind kubectl helm
```

#### 2. Create Kind Cluster with Port Mapping

```bash
# Create cluster configuration
cat <<EOF | kind create cluster --name devops-portfolio --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30080
    hostPort: 30080
    protocol: TCP
EOF

# Verify cluster
kubectl cluster-info
kubectl get nodes
```

#### 3. Install ArgoCD

```bash
# Create namespace and install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for ArgoCD to be ready (1-2 minutes)
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s
```

#### 4. Deploy Application via ArgoCD

```bash
# Apply ArgoCD Application manifest
kubectl apply -f infrastructure/k8s/argocd-application.yaml

# Monitor deployment
kubectl get application -n argocd
kubectl get pods -n portfolio -w
# Press Ctrl+C when all pods are Running

# Access application
open http://localhost:30080
```

#### 5. Access ArgoCD UI (Optional)

```bash
# Get admin password
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# Port-forward ArgoCD server
kubectl port-forward svc/argocd-server -n argocd 8080:443 &

# Open ArgoCD UI
open https://localhost:8080
# Login: admin / [password from step 1]
# Ignore SSL warning (self-signed certificate)
```

### GitOps Workflow

1. Make changes in Git repository (`values.yaml` or Helm templates)
2. Commit and push to `main` branch
3. ArgoCD automatically detects changes (1-3 minutes)
4. Application synchronizes to desired state
5. Kubernetes performs rolling updates to running pods

**Example: Change replica count**
```bash
# Edit values.yaml
nano infrastructure/k8s/portfolio-app/values.yaml
# Change backend.replicas: 2 → 3

# Commit and push
git add infrastructure/k8s/portfolio-app/values.yaml
git commit -m "scale: increase backend replicas to 3"
git push origin main

# Monitor automatic deployment
kubectl get pods -n portfolio -l app=portfolio-app-backend -w
```

### Useful Commands

```bash
# View all resources
kubectl get all -n portfolio

# Check application sync status
kubectl get application portfolio-app -n argocd

# View pod logs
kubectl logs -n portfolio -l app=portfolio-app-backend
kubectl logs -n portfolio -l app=portfolio-app-frontend

# Restart deployment
kubectl rollout restart deployment -n portfolio portfolio-app-portfolio-app-backend

# Delete application (for cleanup)
kubectl delete application portfolio-app -n argocd
kubectl delete namespace portfolio
```

---

## Infrastructure as Code with Ansible

### Architecture Overview

```
Mac (Ansible Controller) → SSH → Ubuntu VM (Managed Node) → Docker Containers
```

### Prerequisites

```bash
# Install Ansible
brew install ansible

# Install required collections
ansible-galaxy collection install -r infrastructure/ansible/requirements.yml
```

### VM Setup (UTM)

1. **Download Ubuntu Server ISO:**
   - For Apple Silicon: Ubuntu 22.04 LTS ARM64
   - For Intel: Ubuntu 22.04 LTS AMD64

2. **Create VM in UTM:**
   - RAM: 2GB minimum
   - CPU: 2 cores
   - Disk: 20GB
   - Network: Bridged mode (for direct access from Mac)

3. **Install Ubuntu Server:**
   - Create user: `deployer`
   - Install OpenSSH server
   - Note the VM IP address

4. **Setup SSH Access:**
   ```bash
   # Copy SSH key to VM
   ssh-copy-id deployer@<VM_IP>
   
   # Test connection
   ssh deployer@<VM_IP>
   ```

5. **Update Inventory:**
   Edit `infrastructure/ansible/inventory.ini` with your VM IP:
   ```ini
   [dev-server]
   ubuntu-server ansible_host=<YOUR_VM_IP>
   ```

### Deployment

```bash
# Full deployment (Docker installation + application)
ansible-playbook -i infrastructure/ansible/inventory.ini infrastructure/ansible/setup-vm.yml

# Docker setup only
ansible-playbook -i infrastructure/ansible/inventory.ini infrastructure/ansible/setup-vm.yml --tags docker

# Application deployment only
ansible-playbook -i infrastructure/ansible/inventory.ini infrastructure/ansible/setup-vm.yml --tags deploy

# Verification only
ansible-playbook -i infrastructure/ansible/inventory.ini infrastructure/ansible/setup-vm.yml --tags verify
```

### Key Features

- ✅ Multi-architecture support (ARM64/AMD64)
- ✅ Dynamic configuration via inventory
- ✅ Automated health verification
- ✅ Error recovery with retry logic
- ✅ Modular execution with tags
- ✅ Idempotent operations

### Verification

After deployment, verify the application:

```bash
# Check containers on VM
ssh deployer@<VM_IP> "docker ps"

# Test backend API
curl http://<VM_IP>/api/greeting

# Test frontend
open http://<VM_IP>
```

---

## CI/CD Pipeline Details

### Workflow Triggers

- **Push to main/develop:** Full pipeline with DockerHub publishing
- **Pull Requests to main:** Build, test, and scan without publishing
- **Manual dispatch:** On-demand pipeline execution

### Pipeline Stages

#### 1. Lint Dockerfiles
- Hadolint validation for both frontend and backend
- Best practices enforcement
- Security and optimization checks
- Ignores: DL3008, DL3009, DL3018, DL3059

#### 2. Build, Test, and Scan
- Multi-architecture builds (AMD64 + ARM64)
- Docker Buildx with layer caching
- Container functionality tests:
  - Backend: Health check on `/api/greeting`
  - Frontend: HTTP 200 response on root path
- Trivy vulnerability scanning (CRITICAL + HIGH)
- SARIF reports uploaded to GitHub Security

#### 3. Publish to Registry
- Multi-architecture manifests
- Multi-tag strategy:
  - Branch name (e.g., `main`, `develop`)
  - Git SHA (e.g., `main-abc123`)
  - `latest` (only for default branch)
- Conditional publishing (skipped for PRs)

### Security Features

- ✅ Automated vulnerability scanning on every commit
- ✅ SARIF reports in GitHub Security tab
- ✅ Risk-assessed vulnerability management
- ✅ Token-based authentication with minimal permissions
- ✅ No secrets in code (GitHub Secrets)

### GitHub Secrets Configuration

Required secrets in repository settings:
- `DOCKERHUB_USERNAME`: Your DockerHub username
- `DOCKERHUB_TOKEN`: DockerHub access token (not password!)

---

## Monitoring and Observability

### Prometheus/Grafana Stack

#### Installation

```bash
# Add Prometheus Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install Prometheus stack
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --values infrastructure/k8s/monitoring/prometheus-values.yaml

# Wait for pods to be ready (2-3 minutes)
kubectl get pods -n monitoring -w
```

#### Access Dashboards

```bash
# Grafana (default credentials: admin/prom-operator)
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80 &

# Get Grafana password
kubectl get secret -n monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d; echo

# Prometheus
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090 &

# Open in browser
open http://localhost:3000  # Grafana
open http://localhost:9090  # Prometheus
```

#### Available Metrics

- Kubernetes cluster resource usage
- Pod CPU and memory consumption
- Network I/O statistics
- Application health status
- Container restart count
- Node metrics

---

## Project Demonstrations

### Stage 0: Local Development

<details>
<summary>View Screenshots</summary>

![Local Application Running](docs/images/stage-0/app-running.png)
*Todo application running locally with Node.js backend and React frontend*

</details>

---

### Stage 1: Production Deployment on VM

<details>
<summary>View Screenshots</summary>

![Full-stack Application Running](docs/images/stage-1/app-running.png)
*Full-stack application deployed on Ubuntu VM with Docker containers*

![Services Running](docs/images/stage-1/app-running-docker.png)
*All services running with health checks in Docker Compose*

</details>

---

### Stage 2: CI/CD Pipeline

<details>
<summary>View Screenshots</summary>

![GitHub Actions Workflow](docs/images/stage-2/run-jobs.png)
*GitHub Actions workflow run showing all jobs (Lint, Build/Test/Scan, Publish) with green checkmarks*

![DockerHub Repositories](docs/images/stage-2/images.png)
*DockerHub repositories showing published images with multiple tags (main, develop, SHA tags)*

![GitHub Security](docs/images/stage-2/code-scanning.png)
*GitHub Security tab displaying Trivy scan results with vulnerability reports for both containers*

</details>

---

### Stage 3: Infrastructure as Code

<details>
<summary>View Screenshots</summary>

![Ansible Playbook Success](docs/images/stage-3/ansible-playbook.png)
*Ansible playbook execution showing successful completion with task summary and final verification*

![Browser Verification](docs/images/stage-3/browser-verification.png)
*Terminal showing one-command deployment followed by successful API test and browser verification*

</details>

---

### Stage 4: Kubernetes and GitOps

<details>
<summary>View Screenshots</summary>

![ArgoCD UI](docs/images/stage-4/argocd-ui.png)
*ArgoCD UI showing portfolio-app with "Synced" and "Healthy" status, displaying all Kubernetes resources*

![Kubernetes Running Pods](docs/images/stage-4/running-pods.png)
*kubectl get pods output showing all running pods in portfolio namespace*

![Grafana Dashboard](docs/images/stage-4/grafana-dashboard.png)
*Grafana dashboard showing Kubernetes cluster metrics for portfolio namespace*

</details>

---

## Known Security Issues

This section demonstrates production-ready vulnerability management practices.

### Container Base Images

**libxml2, libcrypto, libssl CVEs (High):** Alpine Linux upstream vulnerabilities
- **Status:** Monitoring for Alpine security updates
- **Impact:** No direct application functionality affected
- **Mitigation:** 
  - Network isolation via Kubernetes NetworkPolicies
  - Security headers in Nginx configuration
  - Regular image updates via CI/CD pipeline
  - Container runtime security with non-root users

### Application Dependencies

**cross-spawn ReDoS (High):** Regular expression denial of service potential
- **Status:** Risk accepted - low exploitability in containerized environment
- **Mitigation:** 
  - Resource limits in Kubernetes
  - Request timeout configurations
  - Rate limiting in Nginx

**brace-expansion (Low):** Minor dependency vulnerability
- **Status:** Monitoring for package maintainer updates
- **Impact:** Minimal - affects build tools only

### Security Approach

Our comprehensive security strategy includes:

- ✅ Continuous automated scanning on every commit
- ✅ Risk assessment based on business impact and exploitability
- ✅ Prioritized remediation by severity and attack surface
- ✅ Complete audit trail in GitHub Security tab
- ✅ Defense in depth: multiple security layers
- ✅ Regular dependency updates via Dependabot

**View full vulnerability report:** [GitHub Security Tab](https://github.com/0c2pus/devops-portfolio-project/security)

---

## Troubleshooting

### Common Issues

<details>
<summary><b>Kind cluster port 30080 not accessible</b></summary>

**Cause:** Kind cluster created without port mapping

**Solution:**
```bash
# Delete and recreate cluster with port mapping
kind delete cluster --name devops-portfolio

# Create with configuration
cat <<EOF | kind create cluster --name devops-portfolio --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30080
    hostPort: 30080
    protocol: TCP
EOF
```

**Alternative:** Use port-forward
```bash
kubectl port-forward -n portfolio svc/portfolio-app-portfolio-app-nginx 8081:80
open http://localhost:8081
```
</details>

<details>
<summary><b>ArgoCD application stuck in "Progressing"</b></summary>

**Cause:** Slow image pull or insufficient resources

**Solution:**
```bash
# Check pod status
kubectl describe pods -n portfolio

# Force sync
kubectl patch application portfolio-app -n argocd --type merge \
  -p '{"operation":{"initiatedBy":{"username":"admin"},"sync":{"revision":"HEAD"}}}'

# Check ArgoCD logs
kubectl logs -n argocd -l app.kubernetes.io/name=argocd-application-controller
```
</details>

<details>
<summary><b>Ansible playbook fails on Docker installation</b></summary>

**Cause:** GPG key import issues or repository configuration

**Solution:**
```bash
# Clean up on VM
ssh deployer@<VM_IP> "sudo rm -f /etc/apt/sources.list.d/docker.list /etc/apt/keyrings/docker.*"

# Run playbook again
ansible-playbook -i infrastructure/ansible/inventory.ini infrastructure/ansible/setup-vm.yml
```
</details>

<details>
<summary><b>Frontend shows 502 Bad Gateway</b></summary>

**Cause:** Nginx upstream configuration mismatch with container ports

**Solution:**
Verify `nginx/default.conf` has correct upstream ports:
```nginx
upstream frontend_upstream {
    server frontend:80 max_fails=3 fail_timeout=30s;
}
```

Restart nginx:
```bash
# On VM
ssh deployer@<VM_IP> "cd /opt/portfolio && docker compose -f docker-compose.prod.yml restart nginx"

# In Kubernetes
kubectl rollout restart deployment -n portfolio portfolio-app-portfolio-app-nginx
```
</details>

---

## Project Roadmap

- [x] **Stage 0:** Repository preparation and base code
- [x] **Stage 1:** Manual VM deployment with Docker Compose
- [x] **Stage 2:** CI/CD automation with GitHub Actions
- [x] **Stage 3:** Infrastructure as Code with Ansible
- [x] **Stage 4:** Kubernetes orchestration and GitOps with ArgoCD

### Future Enhancements (Optional)

- [ ] HTTPS with Let's Encrypt certificates
- [ ] Multi-cluster deployment
- [ ] Automated backup and disaster recovery
- [ ] Performance testing with K6
- [ ] Service mesh with Istio
- [ ] Advanced monitoring with Jaeger tracing

---

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Ansible Documentation](https://docs.ansible.com/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

---

## Contact

**Author:** [0c2pus](https://github.com/0c2pus)  
**Repository:** https://github.com/0c2pus/devops-portfolio-project  
**Issues:** https://github.com/0c2pus/devops-portfolio-project/issues

---

**⭐ If you found this project helpful, please consider giving it a star!**