-- CP --

local tArgs = { ... }
if #tArgs < 2 then
    print( "cp: missing file operand" )
    return
end

local sFile = shell.resolve( tArgs[1] )
local sDest = shell.resolve( tArgs[2] )
if fs.exists( sDest ) then
    print('cp: ' .. sDest .. ': File exists')
else
    if fs.exists( sFile ) then
        fs.copy(sFile, sDest)
    else
        print("cp: cannot stat '" .. sFile .. "': No such file or directory")
    end
end
