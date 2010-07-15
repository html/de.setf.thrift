;;;  -*- Package: cassandra -*-
;;;
;;; Autogenerated by Thrift
;;; DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING

(thrift:def-package :cassandra)

(in-package :cassandra)

(thrift:def-enum "ConsistencyLevel"
  (("ZERO" . 0)
   ("ONE" . 1)
   ("QUORUM" . 2)
   ("DCQUORUM" . 3)
   ("DCQUORUMSYNC" . 4)
   ("ALL" . 5)
   ("ANY" . 6)))

(thrift:def-enum "AccessLevel"
  (("NONE" . 0)
   ("READONLY" . 16)
   ("READWRITE" . 32)
   ("FULL" . 64)))

(thrift:def-struct "clock"
  "Encapsulate types of conflict resolution.

@param timestamp. User-supplied timestamp. When two columns with this type of clock conflict, the one with the
                  highest timestamp is the one whose value the system will converge to. No other assumptions
                  are made about what the timestamp represents, but using microseconds-since-epoch is customary.
"
  (("timestamp" nil :type i64 :id 1)))

(thrift:def-struct "column"
  "Basic unit of data within a ColumnFamily.
@param name, the name by which this column is set and retrieved.  Maximum 64KB long.
@param value. The data associated with the name.  Maximum 2GB long, but in practice you should limit it to small numbers of MB (since Thrift must read the full value into memory to operate on it).
@param clock. The clock is used for conflict detection/resolution when two columns with same name need to be compared.
@param ttl. An optional, positive delay (in seconds) after which the column will be automatically deleted.
"
  (("name" nil :type string :id 1)
   ("value" nil :type string :id 2)
   ("clock" nil :type (struct "clock") :id 3)
   ("ttl" nil :type i32 :id 4 :optional t)))

(thrift:def-struct "supercolumn"
  "A named list of columns.
@param name. see Column.name.
@param columns. A collection of standard Columns.  The columns within a super column are defined in an adhoc manner.
                Columns within a super column do not have to have matching structures (similarly named child columns).
"
  (("name" nil :type string :id 1)
   ("columns" nil :type (thrift:list (struct "column")) :id 2)))

(thrift:def-struct "columnorsupercolumn"
  "Methods for fetching rows/records from Cassandra will return either a single instance of ColumnOrSuperColumn or a list
of ColumnOrSuperColumns (get_slice()). If you're looking up a SuperColumn (or list of SuperColumns) then the resulting
instances of ColumnOrSuperColumn will have the requested SuperColumn in the attribute super_column. For queries resulting
in Columns, those values will be in the attribute column. This change was made between 0.3 and 0.4 to standardize on
single query methods that may return either a SuperColumn or Column.

@param column. The Column returned by get() or get_slice().
@param super_column. The SuperColumn returned by get() or get_slice().
"
  (("column" nil :type (struct "column") :id 1 :optional t)
   ("super_column" nil :type (struct "supercolumn") :id 2 :optional t)))

(thrift:def-exception "notfoundexception"
  "A specific column was requested that does not exist.
"
  ())

(thrift:def-exception "invalidrequestexception"
  "Invalid request could mean keyspace or column family does not exist, required parameters are missing, or a parameter is malformed.
why contains an associated error message.
"
  (("why" nil :type string :id 1)))

(thrift:def-exception "unavailableexception"
  "Not all the replicas required could be created and/or read.
"
  ())

(thrift:def-exception "timedoutexception"
  "RPC timeout was exceeded.  either a node failed mid-operation, or load was too high, or the requested op was too large.
"
  ())

(thrift:def-exception "authenticationexception"
  "invalid authentication request (invalid keyspace, user does not exist, or credentials invalid)
"
  (("why" nil :type string :id 1)))

(thrift:def-exception "authorizationexception"
  "invalid authorization request (user does not have access to keyspace)
"
  (("why" nil :type string :id 1)))

(thrift:def-struct "columnparent"
  "ColumnParent is used when selecting groups of columns from the same ColumnFamily. In directory structure terms, imagine
ColumnParent as ColumnPath + '/../'.

See also <a href='cassandra.html#Struct_ColumnPath'>ColumnPath</a>
"
  (("column_family" nil :type string :id 3)
   ("super_column" nil :type string :id 4 :optional t)))

(thrift:def-struct "columnpath"
  "The ColumnPath is the path to a single column in Cassandra. It might make sense to think of ColumnPath and
ColumnParent in terms of a directory structure.

ColumnPath is used to looking up a single column.

@param column_family. The name of the CF of the column being looked up.
@param super_column. The super column name.
@param column. The column name.
"
  (("column_family" nil :type string :id 3)
   ("super_column" nil :type string :id 4 :optional t)
   ("column" nil :type string :id 5 :optional t)))

