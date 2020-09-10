
docker:
	docker build -t icylisper/janet-lambda-builder .

push:
	docker tag icylisper/janet-lambda-builder icylisper/janet-lambda-builder:0.1.1
	docker push icylisper/janet-lambda-builder:0.1.1

example: .
	cd example && make

doc:
	pandoc README.org -o README.md
