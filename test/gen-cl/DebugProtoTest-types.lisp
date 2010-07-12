;;;  -*- Package: thrift-generated -*-
;;;
;;; Autogenerated by Thrift
;;; DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

(def-package :thrift-generated)

(thrift:def-enum "SomeEnum"
  (("ONE" . 1)
   ("TWO" . 2)))

(thrift:def-struct "doubles"
  (("nan" nil :type double :id 1)
   ("inf" nil :type double :id 2)
   ("neginf" nil :type double :id 3)
   ("repeating" nil :type double :id 4)
   ("big" nil :type double :id 5)
   ("small" nil :type double :id 6)
   ("zero" nil :type double :id 7)
   ("negzero" nil :type double :id 8)))

(thrift:def-struct "oneofeach"
  (("im_true" nil :type bool :id 1)
   ("im_false" nil :type bool :id 2)
   ("a_bite" 200 :type byte :id 3)
   ("integer16" 33000 :type i16 :id 4)
   ("integer32" nil :type i32 :id 5)
   ("integer64" 10000000000 :type i64 :id 6)
   ("double_precision" nil :type double :id 7)
   ("some_characters" nil :type string :id 8)
   ("zomg_unicode" nil :type string :id 9)
   ("what_who" nil :type bool :id 10)
   ("base64" nil :type string :id 11)
   ("byte_list" (thrift:list
      1
      2
      3
      ) :type (list byte) :id 12)
   ("i16_list" (thrift:list
      1
      2
      3
      ) :type (list i16) :id 13)
   ("i64_list" (thrift:list
      1
      2
      3
      ) :type (list i64) :id 14)))

(thrift:def-struct "bonk"
  (("type" nil :type i32 :id 1)
   ("message" nil :type string :id 2)))

(thrift:def-struct "nesting"
  (("my_bonk" nil :type (struct "bonk") :id 1)
   ("my_ooe" nil :type (struct "oneofeach") :id 2)))

(thrift:def-struct "holymoley"
  (("big" nil :type (list (struct "oneofeach")) :id 1)
   ("contain" nil :type (set (list string)) :id 2)
   ("bonks" nil :type (map string (list (struct "bonk"))) :id 3)))

(thrift:def-struct "backwards"
  (("first_tag2" nil :type i32 :id 2)
   ("second_tag1" nil :type i32 :id 1)))

(thrift:def-struct "empty"
  ())

(thrift:def-struct "wrapper"
  (("foo" nil :type (struct "empty") :id 1)))

(thrift:def-struct "randomstuff"
  (("a" nil :type i32 :id 1)
   ("b" nil :type i32 :id 2)
   ("c" nil :type i32 :id 3)
   ("d" nil :type i32 :id 4)
   ("myintlist" nil :type (list i32) :id 5)
   ("maps" nil :type (map i32 (struct "wrapper")) :id 6)
   ("bigint" nil :type i64 :id 7)
   ("triple" nil :type double :id 8)))

(thrift:def-struct "base64"
  (("a" nil :type i32 :id 1)
   ("b1" nil :type string :id 2)
   ("b2" nil :type string :id 3)
   ("b3" nil :type string :id 4)
   ("b4" nil :type string :id 5)
   ("b5" nil :type string :id 6)
   ("b6" nil :type string :id 7)))

(thrift:def-struct "compactprototeststruct"
  (("a_byte" nil :type byte :id 1)
   ("a_i16" nil :type i16 :id 2)
   ("a_i32" nil :type i32 :id 3)
   ("a_i64" nil :type i64 :id 4)
   ("a_double" nil :type double :id 5)
   ("a_string" nil :type string :id 6)
   ("a_binary" nil :type string :id 7)
   ("true_field" nil :type bool :id 8)
   ("false_field" nil :type bool :id 9)
   ("empty_struct_field" nil :type (struct "empty") :id 10)
   ("byte_list" nil :type (list byte) :id 11)
   ("i16_list" nil :type (list i16) :id 12)
   ("i32_list" nil :type (list i32) :id 13)
   ("i64_list" nil :type (list i64) :id 14)
   ("double_list" nil :type (list double) :id 15)
   ("string_list" nil :type (list string) :id 16)
   ("binary_list" nil :type (list string) :id 17)
   ("boolean_list" nil :type (list bool) :id 18)
   ("struct_list" nil :type (list (struct "empty")) :id 19)
   ("byte_set" nil :type (set byte) :id 20)
   ("i16_set" nil :type (set i16) :id 21)
   ("i32_set" nil :type (set i32) :id 22)
   ("i64_set" nil :type (set i64) :id 23)
   ("double_set" nil :type (set double) :id 24)
   ("string_set" nil :type (set string) :id 25)
   ("binary_set" nil :type (set string) :id 26)
   ("boolean_set" nil :type (set bool) :id 27)
   ("struct_set" nil :type (set (struct "empty")) :id 28)
   ("byte_byte_map" nil :type (map byte byte) :id 29)
   ("i16_byte_map" nil :type (map i16 byte) :id 30)
   ("i32_byte_map" nil :type (map i32 byte) :id 31)
   ("i64_byte_map" nil :type (map i64 byte) :id 32)
   ("double_byte_map" nil :type (map double byte) :id 33)
   ("string_byte_map" nil :type (map string byte) :id 34)
   ("binary_byte_map" nil :type (map string byte) :id 35)
   ("boolean_byte_map" nil :type (map bool byte) :id 36)
   ("byte_i16_map" nil :type (map byte i16) :id 37)
   ("byte_i32_map" nil :type (map byte i32) :id 38)
   ("byte_i64_map" nil :type (map byte i64) :id 39)
   ("byte_double_map" nil :type (map byte double) :id 40)
   ("byte_string_map" nil :type (map byte string) :id 41)
   ("byte_binary_map" nil :type (map byte string) :id 42)
   ("byte_boolean_map" nil :type (map byte bool) :id 43)
   ("list_byte_map" nil :type (map (list byte) byte) :id 44)
   ("set_byte_map" nil :type (map (set byte) byte) :id 45)
   ("map_byte_map" nil :type (map (map byte byte) byte) :id 46)
   ("byte_map_map" nil :type (map byte (map byte byte)) :id 47)
   ("byte_set_map" nil :type (map byte (set byte)) :id 48)
   ("byte_list_map" nil :type (map byte (list byte)) :id 49)))

