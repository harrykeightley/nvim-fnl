(fn merge [t kvs]
  (each [k v (pairs kvs)]
    (tset t k v))
  t)

(fn keys [t]
  (icollect [k _ (pairs t)]
    k))

(fn plugin [name opts?]
  (merge {1 name} (or opts? {})))

(fn setup-plugin [name]
  (plugin name {:opts {}}))

(fn plugin-keys [lhs rhs opts?]
  (merge {1 lhs 2 rhs } (or opts? {})))

{: merge
 : keys
 : plugin
 : plugin-keys
 : setup-plugin}
