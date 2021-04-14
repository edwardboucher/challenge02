git clone https://github.com/nginxinc/kubernetes-ingress/
cd kubernetes-ingress/deployments/helm-chart
git checkout v1.10.0
helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
#nstall NGINX:
helm install my-release nginx-stable/nginx-ingress
#Install NGINX Plus: (assuming you have pushed the Ingress controller image nginx-plus-ingress to your private registry myregistry.example.com)
helm install my-release nginx-stable/nginx-ingress --set controller.image.repository=myregistry.example.com/nginx-plus-ingress --set controller.nginxplus=true
#Add ExternalIP
EXT_IP=$(curl -4 icanhazip.com)
SPEC=$(echo "'{"spec": {"type": "LoadBalancer", "externalIPs":($EXT_IP)}}'")
#kubectl patch svc my-release-nginx-ingress -n default -p ${SPEC}
kubectl edit svc my-release-nginx-ingress -n default