rarity = nil
animal = nil
reward = nil

RequestAnimSet('amb@medic@standing@kneel@base')
RequestAnimSet('anim@gangops@facility@servers@bodysearch@')

RegisterCommand("bait",function(source,args)

    -- add bait animation
    -- add requirement of having bait

    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)
    animal, reward = generateHunt(position)
    print(dump(reward))
end)

RegisterCommand("knife", function(source, args)

    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)
    peds = GetGamePool("CPed")
    local closestPed = nil
    for k,ped in pairs(peds) do
        local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped), true)
        if distanceCheck <= 1.5 and ped ~= GetPlayerPed(-1) and not IsPedAPlayer(ped)  then
            closestPed = ped
            break
        end
    end
    -- if closestPed == animal then 
        cleanCarcass(closestPed)
    -- else
        -- Send message that this isnt the animal you were hunting
    -- end
end)