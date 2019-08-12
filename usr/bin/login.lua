-- Login script. Self-explanatory :) --

_G.users = {}

local old = os.pullEvent 
os.pullEvent = os.pullEventRaw 

local file = fs.open('/etc/users','r')
while true do
 local usr = file.readLine()
 if usr ~= nil then
  table.insert(users,usr)
 else
  break
 end
end

file.close()

local passwords = {}
local encrypted = {}

os.loadAPI('/usr/lib/hash.lua')

local file = fs.open('/etc/passwd','r')
while true do
 local line = file.readLine()
 if line ~= nil then
  table.insert(encrypted,line)
 else
  break
 end
end

for i=1, #encrypted do
 table.insert(passwords,hash.decrypt(encrypted[i]))
end

local function password()
 write('Password: ')
 local pass = read('*')
 return pass
end

local function user()
 write(_HOSTNAME..' login: ')
 local user = read()
 return user
end

local function detectUser(u)
 for i=1, #users do
  if users[i] == u then
   return i 
  end
  i = i + 1
 end
 return nil
end

while true do
 local loginUser = user()
 local loginPassword = password()
 local uid = detectUser(loginUser)

 if uid == nil then
  print('Login incorrect')
 elseif passwords[uid] == loginPassword then
  _G.uid = uid
  _G.user = loginUser
  os.unloadAPI('hash')
  print('')
  shell.run('/bin/ocsh.lua')
 else
  print('Login incorrect')
  os.sleep(1)
 end
 term.clear()
 term.setCursorPos(1,2)
end
