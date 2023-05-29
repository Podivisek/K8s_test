# K8s_test
Vypracované zadání tech challenge

Úkol 1.
 
- Co je to Kubernetes (K8s) a proč se používá?
- Architektura Kubernetes:
- Znalost základních komponent Kubernetes jako jsou pods, services, deployments, replica sets.
- Vysvětlení rozdělení na master a worker nodes.
- Kubectl:
- Základní příkazy kubectl pro správu a interakci s Kubernetes clusterem. Vysvětlete a ukažte, jak se používá.
- Konfigurační soubory:
- Jak napsat a používat konfigurační soubory v YAML pro vytváření a aktualizaci zdrojů v Kubernetes.
- Services a Networking:
- Jak Kubernetes provádí networking mezi pody a jak vytvářet a používat služby pro umožnění komunikace mezi pody a s vnějším světem.


Úkol 2.

Vaším úkolem je vytvořit testovací prostředí a provést následující kroky:
- Vytvořte Kubernetes orchestrátor obsahující 50 podů v namespace "dev".
- Vytvořte skript (vyberte si libovolný script jazyk), který provede následující úkoly:
 - Nastaví proměnnou env:COMPlus = 1 u všech podů, které obsahují label app=test_nepouzivat.
 - Nastaví proměnnou env:COMPlus = 2 u všech 50 podů.
 - Nastaví limit CPU na 200m pro všechny 50 podů.
 - Zobrazí výpis podů s jejich stavem
 - Dokážete navrhnout řešení pro nastavení omezení na úrovni celého namespace?
 
Pomoc pro vytvoření testovacího prostředí pro splnění úkolu:
- Nejjednodušší je vytvořit virtuální server s Ubuntu 22.06 a při instalaci povolit instalaci MicroK8s.
- Vytvořte konfiguraci pro kubectl pomocí příkazu "microk8s config > ~/.kube/config".
- Povolte DNS v MicroK8s pomocí příkazu "microk8s enable dns".
- Ve vytvořeném clusteru vytvořte namespace "dev".
- Použijte příkaz (například "microk8s kubectl create deployment hello-node --image=registry.k8s.io/e2e-test-images/agnhost:2.39") k vytvoření šablony ("deployment") s názvem "hello-node" a obrazem "registry.k8s.io/e2e-test-images/agnhost:2.39".
- Zopakujte tento krok 50krát, přičemž každým opakováním použijte jiný název pro šablonu, například "hello-node-(1-100)".
- Přiřaďte 20 podům libovolně label "app=test_nepouzivat".