(thrift:def-exception "exceptionwithamap"
  (("blah" nil :type string :id 1)
   ("map_field" nil :type (map string string) :id 2)))

(thrift:def-struct "blowup"
  (("b1" nil :type (map (list i32) (set (map i32 string))) :id 1)
   ("b2" nil :type (map (list i32) (set (map i32 string))) :id 2)
   ("b3" nil :type (map (list i32) (set (map i32 string))) :id 3)
   ("b4" nil :type (map (list i32) (set (map i32 string))) :id 4)))

(thrift:def-struct "reverseorderstruct"
  (("first" nil :type string :id 4)
   ("second" nil :type i16 :id 3)
   ("third" nil :type i32 :id 2)
   ("fourth" nil :type i64 :id 1)))

(thrift:def-struct "structwithsomeenum"
  (("blah" nil :type (enum "SomeEnum") :id 1)))

(thrift:def-struct "testunion"
  (("string_field" nil :type string :id 1)
   ("i32_field" nil :type i32 :id 2)
   ("struct_field" nil :type (struct "oneofeach") :id 3)
   ("struct_list" nil :type (list (struct "randomstuff")) :id 4)
   ("other_i32_field" nil :type i32 :id 5)
   ("enum_field" nil :type (enum "SomeEnum") :id 6)
   ("i32_set" nil :type (set i32) :id 7)
   ("i32_map" nil :type (map i32 i32) :id 8)))

(thrift:def-struct "testunionminusstringfield"
  (("i32_field" nil :type i32 :id 2)
   ("struct_field" nil :type (struct "oneofeach") :id 3)
   ("struct_list" nil :type (list (struct "randomstuff")) :id 4)
   ("other_i32_field" nil :type i32 :id 5)
   ("enum_field" nil :type (enum "SomeEnum") :id 6)
   ("i32_set" nil :type (set i32) :id 7)
   ("i32_map" nil :type (map i32 i32) :id 8)))

(thrift:def-struct "comparableunion"
  (("string_field" nil :type string :id 1)
   ("binary_field" nil :type string :id 2)))

(thrift:def-struct "structwithaunion"
  (("test_union" nil :type (struct "testunion") :id 1)))

(thrift:def-struct "primitivethenstruct"
  (("blah" nil :type i32 :id 1)
   ("blah2" nil :type i32 :id 2)
   ("bw" nil :type (struct "backwards") :id 3)))

(thrift:def-struct "structwithasomemap"
  (("somemap_field" nil :type (map i32 i32) :id 1)))

(thrift:def-struct "bigfieldidstruct"
  (("field1" nil :type string :id 1)
   ("field2" nil :type string :id 45)))

(thrift:def-struct "breaksrubycompactprotocol"
  (("field1" nil :type string :id 1)
   ("field2" nil :type (struct "bigfieldidstruct") :id 2)
   ("field3" nil :type i32 :id 3)))

(thrift:def-service "ServiceForExceptionWithAMap" nil
  (:method "methodThatThrowsAnException" (() void)
   :exceptions (("xwamap" nil :type (struct "exceptionwithamap") :id 1))))
(thrift:def-service "Srv" nil
  (:method "Janky" ((("arg" i32 1)) i32))
  (:method "voidMethod" (() void))
  (:method "primitiveMethod" (() i32))
  (:method "structMethod" (() (struct "compactprototeststruct")))
  (:method "methodWithDefaultArgs" ((("something" i32 1)) void))
  (:method "onewayMethod" (() void)
   :oneway t))
(thrift:def-service "Inherited" "Srv"
  (:method "identity" ((("arg" i32 1)) i32)))
(thrift:def-service "EmptyService" nil)
(thrift:def-service "ReverseOrderService" nil
  (:method "myMethod" ((("first" string 4) ("second" i16 3) ("third" i32 2) ("fourth" i64 1)) void)))
