
local tArgs = { ... }
if #tArgs < 1 then
    shell.setDir('/home/' .. user)
    return
end

local sNewDir = shell.resolve( tArgs[1] )
if fs.isDir( sNewDir ) then
    shell.setDir( sNewDir )
else
    print( "ocsh: cd: " .. tArgs[1] .. ': No such file or directory' )
    return
end
