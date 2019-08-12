
local tArgs = { ... }
if #tArgs < 2 then
    print( "cp: missing file operand" )
    return
end

local sSource = shell.resolve( tArgs[1] )
local sDest = shell.resolve( tArgs[2] )
if fs.exists( sDest ) then
    write( "cp: overwrite '" .. sDest .. "'? " )
    if string.lower(read()) == 'y' then
        fs.copy(sFile, sDest)
    else
        fs.copy(sFile, sDest)
    end
else
    print( "cp: cannot stat '" .. sFile .. "': No such file or directory" )
    return
end
