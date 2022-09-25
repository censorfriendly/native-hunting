
local firstspawn = 0
local seller = nil

AddEventHandler('playerSpawned', function(spawn)
	if firstspawn == 0 or seller == nil then
    seller = createSellNPC()
		firstspawn = 1
	end
end)

AddEventHandler('onClientResourceStart', function()
	if firstspawn == 0 or seller == nil then
    seller = createSellNPC()
		firstspawn = 1
	end
end)

AddEventHandler('onClientResourceStop', function()
	if seller ~= nil then
    seller = DeletePed(seller)
	end
end)

AddEventHandler("hunting:spawnAnimal", function(hash,location,aggressive)
    print("Waittime")
    local waittime = math.random(4,12) * 10000
	Wait(waittime)
    print("creating npc")
    local ped = createNPC(hash, location, 0, aggressive);
	LAnimals[#LAnimals].ped = ped
    print("should create and now delete the prop")
    DeleteEntity(LAnimals[#LAnimals].bait)
end)