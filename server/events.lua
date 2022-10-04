QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent("hunting:removeBait",function()
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem('bait', 1) then 
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bait'], "remove")
    end
end)

RegisterServerEvent("hunting:reward",function(items,count)
    local Player = QBCore.Functions.GetPlayer(source)
    for key,value in pairs(items) do 
        if Player.Functions.AddItem(value, count) then 
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[value], "add")
        end
    end
end)

QBCore.Functions.CreateCallback('hunting:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    return cb(inventory)
end)

RegisterNetEvent('QBCore:Server:UpdateObject', function()
    print("qbcore update object")
	if source ~= '' then return false end
	QBCore = exports['qb-core']:GetCoreObject()
end)

RegisterNetEvent('onResourceStart', function()
    print("server resource start")
    QBCore.Functions.AddItems({
        -- Hunting Items
        ['bait']					 = {['name'] = 'bait', 				    ['label'] = 'Bait', 				['weight'] = 500, 		['type'] = 'item', 		['image'] = 'printerdocument.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A smelly bait to attract animals'},
        ['hide']					 = {['name'] = 'hide', 				    ['label'] = 'Hide', 				['weight'] = 30000, 	['type'] = 'item', 		['image'] = 'hide.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	   ['combinable'] = nil,   ['description'] = 'A skin of an animal'},
        ['rawmeat']					 = {['name'] = 'rawmeat', 			    ['label'] = 'Raw Meat', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'raw-meat.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	   ['combinable'] = nil,   ['description'] = 'Meat of an animal'},
        ['dog_skin']			     = {['name'] = 'dog_skin', 			    ['label'] = 'Dog Skin', 			['weight'] = 30000, 		['type'] = 'item', 		['image'] = 'dog-fur.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	   ['combinable'] = nil,   ['description'] = 'A sking of a dog'},
        ['rabbit_meat']			     = {['name'] = 'rabbit_meat', 			['label'] = 'Rabbit Meat', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rabbit.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	   ['combinable'] = nil,   ['description'] = 'Meat of a rabbit'},
        ['rabbit_foot']			     = {['name'] = 'rabbit_foot', 			['label'] = 'Rabbit Foot', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'rabbit-foot.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	   ['combinable'] = nil,   ['description'] = 'Foot of a rabbit'},
        ['hawk_claw']			     = {['name'] = 'hawk_claw', 			['label'] = 'Hawk Claw', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'hawk-claw.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	   ['combinable'] = nil,   ['description'] = 'Claw of a hawk'},
        ['beef']			         = {['name'] = 'beef', 			        ['label'] = 'Beef', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'beef.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	   ['combinable'] = nil,   ['description'] = 'Prime Beef'},
        
        -- Weapons
        ['weapon_hunting_rifle'] 			 = {['name'] = 'weapon_hunting_rifle', 	 	  	['label'] = 'Hunting Rifle', 			['weight'] = 1000, 		['type'] = 'weapon', 	['ammotype'] = 'AMMO_SNIPER',			['image'] = 'weapon_sniperrifle.png', 	 ['unique'] = true, 	['useable'] = false, 	['description'] = 'A high-precision, long-range hunting rifle'},
        ['hunting_knife'] 			 = {['name'] = 'hunting_knife', 	 	  	['label'] = 'Hunting Knife', 			['weight'] = 1000, 		['type'] = 'item', 	['image'] = 'weapon_knife.png', 	 ['unique'] = true, 	['useable'] = true, 	['description'] = 'A short hunting knife'},
    })
end)