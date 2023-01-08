REPO=chat-socket
TIMESTAMP=tmp-$(shell date +%s )
IFILE=chat-socket-ingress.yml
CFILE=chat-socket-config.yml
VERSION=v1
TEST_PATH=Documents/projects/microservices-chat-app/chat-socket

.PHONY: delete
delete:
		kubectl delete -n $(NSPACE) ingress $(REPO)
		kubectl delete -n $(NSPACE) configmap $(REPO)

.PHONY: create
create:
		kubectl create -f $(IFILE) -n $(NSPACE)
		kubectl create -f $(CFILE) -n $(NSPACE)

.PHONY: remote
remote:
		rsync -Pva --exclude build --exclude=".*" --exclude="*.iml" --delete . $(REMOTE_SERVER):$(TEST_PATH)
		ssh -t -l $(REMOTE_USER) $(REMOTE_SERVER) "cd ${TEST_PATH} ; bash --login" < /dev/tty
