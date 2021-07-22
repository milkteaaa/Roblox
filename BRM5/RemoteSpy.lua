--[[
for network script:
Network:FireServer("interactObject", 1)
Network:FireServer("npcTalk", 2)
Network:InvokeServer("equipTool", 1)
Network:FireServer("resetCharacter")
Network:FireServer("useMedical", 1)
]]

local function formatargs(args,showkeys)
    if #args == 0 then 
        return "N/A" 
    end

    local strargs = {}

    for k,v in pairs(args) do
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

for _,Table in pairs(getgc(true)) do
    if typeof(Table) == "table" and rawget(Table,"FireServer") then
        if Table.FireServer and Table.InvokeServer then
            local NetTable = Table

            local oldFire = NetTable.FireServer
            local oldInvoke = NetTable.InvokeServer
            
            function NetTable:FireServer(type, ...)
                if type ~= "replicateCharacter" then
                    print("Network:FireServer(\"" .. type .. "\", " .. formatargs({...}) .. ")")
                end
                return oldFire(NetTable, type, ...)
            end
            
            function NetTable:InvokeServer(type, ...)
                print("Network:InvokeServer(\"" .. type .. "\", " .. formatargs({...}) .. ")")
                return oldInvoke(NetTable, type, ...)
            end
        end
    end
end
