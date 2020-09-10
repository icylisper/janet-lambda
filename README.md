A library to help run Janet programs or scripts in AWS Lambda

Usage
=====

Use the `lambda` library to define a
------------------------------------

See example/ for how to use the lambda library

`main.janet`

``` {.janet}
(import lambda)

(defn hello [event]
  {:hello "world" :event event})

(defn main [& args]
  (if (lambda/rapi)
    (lambda/start-event-loop hello)
    (print {:hello :test}))

```

`project.janet`

``` {.janet}
(declare-project
 :name "server"
 :description "My Lambda Function"
 :dependencies ["https://git.sr.ht/~icylisper/janet-lambda-runtime"])

(declare-executable
 :name "server"
 :source ["main.janet"]
 :entry "main.janet")

```

Building the Executable on AmazonLinux
--------------------------------------

We build the dynamically-linked executable on a AmazonLinux base docker
image. `janet-lambda-builder` image installs the specified Janet version
and compiles the code in the current directly inside the Docker
container.

``` {.bash}

docker run --rm \
   -e JANET_PATH=/build/janet -e JANET_VERSION=v1.12.1 \
   --volume $(shell pwd)/:/build --workdir /build \
   --network host \
   icylisper/janet-lambda-builder

```

The above generates an executable called `bootstrap` in the current
directory.

Deploying the Lambda
--------------------

``` {.bash}
zip -9r lambda.zip bootstrap

aws lambda create-function
    --function-name my-function \
    --runtime provided.al2 \
    --handler handler \
    --role my-role-arn \
    --zip-file fileb://lambda.zip
```

To test

``` {.bash}
aws lambda invoke \
    --function-name my-function \
    --payload '{ "name": "Bob" }' \
    response.json
```
