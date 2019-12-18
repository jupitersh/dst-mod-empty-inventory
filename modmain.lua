AddComponentPostInit("playerspawner", function(PlayerSpawner, inst) 
	inst:ListenForEvent("ms_playerdespawn", function (inst, player) 
		if player and player.components.inventory and player.dontdrop ~= true then 
			player.components.inventory:DropEverything(false,false) 
		end 
	end) 
end)

AddPlayerPostInit(function(inst)

	local _OnSave = inst.OnSave
	inst.OnSave = function(inst, data)
		if _OnSave then
			_OnSave(inst, data)
		end
		data.dontdrop = inst.dontdrop
	end

	local _OnLoad = inst.OnLoad
	inst.OnLoad = function(inst, data)
		if _OnLoad then
			_OnLoad(inst, data)
		end
		inst.dontdrop = data and data.dontdrop
	end

end)

local function Whitelist(num)
	local player = GLOBAL.AllPlayers[num]
	if player then
		player.dontdrop = true
		print("Player ", player.name, " using ", player.prefab, " with id ", player.userid, " got added to the whitelist.")
	end
end

local function Outlist(num)
	local player = GLOBAL.AllPlayers[num]
	if player then
		player.dontdrop = nil
		print("Player ", player.name, " using ", player.prefab, " with id ", player.userid, " got removed from the whitelist.")
	end
end

local function SeeList()
	print("Start whitelist")
	for k, v in pairs(GLOBAL.AllPlayers) do
		if v.dontdrop then
			print("Player ", v.name, " using ", v.prefab, " with id ", v.userid)
		end
	end
	print("End whitelist")
end

function c_listallplayers()
    for i, v in ipairs(GLOBAL.AllPlayers) do
        print(string.format("[%d] %s <%s>", i, v.name, v.prefab))
    end
end


GLOBAL.addlist = Whitelist

GLOBAL.rmlist = Outlist

GLOBAL.list = SeeList

GLOBAL.player = c_listallplayers