-- TODO: local-ize
ffi = require("ffi")

ffi.cdef[[
int nvimx11_test(int x);
char* nvimx11_getsel(int name, int* type, size_t* len);
]]
--libnvimX11 = ffi.load("build/libnvimX11.so")
--
if count == nil then
  count = 0
end
count = count + 1
name = "/tmp/x"..count..".so"
os.execute("cp build/libnvimX11.so "..name)
libnvimX11 = ffi.load(name)

seltype = ffi.new("int[1]")
selsize = ffi.new("size_t[1]")
print(libnvimX11.nvimx11_test(3))

function get()
  p = libnvimX11.nvimx11_getsel(string.byte('*',1), seltype, selsize)
  str = ffi.string(p, selsize[0])
  return str, seltype[0]
end
return {get=get}

