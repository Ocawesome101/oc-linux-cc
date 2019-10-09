-- Passwd --

local fileraw = fs.open('/etc/passwd','r')
local sContents = fileraw.read()
fileraw.close()
local tContents = textutils.unserialise(sContents)

print('passwd: Failed to connect to password service')
print('passwd: Reason: Still in development')
--[[
local function isCorrect(p)
 local file = fs.open('/etc/passwd','r')
 local passwords = {}
 os.loadAPI('/usr/lib/hash.lua')
 while true do
  local line = file.readLine()
  if line ~= nil then
   table.insert(passwords,hash.decrypt(line))
  else
   break
  end
 end
 os.unloadAPI('hash')
 if passwords[uid] == p then
  return true
 else
  return false
 end
end

print('Changing password for ' .. user)
write('Current password: ')
local pass = read('*')
if not isCorrect(pass) then
 os.sleep(1)
 print('passwd: Authentication failure')
 print('passwd: password unchanged')
else
 write('New password: ')
 local npass1 = read('*')
 write('Retype new password: ')
 local npass2 = read('*')
 if npass1 ~= npass2 then
  print('Sorry, passwords do not match.')
  print('passwd: Failed preliminary check by password service')
  print('passwd: password unchanged')
 else
  os.loadAPI('/usr/lib/hash.lua')
  local encoded = hash.encrypt(npass1)
  os.unloadAPI('hash')
  table.remove(tContents, uid)
  table.insert(tContents, uid, encoded)
  local sContents = textutils.serialise(tContents)
  local file = fs.open('/etc/passwd','w')
  file.write(sContents)
  file.close()
  print('passwd: password updated successfully')
 end
end
]]--