assert(writefile, "Your exploit doesn't support writefile")
assert((setreadonly or make_writeable), "Your exploit doesn't support setreadonly or make_writeable")
assert((getnamecallmethod or get_namecall_method), "Your exploit doesn't support getnamecallmethod or get_namecall_method")
assert(getrawmetatable, "Your exploit doesn't support getrawmetatable")

local LogTable = {}
game.Players.PlayerRemoving:Connect(function(Player)
    if Player == game.Players.LocalPlayer then
        writefile("Remote Spy.txt", table.concat(LogTable,"\n"))
    end
end)

local meta = getrawmetatable(game)
local old = meta.__namecall

if setreadonly then
	setreadonly(meta, false)
else
	make_writeable(meta, true)
end

local callMethod = getnamecallmethod or get_namecall_method
local newClosure = newcclosure or function(f)
	return f
end

meta.__namecall = newClosure(function(Event, ...)
	local cmethod = callMethod()
    local fmethod = (tostring(cmethod) == "FireServer") or (tostring(cmethod) == "InvokeServer") or nil
	local arguments = {...}
	if fmethod then
        table.insert(LogTable, #LogTable + 1, tostring(Event)..":"..tostring(cmethod).." => "..table.unpack(arguments))
    end
	return old(Event, ...)
end)

if setreadonly then
	setreadonly(meta, true)
else
	make_writeable(meta, false)
end
