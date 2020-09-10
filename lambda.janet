(import http)
(import json)

(defn rapi []
  (os/getenv "AWS_LAMBDA_RUNTIME_API"))

(defn make-url [path]
  (string "http://" (rapi) "/2018-06-01/runtime/invocation" path))

(defn get-request []
  (let [request (http/get (make-url "/next"))]
    {:request-id (get-in request [:headers "Lambda-Runtime-Aws-Request-Id"])
     :body (json/decode (get request :body))}))

(defn send-response [request-id body]
  (print (http/post (make-url (string "/" request-id "/response"))
		    (json/encode body)
		    :content-type "application/json")))

(defn send-error [request-id error-body]
  (http/post (make-url (string "/" request-id "/error"))
	     error-body
	     :content-type "application/json"))

(defn handle-request [request handler-fn]
  (let [request-id (get request :request-id)
        body (get request :body)]
    (->> (handler-fn body)
	 (send-response request-id))))

(defn start-event-loop [handler-fn]
  (while true
    (-> (get-request)
	(handle-request handler-fn))))
