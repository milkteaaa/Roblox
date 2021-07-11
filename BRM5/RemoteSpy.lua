local function formatargs(args,showkeys)
    if #args == 0 then return "N/A" end
    local strargs = {}
    for k,v in next,args do
        local argstr = ""
        if type(v) == "string" then
            argstr = "\"" .. v .. "\""
        elseif typeof(v) == "Instance" then
            argstr = "game."..v:GetFullName()
        elseif type(v) == "table" then
            argstr = "{" .. formatargs(v,true) .. "}"
        else
            argstr = tostring(v)
        end
        if showkeys and type(k) ~= "number" then
            table.insert(strargs,k.."="..argstr)
        else
            table.insert(strargs,argstr)
        end
    end
    return table.concat(strargs, ", ")
end

for _, v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v, "new")then
        if v.new and v.FireServer and v.InvokeServer then
            local v2 = v
            local fire = v2.FireServer
            local invoke = v2.InvokeServer
            
            function v2:FireServer(a,...)
                if a ~= "replicateCharacter" then
                    print(a, formatargs({...}))
                end
                return fire(v2,a,...)
            end
            function v2:InvokeServer(a2,...)
                print(a2, formatargs({...}))
                return invoke(v2, a2, ...)
            end
        end
    end
end
