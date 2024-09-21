local add = {}
local functions = {
    io = {},
    io.write = [[getgenv().print = function(msg)
        print("Secment : " .. tostring(msg) .. "\n")
    end]]
}

function add:func(path)
    local name, child = path:match("([^%.]+)%.([^%.]+)")
    
    if name and child then
        local new = functions[name .. "." .. child]
        loadstring(new)()
    else
        local new = functions[path]
        loadstring(new)()
    end
end

return add
