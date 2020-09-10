(declare-project
 :name "bootstrap"
 :description "Janet Lambda Runtime"
 :author "icylisper"
 :license "MIT"
 :dependencies ["https://git.sr.ht/~icylisper/janet-lambda-runtime"])

(declare-executable
 :name "bootstrap"
 :source ["main.janet"]
 :entry "main.janet")
