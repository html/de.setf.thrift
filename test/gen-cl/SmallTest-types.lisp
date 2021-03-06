;;;  -*- Package: thrift-generated -*-
;;;
;;; Autogenerated by Thrift
;;; DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

(def-package :thrift-generated)

(thrift:def-struct "goodbyez"
  (("val" 325 :type i32 :id 1)))

(thrift:def-struct "boolpasser"
  (("value" t :type bool :id 1)))

(thrift:def-struct "hello"
  (("simple" 53 :type i32 :id 1)
   ("complex" (thrift:map 
    (cl:cons 23 532)
    (cl:cons 6243 632)
    (cl:cons 2355 532)  ) :type (map i32 i32) :id 2)
   ("complexer" nil :type (map i32 (map i32 i32)) :id 3)
   ("words" "words" :type string :id 4)
   ("thinz" (make-instance 'goodbyez 
    :val 36632
    ) :type (struct "goodbyez") :id 5)))

(thrift:def-exception "goodbye"
  (("simple" nil :type i32 :id 1)
   ("complex" nil :type (map i32 i32) :id 2)
   ("complexer" nil :type (map i32 (map i32 i32)) :id 3)))

(thrift:def-service "SmallService" nil
  (:method "testThinger" ((("bootz" string 1)) string))
  (:method "testMe" ((("hello" i32 1) ("wonk" (struct "hello") 2)) (struct "hello"))
   :exceptions (("g" nil :type (struct "goodbye") :id 1)))
  (:method "testVoid" (() void)
   :exceptions (("g" nil :type (struct "goodbye") :id 1)))
  (:method "testI32" ((("boo" i32 1)) i32)))
