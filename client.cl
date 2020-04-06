#!/usr/bin/sbcl --script
(load "~/.sbclrc")

(require :usocket)

;; create data array to send
(defparameter *darr* (make-array 16))
(setf (aref *darr* 5) 118)
(setf (aref *darr* 7) "some")
(setf (aref *darr* 9) 'some)

(defparameter *sock* nil)
(defparameter *my-stream* nil)

(defun communi ()
  ;; bind socket
  (setf *sock* (usocket:socket-connect "localhost" 4123))

  ;; open stream for communication
  (setf *my-stream* (usocket:socket-stream *sock*))

  ;; send array to server
  (print *darr* *my-stream*)
  (force-output *my-stream*)

  ;; print reply from server
  (format t "~a~%" (read *my-stream*))
  (force-output))

;; call communication and close socket, no matter what
(unwind-protect (communi)
  (progn
    ;; close socket/client
    (format t "~a~%" "Closing Connection...")
    (usocket:socket-close *sock*)
  ))