(thrift:def-struct "slicerange"
  "A slice range is a structure that stores basic range, ordering and limit information for a query that will return
multiple columns. It could be thought of as Cassandra's version of LIMIT and ORDER BY

@param start. The column name to start the slice with. This attribute is not required, though there is no default value,
              and can be safely set to '', i.e., an empty byte array, to start with the first column name. Otherwise, it
              must a valid value under the rules of the Comparator defined for the given ColumnFamily.
@param finish. The column name to stop the slice at. This attribute is not required, though there is no default value,
               and can be safely set to an empty byte array to not stop until 'count' results are seen. Otherwise, it
               must also be a valid value to the ColumnFamily Comparator.
@param reversed. Whether the results should be ordered in reversed order. Similar to ORDER BY blah DESC in SQL.
@param count. How many keys to return. Similar to LIMIT 100 in SQL. May be arbitrarily large, but Thrift will
              materialize the whole result into memory before returning it to the client, so be aware that you may
              be better served by iterating through slices by passing the last value of one call in as the 'start'
              of the next instead of increasing 'count' arbitrarily large.
@param bitmasks. A list of OR-ed binary AND masks applied to the result set.
"
  (("start" nil :type string :id 1)
   ("finish" nil :type string :id 2)
   ("reversed" nil :type bool :id 3)
   ("count" 100 :type i32 :id 4)
   ("bitmasks" nil :type (thrift:list string) :id 5 :optional t)))

(thrift:def-struct "slicepredicate"
  "A SlicePredicate is similar to a mathematic predicate (see http://en.wikipedia.org/wiki/Predicate_(mathematical_logic)),
which is described as 'a property that the elements of a set have in common.'

SlicePredicate's in Cassandra are described with either a list of column_names or a SliceRange.  If column_names is
specified, slice_range is ignored.

@param column_name. A list of column names to retrieve. This can be used similar to Memcached's 'multi-get' feature
                    to fetch N known column names. For instance, if you know you wish to fetch columns 'Joe', 'Jack',
                    and 'Jim' you can pass those column names as a list to fetch all three at once.
@param slice_range. A SliceRange describing how to range, order, and/or limit the slice.
"
  (("column_names" nil :type (thrift:list string) :id 1 :optional t)
   ("slice_range" nil :type (struct "slicerange") :id 2 :optional t)))

(thrift:def-struct "keyrange"
  "The semantics of start keys and tokens are slightly different.
Keys are start-inclusive; tokens are start-exclusive.  Token
ranges may also wrap -- that is, the end token may be less
than the start one.  Thus, a range from keyX to keyX is a
one-element range, but a range from tokenY to tokenY is the
full ring.
"
  (("start_key" nil :type string :id 1 :optional t)
   ("end_key" nil :type string :id 2 :optional t)
   ("start_token" nil :type string :id 3 :optional t)
   ("end_token" nil :type string :id 4 :optional t)
   ("count" 100 :type i32 :id 5)))

(thrift:def-struct "keyslice"
  "A KeySlice is key followed by the data it maps to. A collection of KeySlice is returned by the get_range_slice operation.

@param key. a row key
@param columns. List of data represented by the key. Typically, the list is pared down to only the columns specified by
                a SlicePredicate.
"
  (("key" nil :type string :id 1)
   ("columns" nil :type (thrift:list (struct "columnorsupercolumn")) :id 2)))

(thrift:def-struct "deletion"
  (("clock" nil :type (struct "clock") :id 1)
   ("super_column" nil :type string :id 2 :optional t)
   ("predicate" nil :type (struct "slicepredicate") :id 3 :optional t)))

(thrift:def-struct "mutation"
  "A Mutation is either an insert, represented by filling column_or_supercolumn, or a deletion, represented by filling the deletion attribute.
@param column_or_supercolumn. An insert to a column or supercolumn
@param deletion. A deletion of a column or supercolumn
"
  (("column_or_supercolumn" nil :type (struct "columnorsupercolumn") :id 1 :optional t)
   ("deletion" nil :type (struct "deletion") :id 2 :optional t)))

(thrift:def-struct "tokenrange"
  (("start_token" nil :type string :id 1)
   ("end_token" nil :type string :id 2)
   ("endpoints" nil :type (thrift:list string) :id 3)))

