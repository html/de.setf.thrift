;;;  -*- Package: thrift-generated -*-
;;;
;;; Autogenerated by Thrift
;;; DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

(def-package :thrift-generated)

(thrift:def-enum "Numberz"
  (("ONE" . 1)
   ("TWO" . 2)
   ("THREE" . 3)
   ("FIVE" . 5)
   ("SIX" . 6)
   ("EIGHT" . 8)))

(thrift:def-struct "xtruct"
  (("string_thing" nil :type string :id 1)
   ("byte_thing" nil :type byte :id 4)
   ("i32_thing" nil :type i32 :id 9)
   ("i64_thing" nil :type i64 :id 11)))

(thrift:def-struct "xtruct2"
  (("byte_thing" nil :type byte :id 1)
   ("struct_thing" nil :type (struct "xtruct") :id 2)
   ("i32_thing" nil :type i32 :id 3)))

(thrift:def-struct "insanity"
  (("userMap" nil :type (map (enum "Numberz") i64) :id 1)
   ("xtructs" nil :type (list (struct "xtruct")) :id 2)))

(thrift:def-exception "xception"
  (("errorCode" nil :type i32 :id 1)
   ("message" nil :type string :id 2)))

(thrift:def-exception "xception2"
  (("errorCode" nil :type i32 :id 1)
   ("struct_thing" nil :type (struct "xtruct") :id 2)))

(thrift:def-struct "emptystruct"
  ())

(thrift:def-struct "onefield"
  (("field" nil :type (struct "emptystruct") :id 1)))

(thrift:def-service "ThriftTest" nil
  (:method "testVoid" (() void))
  (:method "testString" ((("thing" string 1)) string))
  (:method "testByte" ((("thing" byte 1)) byte))
  (:method "testI32" ((("thing" i32 1)) i32))
  (:method "testI64" ((("thing" i64 1)) i64))
  (:method "testDouble" ((("thing" double 1)) double))
  (:method "testStruct" ((("thing" (struct "xtruct") 1)) (struct "xtruct")))
  (:method "testNest" ((("thing" (struct "xtruct2") 1)) (struct "xtruct2")))
  (:method "testMap" ((("thing" (map i32 i32) 1)) (map i32 i32)))
  (:method "testSet" ((("thing" (set i32) 1)) (set i32)))
  (:method "testList" ((("thing" (list i32) 1)) (list i32)))
  (:method "testEnum" ((("thing" (enum "Numberz") 1)) (enum "Numberz")))
  (:method "testTypedef" ((("thing" i64 1)) i64))
  (:method "testMapMap" ((("hello" i32 1)) (map i32 (map i32 i32))))
  (:method "testInsanity" ((("argument" (struct "insanity") 1)) (map i64 (map (enum "Numberz") (struct "insanity"))))))
