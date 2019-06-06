# Zero trust service mesh with Envoy, Calico and Spire

This original demo was initially given at Kubecon EU 2019 in Barcelona. This is a modified version of the demo with main changes:

* Microk8s instead of Minikube for local deployment
* Use of local PV provisioning feature of K8s v1.14
* Kustomize for deployment instead of pure kubectl

To setup a fresh new environment in MacOS you can run the script env-bootstrap.sh.

After the environment is setup, the stack is deployed by running  the script apply-all-but-policy.sh. 

Then by running the robthebank.sh script you can execute a series of commands that will output the database data.

To apply the policy you can execute the apply-policy.sh script.

Finally, rerunning the robthebank.sh will return the expected denied replies from Envoy.

To tear the deployments down, use the teardown-demo.sh script and to decommission the complete environment you can execute the env-down.sh script.