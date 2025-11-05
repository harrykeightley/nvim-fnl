-- [nfnl] Compiled from fnl/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local function merge(t, kvs)
  for k, v in pairs(kvs) do
    t[k] = v
  end
  return t
end
local function keys(t)
  local tbl_21_auto = {}
  local i_22_auto = 0
  for k, _ in pairs(t) do
    local val_23_auto = k
    if (nil ~= val_23_auto) then
      i_22_auto = (i_22_auto + 1)
      tbl_21_auto[i_22_auto] = val_23_auto
    else
    end
  end
  return tbl_21_auto
end
local function exists_3f(v)
  return (nil ~= v)
end
local function number_3f(thing)
  return ("number" == type(thing))
end
local function string_3f(thing)
  return ("string" == type(thing))
end
local function table_3f(thing)
  return ("table" == type(thing))
end
local function find(lst, pred)
  local result = nil
  for k, v in ipairs(lst) do
    if exists_3f(result) then break end
    if pred(v) then
      result = v
    else
    end
  end
  return result
end
local function filter_keys(t, keys0)
  local has_key
  local function _3_(key)
    local function _4_(_241)
      return (key == _241)
    end
    return exists_3f(find(keys0, _4_))
  end
  has_key = _3_
  local tbl_16_auto = {}
  for k, v in pairs(t) do
    local k_17_auto, v_18_auto = nil, nil
    if not has_key(k) then
      k_17_auto, v_18_auto = k, v
    else
      k_17_auto, v_18_auto = nil
    end
    if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
      tbl_16_auto[k_17_auto] = v_18_auto
    else
    end
  end
  return tbl_16_auto
end
local function plugin(name, opts_3f)
  return merge({name}, (opts_3f or {}))
end
local function plugin_with_args(name, args_3f, opts_3f)
  local args = (args_3f or {})
  local opts = (opts_3f or {})
  local result = merge({name}, opts)
  local tbl_16_auto = result
  for i, v in ipairs(args) do
    local k_17_auto, v_18_auto = (i + 1), v
    if ((k_17_auto ~= nil) and (v_18_auto ~= nil)) then
      tbl_16_auto[k_17_auto] = v_18_auto
    else
    end
  end
  return tbl_16_auto
end
local function setup_plugin(name)
  return plugin(name, {opts = {}})
end
local function plugin_keys(lhs, rhs, opts_3f)
  return merge({lhs, rhs}, (opts_3f or {}))
end
local function serialize(v)
  local serialize_tbl
  local function _8_(t)
    local res = "TABLE"
    for k, v0 in pairs(t) do
      res = (res .. "\n\t" .. k .. " -> " .. serialize(v0))
    end
    return res
  end
  serialize_tbl = _8_
  if table_3f(v) then
    return serialize_tbl(v)
  else
    return tostring(v)
  end
end
local function notify(...)
  local text
  do
    local res = ""
    for _, v in ipairs({...}) do
      res = (res .. " " .. serialize(v))
    end
    text = res
  end
  return vim.notify(text)
end
return {notify = notify, merge = merge, keys = keys, plugin = plugin, ["plugin-with-args"] = plugin_with_args, ["plugin-keys"] = plugin_keys, ["setup-plugin"] = setup_plugin, find = find, ["exists?"] = exists_3f, ["table?"] = table_3f, ["string?"] = string_3f, ["number?"] = number_3f, ["filter-keys"] = filter_keys}
