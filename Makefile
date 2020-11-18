setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)

tf-fmt-check:
	terraform fmt -recursive -check

tf-fmt:
	terraform fmt -recursive

k8s-save-kubeconfig:
	(cd k8s && terraform output kubeconfig > kubeconfig.yml)

k8s-add-kubeconfig:
	cp ~/.kube/config ~/.kube/config.$$(date +%Y-%m-%d_%H-%M-%S).backup
	KUBECONFIG=k8s/kubeconfig.yml:~/.kube/config kubectl config view --raw > /tmp/kubeconfig.merge.yml && cp /tmp/kubeconfig.merge.yml ~/.kube/config
