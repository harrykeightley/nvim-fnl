-- [nfnl] Compiled from fnl/config/diagnostics.fnl by https://github.com/Olical/nfnl, do not edit.
vim.diagnostic.config({severity_sort = true})
local severities = {error = vim.diagnostic.severity.ERROR, warn = vim.diagnostic.severity.WARN, info = vim.diagnostic.severity.INFO, hint = vim.diagnostic.severity.HINT}
local function has_severity(severity)
  local severity_filter = severities[severity]
  local diagnostics = vim.diagnostic.get(0, {severity = severity_filter})
  return (0 < #diagnostics)
end
local function jump_by_severity(count)
  local next_severity
  if has_severity("error") then
    next_severity = "error"
  elseif has_severity("warn") then
    next_severity = "warn"
  else
    next_severity = nil
  end
  local method
  if (0 < count) then
    method = vim.diagnostic.goto_next
  else
    method = vim.diagnostic.goto_prev
  end
  return method({severity = severities[next_severity]})
end
return {["jump-by-severity"] = jump_by_severity, ["has-severity"] = has_severity}
