# hello-argo

Java hello world (JDK `HttpServer`, no dependencies) packaged as a container, a Helm chart, and an Argo CD Application.

```
src/            Java app  (GET / -> greeting, GET /healthz -> ok)
Dockerfile      multi-stage build
helm/hello-argo Helm chart
argocd/         Argo CD Application manifest
```

## Build and run locally
```
mvn package && java -jar target/hello-argo.jar      # http://localhost:8080
docker build -t hello-argo:0.1.0 .
```

## Deploy with Argo CD
1. Push this project to a git repo Argo CD can read, and set `repoURL` in `argocd/application.yaml`.
2. Make the image available to the cluster:
   - Docker Desktop Kubernetes: the local image is used as-is (`pullPolicy: IfNotPresent`).
   - kind: `kind load docker-image hello-argo:0.1.0`; minikube: `minikube image load hello-argo:0.1.0`.
   - Remote cluster: push to a registry and set `image.repository` / `image.tag` in `helm/hello-argo/values.yaml`.
3. `kubectl apply -n argocd -f argocd/application.yaml`
4. Check: `kubectl -n hello-argo port-forward svc/hello-argo 8081:80` then open http://localhost:8081
