
local function printUsage()
    print( "wget: missing URL or filename" )
    print( "Usage: wget <URL> <FILENAME>" )
end
 
local tArgs = { ... }
if #tArgs < 2 then
    printUsage()
    return
end
 
if not http then
    printError( "wget requires the http API" )
    printError( "Set http_enable to true in ComputerCraft.cfg" )
    return
end
 
local function get( sUrl )
    write( "Connecting to " .. sUrl .. "... " )

    local ok, err = http.checkURL( sUrl )
    if not ok then
        print( "Failed: " .. ( err or "" ) )
        return nil
    end

    local response = http.get( sUrl , nil , true )
    if not response then
        print( "Failed." )
        return nil
    end

    local sResponse = response.readAll()
    response.close()
    return sResponse
end

if tArgs[2] then
    -- Determine file to download
    local sUrl = tArgs[1]
    local sFile = tArgs[2]
    local sPath = shell.resolve( sFile )
    if fs.exists( sPath ) then
        print( "File already exists" )
        return
    end

    -- Do the get
    local res = get( sUrl )
    if res then
        local file = fs.open( sPath, "wb" )
        file.write( res )
        file.close()

        print( "Downloaded as "..sFile )
    else
        return
    end
end