(thrift:def-struct "authenticationrequest"
  "Authentication requests can contain any data, dependent on the AuthenticationBackend used
"
  (("credentials" nil :type (thrift:map string string) :id 1)))

(thrift:def-struct "cfdef"
  (("table" nil :type string :id 1)
   ("name" nil :type string :id 2)
   ("column_type" "Standard" :type string :id 3 :optional t)
   ("clock_type" "Timestamp" :type string :id 4 :optional t)
   ("comparator_type" "BytesType" :type string :id 5 :optional t)
   ("subcomparator_type" "" :type string :id 6 :optional t)
   ("reconciler" "" :type string :id 7 :optional t)
   ("comment" "" :type string :id 8 :optional t)
   ("row_cache_size" 0 :type double :id 9 :optional t)
   ("preload_row_cache" nil :type bool :id 10 :optional t)
   ("key_cache_size" 200000 :type double :id 11 :optional t)
   ("read_repair_chance" 1 :type double :id 12 :optional t)))

(thrift:def-struct "ksdef"
  (("name" nil :type string :id 1)
   ("strategy_class" nil :type string :id 2)
   ("replication_factor" nil :type i32 :id 3)
   ("cf_defs" nil :type (thrift:list (struct "cfdef")) :id 5)))

(thrift:def-service "Cassandra" nil
  (:method "login" ((("auth_request" (struct "authenticationrequest") 1)) (enum "AccessLevel"))
   :exceptions (("authnx" nil :type (struct "authenticationexception") :id 1)
   ("authzx" nil :type (struct "authorizationexception") :id 2)))
  (:method "set_keyspace" ((("keyspace" string 1)) void)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)))
  (:method "get" ((("key" string 1) ("column_path" (struct "columnpath") 2) ("consistency_level" (enum "ConsistencyLevel") 3)) (struct "columnorsupercolumn"))
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("nfe" nil :type (struct "notfoundexception") :id 2)
   ("ue" nil :type (struct "unavailableexception") :id 3)
   ("te" nil :type (struct "timedoutexception") :id 4))
   :documentation "Get the Column or SuperColumn at the given column_path. If no value is present, NotFoundException is thrown. (This is
the only method that can throw an exception under non-failure conditions.)
")
  (:method "get_slice" ((("key" string 1) ("column_parent" (struct "columnparent") 2) ("predicate" (struct "slicepredicate") 3) ("consistency_level" (enum "ConsistencyLevel") 4)) (thrift:list (struct "columnorsupercolumn")))
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2)
   ("te" nil :type (struct "timedoutexception") :id 3))
   :documentation "Get the group of columns contained by column_parent (either a ColumnFamily name or a ColumnFamily/SuperColumn name
pair) specified by the given SlicePredicate. If no matching values are found, an empty list is returned.
")
  (:method "multiget_slice" ((("keys" (thrift:list string) 1) ("column_parent" (struct "columnparent") 2) ("predicate" (struct "slicepredicate") 3) ("consistency_level" (enum "ConsistencyLevel") 4)) (thrift:map string (thrift:list (struct "columnorsupercolumn"))))
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2)
   ("te" nil :type (struct "timedoutexception") :id 3))
   :documentation "Performs a get_slice for column_parent and predicate for the given keys in parallel.
")
  (:method "get_count" ((("key" string 1) ("column_parent" (struct "columnparent") 2) ("predicate" (struct "slicepredicate") 3) ("consistency_level" (enum "ConsistencyLevel") 4)) i32)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2)
   ("te" nil :type (struct "timedoutexception") :id 3))
   :documentation "returns the number of columns matching <code>predicate</code> for a particular <code>key</code>,
<code>ColumnFamily</code> and optionally <code>SuperColumn</code>.
")
  (:method "multiget_count" ((("keyspace" string 1) ("keys" (thrift:list string) 2) ("column_parent" (struct "columnparent") 3) ("predicate" (struct "slicepredicate") 4) ("consistency_level" (enum "ConsistencyLevel") 5)) (thrift:map string i32))
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2)
   ("te" nil :type (struct "timedoutexception") :id 3))
   :documentation "Perform a get_count in parallel on the given list<binary> keys. The return value maps keys to the count found.
")
  (:method "get_range_slices" ((("column_parent" (struct "columnparent") 1) ("predicate" (struct "slicepredicate") 2) ("range" (struct "keyrange") 3) ("consistency_level" (enum "ConsistencyLevel") 4)) (thrift:list (struct "keyslice")))
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2)
   ("te" nil :type (struct "timedoutexception") :id 3))
   :documentation "returns a subset of columns for a range of keys.
