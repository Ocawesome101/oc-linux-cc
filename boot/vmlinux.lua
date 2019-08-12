-- The OC Linux kernel. --

-- Functions
_G.KV = 'Linux version 0.6.0-1-OC (CC version 1.8) Thurs Aug 8 20:23:03 UTC 2019'

local old = os.pullEvent 

os.pullEvent = os.pullEventRaw 

_G.kernel = {}
_G.display = {}

_G.biosTime = os.time()

_G.getTime = function()
 return os.time() - biosTime
end

function kernel.halt()
 log('Fast shutdown: no')
 log('Spectre V2: no mitigations to disable')
 local dirs = {'/proc','/run','/tmp','/sys','/dev','/mnt'}
 for i=1, #dirs do
  fs.delete(dirs[i])
  i = i + 1
 end
 log('devtmpfs: uninitialized')
 log('pci_bus 0000:00: computercraft display')
 log('ACPI: bus type PCI unregistered')
 log('cc6451: PNP: No PS/2 controller to uninitialize')
 log('CC-FS (ccd1): unmounted filesystem')
 log('ACPI: bus type CCDB unregistered')
 log('Calling ACPI shutdown')
 _LOG.close()
 os.shutdown()
end

function kernel.restart()
 log('Fast shutdown: no')
 log('Spectre V2: no mitigations to disable')
 local dirs = {'/proc','/run','/tmp','/sys','/dev','/mnt'}
 for i=1, #dirs do
  fs.delete(dirs[i])
  i = i + 1
 end
 log('devtmpfs: uninitialized')
 log('pci_bus 0000:00: computercraft display')
 log('ACPI: bus type PCI unregistered')
 log('cc6451: PNP: No PS/2 controller to uninitialize')
 log('CC-FS (ccd1): unmounted filesystem')
 log('ACPI: bus type CCDB unregistered')
 log('Calling ACPI reboot')
 _LOG.close()
 os.reboot()
end

function kernel.panic(reason)
 syslog('Kernel panic: '..reason)
 syslog('Press R to shutdown')
 local file = fs.open('/var/log/panic.log','w')
 file.write('[ '..getTime()..' ] Kernel panic: '..reason)
 file.close()
 while true do
  local e,id = os.pullEventRaw()
  if e == 'char' then
   if id == 'r' then
    os.shutdown()
   end
  end
 end
end

function kernel.version()
 return _G.KV
end

function os.version()
 return kernel.version()
end

function display.getSize()
 return term.getSize()
end

-- Set up logging
if fs.exists('/var/log/dmesg.log.old') then
 fs.delete('/var/log/dmesg.log.old')
end

if fs.exists('/var/log/dmesg.log') then
 fs.move('/var/log/dmesg.log','/var/log/dmesg.log.old')
end
_G._LOG = fs.open('/var/log/dmesg.log','a')

function _G.log(string)
 local time = tostring(getTime()):sub(1,4)
 local out = '[ '..time..' ] '..string
 print(out)
 _LOG.write(out..'\n')
 os.sleep(0.0001)
end

function _G.syslog(str)
 log(str)
end

-- Function to get approximate CPU speed
local function getClock()
 local ct = {}
 local cc = 20

 for i=1, cc do
  clock = os.clock()
  stop = clock + (1/cc)
  local c = 0
  while clock < stop do
   clock = os.clock()
   c = c + 1
  end
  table.insert(ct,c)
 end
 local t = 0
 
 for k,v in pairs(ct) do
  t = t + v 
 end
 
 local function rd(va,pl)
  return math.floor((va/pl) + 0.5) * pl
 end
 
 local avg = t / cc 
 local hz = avg * 20
 local khz = rd((hz/1000),0.001)

 return khz
end

--Startup
cpuid = 'ComputerCraft CC6451'
_G._ARCH, _G._CPUID = 'CC6451', cpuid

log(os.version())
log('KERNEL supported cpus:')
log(' ComputerCraft CC6451')
log('secureboot: No secure boot detected')
if term.isColor() then
 pcid = 'ComputerCraft Advanced Computer'
 hwid = pcid..'/Color Computer'
else
 pcid = 'ComputerCraft Standard Computer'
 hwid = pcid..'/Grayscale Computer'
end
log('DMI: '..hwid)
log('ACPI: Supported ACPI: shutdown, reboot')
log('ACPI: Suspend and sleep are not supported')
log('Booting nonvirtualized kernel on ComputerCraft hardware')
log('DMAR: IOMMU not enabled: unsupported CPU architecture CC6451')

local cpuspeed = getClock()

log('Detected '..cpuspeed..'KHz processor')

log('CPU: Physical Processor ID: 0')
log('CPU: Processor Core ID: 0')
log('CPU0: Thermal monitoring disabled (not needed)')
log('Spectre V2: Unaffected CPU architecture')
log('Spectre V2: Mitigation not enabled')
log('smpboot: CPU0: '..cpuid)
log('Performance Events: Lua5.1 events')
log('smp: Bringing up secondary CPUs ...')
log('smp: No secondary CPUs found')
log('smp: brought up 0 node, 1 CPUs')
log('smpboot: Total of 1 processors activated')
log('devtmpfs: initialized')
log('ACPI: bus type PCI registered')
log('pci_bus 0000:00: computercraft display')
log('PCI-DMA: Using software rendering for display')
log('efifb: dmi detected '..pcid..' - software rendering enabled')
local w,h = display.getSize()
if term.isColor() then
 depth = 4
else
 depth = 1
end
log('efifb: mode is '..tostring(w)..'x'..tostring(h)..'x'..tostring(depth))
log('cc6451: PNP: No PS/2 controller found.')
log('ACPI: bus type CCDB registered')
log('ccdb1: CCDB size '..fs.getSize('/'))

local dirs = {'/proc','/run','/tmp','/sys','/dev'}
for i=1, #dirs do
 fs.makeDir(dirs[i])
end
log('CC-FS (ccd1): mounted filesystem with ordered data mode')
shell.run('/sbin/ccinit.lua')
