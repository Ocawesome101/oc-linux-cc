-- Cat --

local args = {...}

if not args[1] then
 print('Type EOF to exit')
 while true do
  local text = read()
  print(text)
  if text == 'EOF' then
   break
  end
 end
else
 local path = shell.resolve(args[1])
 if not fs.exists(path) then
  print('cat: ' .. args[1] .. ': No such file or directory')
 elseif fs.isDir(path) then
  print('cat: ' .. args[1] .. ': Is a directory')
 else
  local fileraw = fs.open(path,'r')
  local file = fileraw.readAll()
  fileraw.close()
  print(file)
 end
end