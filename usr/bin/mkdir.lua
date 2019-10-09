local tArgs = { ... }

if #tArgs < 1 then
    print( "mkdir: missing operand" )
    return
end

for _, v in ipairs( tArgs ) do
    local sNewDir = shell.resolve( v )
    if fs.exists( sNewDir ) and not fs.isDir( sNewDir ) then
        print( "mkdir: cannot create '" .. v .. "': File exists" )
    elseif fs.isReadOnly( sNewDir ) then
        print( "mkdir: cannot create directory '" .. v .. "': Permission denied" )
    else
        fs.makeDir( sNewDir )
    end
end