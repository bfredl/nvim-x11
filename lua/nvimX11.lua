ffi = require("ffi")

if count == nil then
    count = 0
end

ffi.cdef[[
int nvimx11_test(int x);
]]
--libnvimX11 = ffi.load("build/libnvimX11.so")
count = count + 1
name = "/tmp/x"..count..".so"
os.execute("cp build/libnvimX11.so "..name)
libnvimX11 = ffi.load(name)

print(libnvimX11.nvimx11_test(3))

