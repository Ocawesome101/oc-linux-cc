-- Basically a BIOS --

bios = {}

craftOS_version = os.version()

bios.version = function()
 return "OCBios version 0.02"
end

-- os.version() should be redefined by your OS
os.version = function()
 return "None"
end

local tBootOpts = {'/'}
local path = '/'

local function log(msg)
 term.setTextColor(colors.white)
 write('[ ')
 term.setTextColor(colors.blue)
 write('info')
 term.setTextColor(colors.white)
 print(' ] '..msg)
 os.sleep(0.0001)
end

local function boot(bootPath)
 local p = '/'..bootPath..'/.mbr/boot.lua'
 print('Trying to boot from '..p)
 if not fs.exists(bootPath) then
  printError('Error: No bootable medium found.')
  os.sleep(4)
  os.shutdown()
 else
  shell.run(p)
 end
end

local function post()
 local isDisk = function(side)
  if disk.isPresent(side) then
   log('Found disk at side '..side)
   if disk.getLabel(side) ~= nil then
    log('Disk label is '..disk.getLabel(side))
   else
    log('Disk at side '..side..' has no label, setting to \'drive_'..side..'\'')
    disk.setLabel(side,'drive_'..side)
   end
   if disk.hasData(side) then
    log('Disk at side '..side..' contains data')
    log('Disk mount point is at '..disk.getMountPath(side))
    table.insert(tBootOpts,disk.getMountPath(side))
   end
  else
   log('No disk at side '..side)
  end
 end
 local sides = {'top','bottom','left','right','back'}
 for i=1, #sides do
  isDisk(sides[i])
  i = i + 1
 end
 log('Keyboard detected')
end

local function menu()
 print('Disk: Path')
 for i=1, #tBootOpts do
  print(tostring(i)..': '..tBootOpts[i])
 end
 write('Choice> ')
 local opt = tonumber(read())
 local path = tBootOpts[opt]
 return path
end

term.clear()
term.setCursorPos(1,1)
print(bios.version())
print('Press F5 for boot menu') -- fn+f5 for Mac users
post()

local bootTimer = os.startTimer(1.5)
while true do
 local e,id = os.pullEvent()
 if e == 'timer' and id == bootTimer then
  break
 end
 if e == 'key' then
  if id == keys.f5 then
   path = menu()
   break
  end
 end
end

boot(path)
