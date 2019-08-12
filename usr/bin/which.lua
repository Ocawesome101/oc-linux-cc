-- Which

local args = {...}

if args[1] then
 local path = shell.resolveProgram(args[1])
 if path:sub(-4) == '.lua' then
  path = path:sub(1,-5)
 end
 print(path)
else
 print('Usage: which COMMAND')
end
