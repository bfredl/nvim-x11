-- TODO: local-ize
local ffi = require("ffi")

local path = vim.api.nvim_get_var("nvimx11_path")
print(path)

ffi.cdef[[
int nvimx11_test(int x);
char* nvimx11_getsel(int name, int* type, size_t* len);
bool nvimx11_putsel(int name, int type, const char* data, size_t len);
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

local function put(sel,data,typename)
  if type(data) ~= "string" then
    error("data must be string")
  end
  libnvimX11.nvimx11_putsel(string.byte(sel,1), typeids[typename], data, string.len(data))
end
return {get=get, put=put}

