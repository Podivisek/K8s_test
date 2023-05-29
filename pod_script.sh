# Název namespace
namespace="dev"

# Vytvoří namespace
kubectl create namespace $namespace

# Příkaz k tvorbě podů
create_pod_command="kubectl create pod --image=registry.k8s.io/e2e-test-images/agnhost:2.39"

# Vytvoří 50 deployments
for i in {1..50}; do
    pod_name="hello-node-$i"

  # Definuje pody v YAML
  read -r -d '' POD_DEFINITION <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
spec:
  containers:
  - name: agnhost
    image: registry.k8s.io/e2e-test-images/agnhost:2.39
EOF

    # Vytvoří pody s kubectl
    echo "$POD_DEFINITION" | kubectl create -f -
done

# Nastaví label k 20 podům
for i in {1..20}; do
    pod_name="hello-node-$i"
    # Přídá labels k podům
    kubectl label pod "$pod_name" app=test_nepouzivat --overwrite
done

# Nastavení proměnné env:COMPlus = 2 u všech 50 podů
kubectl set env pod --all COMPlus=2 -n $namespace

# Nastavení limitu CPU na 200m pro všechny 50 podů
kubectl set resources pod --all --limits=cpu=200m -n $namespace

# Nastavení proměnné env:COMPlus = 1 u podů s labellem app=test_nepouzivat
kubectl set env pod -l app=test_nepouzivat COMPlus=1 -n $namespace

# Command změní nastavení omezení zdrojů na úrovni celého namespace ve všech podech
kubectl apply -f resource-quota.yaml

# Zobrazení výpisu podů s jejich stavem
kubectl get pods -n $namespace
