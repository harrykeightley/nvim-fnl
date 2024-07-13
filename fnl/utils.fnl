(fn merge [t kvs]
  (each [k v (pairs kvs)]
    (tset t k v))
  t)

(fn keys [t]
  (icollect [k _ (pairs t)]
    k))

(fn exists? [v] (not= nil v))

(fn number? [thing]
  (= :number (type thing)))

(fn string? [thing]
  (= :string (type thing)))

(fn table? [thing]
  (= :table (type thing)))

(fn find [lst pred]
  (var result nil)
  (each [k v (ipairs lst) &until (exists? result)]
    (if (pred v)
        (set result v)))
  result)

(fn filter-keys [t keys]
  "Returns a new table with the supplied keys filtered out."
  (let [has-key (fn [key]
                  (exists? (find keys #(= key $))))]
    (collect [k v (pairs t)]
      (if (not (has-key k))
          (values k v)))))

(fn plugin [name opts?]
  (merge {1 name} (or opts? {})))

(fn setup-plugin [name]
  (plugin name {:opts {}}))

(fn plugin-keys [lhs rhs opts?]
  (merge {1 lhs 2 rhs} (or opts? {})))

;; Recursively serialize some data
(fn serialize [v]
  (let [serialize-tbl (fn [t]
                        (accumulate [res :TABLE k v (pairs t)]
                          (.. res "\n\t" k " -> " (serialize v))))]
    (if (table? v)
        (serialize-tbl v)
        (tostring v))))

(fn notify [...]
  (let [text (accumulate [res "" _ v (ipairs [...])]
               (.. res " " (serialize v)))]
    (vim.notify text)))

{: notify
 : merge
 : keys
 : plugin
 : plugin-keys
 : setup-plugin
 : find
 : exists?
 : table?
 : string?
 : number?
 : filter-keys}
