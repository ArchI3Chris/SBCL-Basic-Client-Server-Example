#!/usr/bin/sbcl --script
(load "~/.sbclrc")

(require :usocket)

(defparameter *sock* nil)
(defparameter *sock-listen* nil)
(defparameter *my-stream* nil)

(defun communi ()
  ;; bind socket
  (setf *sock* (usocket:socket-listen "127.0.0.1" 4123))

  ;; listen to incoming connections
  (setf *sock-listen* (usocket:socket-accept *sock* :element-type 'character))

  ; open stream for communication
  (setf *my-stream* (usocket:socket-stream *sock-listen*))

  ;; print message from client
  (format t "~a~%" (read *my-stream*))
  (force-output)

  ;; send answer to client
  (print "What up, client" *my-stream*)
  (force-output *my-stream*))

;; call communication and close socket, no matter what
(unwind-protect (communi)
  (format t "Closing socket connection...~%")
  (usocket:socket-close *sock-listen*)
  (usocket:socket-close *sock*))