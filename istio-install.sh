
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.3 sudo sh -
# curl -L https://istio.io/downloadIstio | sh -

ISTIO_FOLDER=$( ls -1 | grep istio )
sudo chown ubuntu: ${ISTIO_FOLDER}
cd ${ISTIO_FOLDER}

for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done

kubectl api-resources | grep istio 2>&1
kubectl get crd | grep istio 2>&1

kubectl apply -f install/kubernetes/istio-demo.yaml
echo -e "\n\n# kubectl get svc -n istio-system\n# kubectl get pods -n istio-system\n\n"

kubectl label namespace default istio-injection=enabled
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
