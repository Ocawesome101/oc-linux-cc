-- Echo --

local args = {...}

if not args[1] then print('') return end

if args[1] then
 local e = ''
 for i=1, #args do
  e = e .. args[i] .. ' '
  i = i + 1
 end
 print(e)
end