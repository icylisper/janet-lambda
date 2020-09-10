(import json)
(import lambda)

(defn hello [data]
  {:hello "world" :data data})

(defn main [& args]
  (print "Starting lambda")
  (if (lambda/rapi)
    (lambda/start-event-loop hello)
    (let [xs ;(slice args 1 -1)
	  event  (->>  xs
		       (apply string)
		       (json/decode))
	  response (hello event)]
      (print (json/encode response)))))
