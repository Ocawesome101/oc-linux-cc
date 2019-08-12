-- Very weak encoding --

function encrypt(text)
 --for i=1, string.len(text) do
  --table.insert(tIn,text:sub(i,i))
  --i = i + 1
 --end
 tOut = string.reverse(string.rep(text,3))
 return tOut
end

function decrypt(text)
 local len = string.len(text)/3
 local str = text:sub(1,len)
 local rtn = string.reverse(str)
 return rtn
end
