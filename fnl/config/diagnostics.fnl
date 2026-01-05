(vim.diagnostic.config {:severity_sort true})

(local severities {:error vim.diagnostic.severity.ERROR
                   :warn vim.diagnostic.severity.WARN
                   :info vim.diagnostic.severity.INFO
                   :hint vim.diagnostic.severity.HINT})

(fn has-severity [severity]
  "Returns true if there exists any diagnostics with the supplied
  severity."
  (let [severity-filter (. severities severity)
        diagnostics (vim.diagnostic.get 0 {:severity severity-filter})]
    (< 0 (length diagnostics))))

(fn jump-by-severity [count]
  "For the current highest severity in the document (of <error, warn>), moves {count}
  to the next diagnostic"
  (let [next-highest-severity (if (has-severity :error) :error
                                  (has-severity :warn) :warn
                                  nil)]
    ;; NOTE: Below is for nvim 0.11 when above becomes deprecated
    (vim.diagnostic.jump {: count
                          :severity (. severities next-highest-severity)})))

{: jump-by-severity : has-severity}
