# Název namespace
namespace="dev"

# Vytvoří namespace
kubectl create namespace $namespace

# Příkaz k tvorbě podů
create_pod_command="kubectl create pod --image=registry.k8s.io/e2e-test-images/agnhost:2.39"

for i in {1..50}; do
  pod_name="hello-node-$i"
  cpu_limit="200m"
  if [ $i -le 20 ]; then
      # Definuje pody v YAML
  read -r -d '' POD_DEFINITION <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
  labels:
    app: test_nepouzivat
spec:
  containers:
  - name: agnhost
    image: registry.k8s.io/e2e-test-images/agnhost:2.39
    resources:
      limits:
        cpu: $cpu_limit
    env:
    - name: COMPlus
      value: "1"
    - name: COMPlus
      value: "2"
EOF

    # Vytvoří pody s kubectl
    echo "$POD_DEFINITION" | kubectl create -f -
  else
      # Definuje pody v YAML
  read -r -d '' POD_DEFINITION <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
spec:
  containers:
  - name: agnhost
    image: registry.k8s.io/e2e-test-images/agnhost:2.39
    resources:
      limits:
        cpu: $cpu_limit
    env:
    - name: COMPlus
      value: "2"
EOF

    # Vytvoří pody s kubectl
    echo "$POD_DEFINITION" | kubectl create -f -
  fi
done

# Zobrazení výpisu podů s jejich stavem
kubectl get pods -n $namespace
