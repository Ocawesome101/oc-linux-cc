-- Init script for OC Linux --

_G._CCINIT_VERSION = '0.2.2-09-0-cc'

_G.ccinit = {}

function ccinit.shutdown()
 syslog('ccinit[1]: Unloading system modules')
 syslog('ccinit[1]: Unmounting disks')
 syslog('ccinit[1]: Unmounted disks')
 syslog('ccinit[1]: Exiting ccinit')
 kernel.halt()
end

function ccinit.reboot()
 syslog('ccinit[1]: Unloading system modules')
 syslog('ccinit[1]: Unmounting disks')
 syslog('ccinit[1]: Unmounted disks')
 syslog('ccinit[1]: Exiting ccinit')
 kernel.restart()
end


syslog('ccinit[1]: ccinit '.._CCINIT_VERSION..' running in system mode.')
syslog('ccinit[1]: Detected architecture '..cpu.arch)
local file = fs.open('/etc/hostname','r')
_G._HOSTNAME = file.readAll()
file.close()
os.setComputerLabel(_HOSTNAME)
syslog('ccinit[1]: Set hostname to <'.._HOSTNAME..'>')
syslog('ccinit[1]: Finding peripherals')
local sides = {'top','bottom','left','right','back'}
for i=1, #sides do
 if disk.isPresent(sides[i]) then
  syslog('ccinit[1]: Mounted disk from side '..sides[i]..' at '..disk.getMountPath(sides[i]))
 end
 i = i + 1
end

syslog('ccinit[1]: Welcome to OC Linux!')
if not cpu.isfull then
 syslog('ccinit[1]: warn: Non-advanced computers are not officially supported')
end

if not _G.craftOS_version == 'CraftOS 1.8' then
 syslog('ccinit[1]: warn: Only CraftOS 1.8 is officially supported')
end
syslog('ccinit[1]: Initializing modules necessary for the system')
_G.stdin = ''
_G.stdout = ''
_G.stderr = ''
shell.run('/usr/bin/login.lua')
