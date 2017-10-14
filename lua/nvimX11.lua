-- TODO: local-ize
local ffi = require("ffi")

local path = vim.api.nvim_get_var("nvimx11_path")
print(path)

ffi.cdef[[
int nvimx11_test(int x);
char* nvimx11_getsel(int name, int* type, size_t* len);
bool nvimx11_setsel(int name, int type, const char* data, size_t len);
]]
libnvimX11 = ffi.load(path.."/build/libnvimX11.so")

seltype = ffi.new("int[1]")
selsize = ffi.new("size_t[1]")
--print(libnvimX11.nvimx11_test(3))
--
local typenames = {[0] = "v", [1] = "V", [2] = "b"}
local typeids= {v=0,V=1,b=2}

local function get(sel)
  p = libnvimX11.nvimx11_getsel(string.byte(sel,1), seltype, selsize)
  str = ffi.string(p, selsize[0])
  typename = typenames[seltype[0]] or ""
  return str, typename
end

local function set(sel,str,typename)
  if type(str) ~= "string" then
    error("strmust be string")
  end
  libnvimX11.nvimx11_setsel(string.byte(sel,1), typeids[typename], str, string.len(str))
end
return {get=get, set=set}

