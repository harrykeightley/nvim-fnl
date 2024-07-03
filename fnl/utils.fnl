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

;; Recursively serialize some data
(fn serialize [v]
  (let [serialize-tbl 
         (fn [t] 
           (accumulate [res "TABLE"
                        k v (pairs t)]
             (.. res "\n\t" k " -> " (serialize v))))]
    (if (= (type v) "table")
      (serialize-tbl v)
      (tostring v))))

(fn notify [...]
  (let [text (accumulate [res ""
                          _ v (ipairs [...])]
               (.. res " " (serialize v)))]
    (vim.notify text)))

{: notify
 : merge
 : keys
 : plugin
 : plugin-keys
 : setup-plugin}
