-- [nfnl] Compiled from fnl/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local function merge(t, kvs)
  for k, v in pairs(kvs) do
    t[k] = v
  end
  return t
end
local function keys(t)
  local tbl_17_auto = {}
  local i_18_auto = #tbl_17_auto
  for k, _ in pairs(t) do
    local val_19_auto = k
    if (nil ~= val_19_auto) then
      i_18_auto = (i_18_auto + 1)
      do end (tbl_17_auto)[i_18_auto] = val_19_auto
    else
    end
  end
  return tbl_17_auto
end
local function plugin(name, opts_3f)
  return merge({name}, (opts_3f or {}))
end
local function setup_plugin(name)
  return plugin(name, {opts = {}})
end
local function plugin_keys(lhs, rhs, opts_3f)
  return merge({lhs, rhs}, (opts_3f or {}))
end
return {merge = merge, keys = keys, plugin = plugin, ["plugin-keys"] = plugin_keys, ["setup-plugin"] = setup_plugin}