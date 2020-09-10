default: lambda

WORK_DIR=/build
JANET_DIR=janet

lambda:
	docker run \
		--rm \
		-e JANET_PATH=/build/janet \
		-e JANET_VERSION=v1.12.1 \
		--volume $(shell pwd)/:/build \
		--workdir $(WORK_DIR) \
		--network host \
		icylisper/janet-lambda-builder:0.1.1
	zip -9r lambda.zip bootstrap

test:
	docker run --rm \
		-v $(shell pwd):/var/task \
		lambci/lambda:provided handler '{"some": "event"}'

clean:
	sudo rm -f *.zip
	sudo rm -rf janet
	sudo rm -rf build bootstrap

install:
	aws lambda update-function-code --function-name jlr --zip-file fileb://lambda.zip
