# GitOps App Repository

## About This Flask App

This is a **Flask** application that runs on **port 5000** by default. Flask's default port is 5000, which is why we use it.

**Important:** 
- This Flask app runs on **port 5000**
- If you see Django errors on port 8000, that's a **different container** (`runtesting/gitops-app`) running a Django app
- To stop the Django container: `docker stop gitops-app`
- This Flask app is separate and should run on port 5000

## Docker Build and Push

### Quick Commands

Replace `your-dockerhub-username` with your actual Docker Hub username:

```bash
# 1. Build the image
docker build -t gitops-app:latest .

# 2. Tag for Docker Hub
docker tag gitops-app:latest your-dockerhub-username/gitops-app:latest

# 3. Run locally on port 5000 (Flask default)
docker run -d --name gitops-app-local -p 5000:5000 gitops-app:latest

# 4. Login to Docker Hub (if not already logged in)
docker login

# 5. Push to Docker Hub
docker push your-dockerhub-username/gitops-app:latest
```

### Run on a Different Port (Optional)

If you need to run on a different port (e.g., 8000), you can map it:

```bash
# Run on port 8000 instead (maps host port 8000 to container port 5000)
docker run -d --name gitops-app-local -p 8000:5000 gitops-app:latest
# Then access at http://localhost:8000
```

### Quick Run Script (Flask App Only)

```bash
# Simple script to build and run the Flask app
./run-flask.sh

# Or specify a different port
./run-flask.sh 8000
```

### Using the Build Script

```bash
# Make sure you're in the app-repo directory
cd app-repo

# Run the script (replace with your Docker Hub username)
./build-and-push.sh your-dockerhub-username gitops-app latest

# Or with default values (you'll need to edit the script for username)
./build-and-push.sh
```

### Access the Local Container

- **URL**: http://localhost:5000
- **Stop container**: `docker stop gitops-app-local`
- **View logs**: `docker logs gitops-app-local`
- **Remove container**: `docker rm gitops-app-local`

### Test the Application

```bash
# Test on port 5000 (default)
curl http://localhost:5000
# Should return: "Hello from GitOps + ArgoCD!"

# Test health endpoint
curl http://localhost:5000/health
# Should return: {"status": "healthy"}
```

### Troubleshooting

**Issue: Port 5000 not working**
- Check if port 5000 is already in use: `lsof -i :5000` or `netstat -an | grep 5000`
- Stop any conflicting containers: `docker ps` then `docker stop <container-id>`
- Try a different port: `docker run -d --name gitops-app-local -p 8000:5000 gitops-app:latest`

**Issue: Django errors on port 8000**
- You have a different container (`gitops-app`) running a Django app on port 8000
- This is NOT the Flask app - it's a separate application
- To stop it: `docker stop gitops-app`
- This Flask app should run on port 5000
- Check what's running: `docker ps`

**Issue: Container won't start**
- Check logs: `docker logs gitops-app-local`
- Rebuild the image: `docker build -t gitops-app:latest .`
- Make sure Flask is installed: `pip install flask`

