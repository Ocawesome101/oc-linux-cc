-- Boot script for OC-MBR. Fits inside 446 bytes :D --
_G.sys = {}
-- Set up stdio
_G.stdin = ''
_G.stdout = ''
for name,cmd in pairs(shell.aliases()) do
 shell.clearAlias(name)
end
function sys.log(status,color,message)
 term.setTextColor(colors.white)
 write('[ ')
 term.setTextColor(color)
 write(status)
 term.setTextColor(colors.white)
 print(' ] '..message)
end
term.clear()
term.setCursorPos(1,1)
shell.run('/boot/syslinux/bootCC.boot')
