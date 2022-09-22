
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