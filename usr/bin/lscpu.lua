-- LSCPU --

local cpuarch = cpu.arch
local cpuid = cpu.id
local opmodes = '32-bit'
local cores = '1'
local vendorid = 'ComputerCraft'
local khz = cpu.clock

local virt = 'none'

local flags = 'lua51 cc novirt'

-- Detect available cpu features
if cpuarch == 'CC6451' then
 opmodes = opmodes .. ', 64-bit'
end

print('Architecture:', cpuarch)
print('CPU op-mode(s):', opmodes)
print('CPU(s):', cores)
print('Vendor ID:', vendorid)
print('Model name:', cpuid)
print('Virtualization:', virt)
print('Flags:', flags)
