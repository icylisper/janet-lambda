(declare-project
 :name "lambda"
 :description "Janet Lambda Runtime"
 :author "icylisper"
 :license "MIT"
 :dependencies
   ["https://github.com/janet-lang/json.git"
    "https://github.com/joy-framework/http.git"])

(declare-source
 :name "lambda"
 :source ["lambda.janet"])
