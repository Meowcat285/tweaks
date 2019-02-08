#!/var/tweak/com.r333d.eqe/bin/luajit

--[[
The abysmal state of stashing on iOS 10 forces
me to do it like this. Else the app will take up
a few MB on the system partition, which is unacceptable,
since there is only 60MB of space on some iOS 10 devices

Also, I'm not using bash (like most other apps do it)
because it isn't compiled for arm64. So it'd give you that
"The developer hasn't optimized this app for arm64" popup

The only reason why I'm using luajit (instead of a
custom compiled version of bash) is because it's
already bundled with EQE... so why not

All of this code would be the equivalent of this in bash:
exec /Applications/EQE.app/EQE $@
]]

local ffi = require 'ffi'
ffi.cdef[[
int execv(const char *path, char *const argv[]);
]]

arg[0] = '/Applications/EQE.app/EQE'
local argv = ffi.new('char *[?]', #arg + 2)
for i=0,#arg do
    local v = arg[i]
    argv[i] = ffi.new('char[?]', #v + 1, v)
end
argv[#arg + 1] = nil

return ffi.C.execv(arg[0], argv)
