local args = table.pack(...)

if args.n < 1 then
    print("rm: missing operand")
    return
end

for i = 1, args.n do
    local files = fs.find(shell.resolve(args[i]))
    if #files > 0 then
        for n, file in ipairs(files) do
            fs.delete(file)
        end
    else
        print("rm: cannot remove '" .. args[i] .. "': No such file or directory")
    end
end