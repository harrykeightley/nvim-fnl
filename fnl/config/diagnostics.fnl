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
  (let [next-severity (if (has-severity :error) :error
                          (has-severity :warn) :warn
                          nil)
        method (if (< 0 count)
                   vim.diagnostic.goto_next
                   vim.diagnostic.goto_prev)]
    ;; NOTE: Below is for nvim 0.11 when aboveb ecomes deprecated
    ;(vim.diagnostic.jump {: count :severity (. severities next-severity)})
    (method {:severity (. severities next-severity)})))

{: jump-by-severity : has-severity}
