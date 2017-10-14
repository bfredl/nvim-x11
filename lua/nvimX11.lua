-- TODO: local-ize
ffi = require("ffi")

ffi.cdef[[
int nvimx11_test(int x);
char* nvimx11_getsel(int name, int* type, size_t* len);
bool nvimx11_putsel(int name, int type, const char* data, size_t len);
]]
libnvimX11 = ffi.load("build/libnvimX11.so")

seltype = ffi.new("int[1]")
selsize = ffi.new("size_t[1]")
--print(libnvimX11.nvimx11_test(3))

local function get(sel)
  p = libnvimX11.nvimx11_getsel(string.byte(sel,1), seltype, selsize)
  str = ffi.string(p, selsize[0])
  return str, seltype[0]
end

local function put(sel,data,seltype)
  if type(data) ~= "string" then
    error("data must be string")
  end
  libnvimX11.nvimx11_putsel(string.byte(sel,1), seltype, data, string.len(data))
end
return {get=get, put=put}

