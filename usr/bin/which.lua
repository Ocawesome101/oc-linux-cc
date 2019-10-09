-- Which

local args = {...}

if args[1] then
 local path = shell.resolveProgram(args[1])
 if path:sub(-4) == '.lua' then
  path = path:sub(1,-5)
 end
 if not path:sub(1,1) == '/' then
  path = '/' .. path
 end
 print(path)
else
 print('Usage: which COMMAND')
end