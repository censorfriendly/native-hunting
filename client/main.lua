local rarity = nil
LAnimals = {}
local reward = nil
local timeout = TimeToBait
local huntingBlip = {}
lastSession = nil

-- Will be replaced and command will be a item used in inventory
RegisterCommand("bait",function(source,args)

    -- add bait animation
    -- add requirement of having bait
    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)
    local pass, alert =  checkHuntingArea(position)

    loadAnims()

    if pass and ( lastSession == nil or  lastSession + timeout < GetGameTimer()) then 
        -- we can hunt
        lastSession = GetGameTimer()
        if alert then 
            -- position variable for location of call
            print("ALERT PD ")
            TriggerEvent("hunting:pdalert",position)
        end
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 8.0, 0.0, -1, 0, 1.0, 0, 0, 0)
        local ainstance = generateHunt(position)
        table.insert(LAnimals,ainstance)
        Wait(5000)
        StopAnimTask(PlayerPedId(), "amb@medic@standing@kneel@base", "base")
        StopAnimPlayback(PlayerPedId(), 0, 0)
        ClearPedTasksImmediately(PlayerPedId())
        TriggerEvent("hunting:removeBait")
    else
        TriggerEvent("hunting:message","There are no animals in the area, you need to wait a bit")
    end
end)

-- Will be replaced and command will be a item used in inventory
RegisterCommand("knife", function(source, args)

    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)
    local closestPed = nil
    for ped in EnumeratePeds() do
        local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(ped), true)
        if distanceCheck <= 1.5 and ped ~= GetPlayerPed(-1) and not IsPedAPlayer(ped)  then
            closestPed = ped
            break
        end
    end
    local skinAnimal = nil;
    for k, v in pairs(LAnimals) do
        if closestPed == v.ped then 
            skinAnimal = v
        end
    end
    if skinAnimal ~= nil then 
        cleanCarcass(skinAnimal)
        LAnimals = checkCarcassEvent(LAnimals)
    else
        -- @SNAILY Send message that this isnt the animal you were hunting
        TriggerEvent("hunting:message","This is not the animal you were hunting")
    end
end)


Citizen.CreateThread(function()
    huntingBlip.icon = AddBlipForCoord(HuntingArea)
    SetBlipAlpha(huntingBlip.icon, 128)
    SetBlipSprite(huntingBlip.icon, 141)
    SetBlipDisplay(huntingBlip.icon, 4)
    SetBlipScale(huntingBlip.icon, 1.0)
    SetBlipColour(huntingBlip.icon, 5)
    SetBlipAsShortRange(huntingBlip.icon, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Hunting")
    EndTextCommandSetBlipName(huntingBlip.icon)

    huntingBlip.radius = AddBlipForRadius(HuntingArea,HuntingRadius)
    SetBlipColour(huntingBlip.radius, 6)
    SetBlipAlpha(huntingBlip.radius, 25)
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(100)
        local ped = GetPlayerPed(-1)
		if GetDistanceBetweenCoords(SellerLocation.x, SellerLocation.y, SellerLocation.z, GetEntityCoords(ped)) < 3.0 then
            if IsControlPressed(0,46) then 
                TriggerEvent("hunting:sell")
            end
		end
    end
end)

AddEventHandler('onPlayerWasted', function(deathCoords)
    LAnimals = removePeds(LAnimals)
end)