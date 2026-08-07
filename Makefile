# Build and start with Docker (original)
start:
	docker build -f Dockerfile --target "prod" . -t "cardconjurer-client" && docker run -dit -h 127.0.0.1 -p 4242:4242 "cardconjurer-client"

# Build Docker image only
build:
	docker build -f Dockerfile --target "prod" . -t "cardconjurer-client"

# Run locally without Docker (uses Python or Node.js)
run-local:
	bash run.sh
