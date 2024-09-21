local add = {}
local functions = {
  io={},
  io.write = [[getgenv().print = function(msg)
    print("Secment : " .. tostring(msg) .. "\n")
end]]
}

function add:function(name, child)
    if child==nil then
    local new = functions[name]
    loadstring(new)()
else
local new = functions[name][child]
    loadstring(new)()
end
end

return add
