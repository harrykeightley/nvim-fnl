-- [nfnl] fnl/config/diagnostics.fnl
vim.diagnostic.config({severity_sort = true})
local severities = {error = vim.diagnostic.severity.ERROR, warn = vim.diagnostic.severity.WARN, info = vim.diagnostic.severity.INFO, hint = vim.diagnostic.severity.HINT}
local function has_severity(severity)
  local severity_filter = severities[severity]
  local diagnostics = vim.diagnostic.get(0, {severity = severity_filter})
  return (0 < #diagnostics)
end
local function jump_by_severity(count)
  local next_highest_severity
  if has_severity("error") then
    next_highest_severity = "error"
  elseif has_severity("warn") then
    next_highest_severity = "warn"
  else
    next_highest_severity = nil
  end
  return vim.diagnostic.jump({count = count, severity = severities[next_highest_severity]})
end
return {["jump-by-severity"] = jump_by_severity, ["has-severity"] = has_severity}
