-- Which

local args = {...}

if args[1] then
 local path = shell.resolveProgram(args[1])
 if path and path ~= "" then
  if path:sub(-4) == '.lua' then
   path = path:sub(1,-5)
  end
  if not path:sub(1,1) == '/' then
   path = '/' .. path
  end
  print(path)
 else
  print('which: ' .. args[1] .. ' not found in (' .. shell.path() .. ')')
 end
else
 print('Usage: which COMMAND')
end
