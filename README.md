A library and container help run Janet programs in AWS Lambda

Usage
=====

Use the `lambda` library to define a handler
--------------------------------------------

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
 :name "bootstrap"
 :description "My Lambda Function"
 :dependencies ["https://git.sr.ht/~icylisper/janet-lambda-runtime"])

(declare-executable
 :name "bootstrap"
 :source ["main.janet"]
 :entry "main.janet")

```

Make sure that the executable is named `bootstrap`. Also see example/
for how to use the lambda library

Building the Executable on AmazonLinux
--------------------------------------

`janet-lambda-builder` Docker image is a wrapper around AmazonLinux 2 -
it installs the specified Janet version and generates a
dynamically-linked executable that can run as a Lambda with no missing
dependencies.

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

And finally

``` {.bash}
aws lambda invoke \
    --function-name my-function \
    --payload '{ "name": "Bob" }' \
    response.json
```
