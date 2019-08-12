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
elseif not fs.exists(args[1]) then
 print('cat: ' .. args[1] .. ': No such file or directory')
elseif fs.isDir(args[1]) then
 print('cat: ' .. args[1] .. ': Is a directory')
else
 local fileraw = fs.open(args[1],'r')
 local file = fileraw.readAll()
 fileraw.close()
 print(file)
end
