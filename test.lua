local add = {}
local functions = {
  io={},
  io.write = [[getgenv().print = function(msg)
    print("Secment : " .. tostring(msg) .. "\n")
end]]
}

function add:function(name)
    local new = functions[name]
    loadstring(new)()
end

return add
