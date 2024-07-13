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
  local tbl_14_auto = {}
  for k, v in pairs(t) do
    local k_15_auto, v_16_auto = nil, nil
    if not has_key(k) then
      k_15_auto, v_16_auto = k, v
    else
      k_15_auto, v_16_auto = nil
    end
    if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
      tbl_14_auto[k_15_auto] = v_16_auto
    else
    end
  end
  return tbl_14_auto
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
local function serialize(v)
  local serialize_tbl
  local function _7_(t)
    local res = "TABLE"
    for k, v0 in pairs(t) do
      res = (res .. "\n\9" .. k .. " -> " .. serialize(v0))
    end
    return res
  end
  serialize_tbl = _7_
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
return {notify = notify, merge = merge, keys = keys, plugin = plugin, ["plugin-keys"] = plugin_keys, ["setup-plugin"] = setup_plugin, find = find, ["exists?"] = exists_3f, ["table?"] = table_3f, ["string?"] = string_3f, ["number?"] = number_3f, ["filter-keys"] = filter_keys}