")
  (:method "insert" ((("key" string 1) ("column_parent" (struct "columnparent") 2) ("column" (struct "column") 3) ("consistency_level" (enum "ConsistencyLevel") 4)) void)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2)
   ("te" nil :type (struct "timedoutexception") :id 3))
   :documentation "Insert a Column at the given column_parent.column_family and optional column_parent.super_column.
")
  (:method "remove" ((("key" string 1) ("column_path" (struct "columnpath") 2) ("clock" (struct "clock") 3) ("consistency_level" (enum "ConsistencyLevel") 4)) void)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2)
   ("te" nil :type (struct "timedoutexception") :id 3))
   :documentation "Remove data from the row specified by key at the granularity specified by column_path, and the given clock. Note
that all the values in column_path besides column_path.column_family are truly optional: you can remove the entire
row by just specifying the ColumnFamily, or you can remove a SuperColumn or a single Column by specifying those levels too.
")
  (:method "batch_mutate" ((("mutation_map" (thrift:map string (thrift:map string (thrift:list (struct "mutation")))) 1) ("consistency_level" (enum "ConsistencyLevel") 2)) void)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2)
   ("te" nil :type (struct "timedoutexception") :id 3))
   :documentation "  Mutate many columns or super columns for many row keys. See also: Mutation.

  mutation_map maps key to column family to a list of Mutation objects to take place at that scope.
*
")
  (:method "truncate" ((("cfname" string 1)) void)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1)
   ("ue" nil :type (struct "unavailableexception") :id 2))
   :documentation "Truncate will mark and entire column family as deleted.
From the user's perspective a successful call to truncate will result complete data deletion from cfname.
Internally, however, disk space will not be immediatily released, as with all deletes in cassandra, this one
only marks the data as deleted.
The operation succeeds only if all hosts in the cluster at available and will throw an UnavailableException if
some hosts are down.
")
  (:method "check_schema_agreement" (() (thrift:map string (thrift:list string)))
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1))
   :documentation "ask the cluster if they all are using the same migration id. returns a map of version->hosts-on-that-version.
hosts that did not respond will be under the key DatabaseDescriptor.INITIAL_VERSION. agreement can be determined
by checking if the size of the map is 1.
")
  (:method "describe_keyspaces" (() (thrift:set string))
   :documentation "list the defined keyspaces in this cluster
")
  (:method "describe_cluster_name" (() string)
   :documentation "get the cluster name
")
  (:method "describe_version" (() string)
   :documentation "get the thrift api version
")
  (:method "describe_ring" ((("keyspace" string 1)) (thrift:list (struct "tokenrange")))
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1))
   :documentation "get the token ring: a map of ranges to host addresses,
represented as a set of TokenRange instead of a map from range
to list of endpoints, because you can't use Thrift structs as
map keys:
https://issues.apache.org/jira/browse/THRIFT-162

for the same reason, we can't return a set here, even though
order is neither important nor predictable.
")
  (:method "describe_keyspace" ((("keyspace" string 1)) (thrift:map string (thrift:map string string)))
   :exceptions (("nfe" nil :type (struct "notfoundexception") :id 1))
   :documentation "describe specified keyspace
")
  (:method "describe_splits" ((("keyspace" string 1) ("cfName" string 2) ("start_token" string 3) ("end_token" string 4) ("keys_per_split" i32 5)) (thrift:list string))
   :documentation "experimental API for hadoop/parallel query support.
may change violently and without warning.

returns list of token strings such that first subrange is (list[0], list[1]],
next is (list[1], list[2]], etc.
")
  (:method "system_add_column_family" ((("cf_def" (struct "cfdef") 1)) string)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1))
   :documentation "adds a column family. returns the new schema id.
")
  (:method "system_drop_column_family" ((("column_family" string 1)) string)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1))
   :documentation "drops a column family. returns the new schema id.
")
  (:method "system_rename_column_family" ((("old_name" string 1) ("new_name" string 2)) string)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1))
   :documentation "renames a column family. returns the new schema id.
")
  (:method "system_add_keyspace" ((("ks_def" (struct "ksdef") 1)) string)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1))
   :documentation "adds a keyspace and any column families that are part of it. returns the new schema id.
")
  (:method "system_drop_keyspace" ((("keyspace" string 1)) string)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1))
   :documentation "drops a keyspace and any column families that are part of it. returns the new schema id.
")
  (:method "system_rename_keyspace" ((("old_name" string 1) ("new_name" string 2)) string)
   :exceptions (("ire" nil :type (struct "invalidrequestexception") :id 1))
   :documentation "renames a keyspace. returns the new schema id.
"))
