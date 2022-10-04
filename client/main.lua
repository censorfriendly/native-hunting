local rarity = nil
LAnimals = {}
local reward = nil
local timeout = TimeToBait
local huntingBlip = {}
lastSession = nil
QBCore = exports['qb-core']:GetCoreObject()

-- Will be replaced and command will be a item used in inventory


RegisterNetEvent('native-hunting:client:bait', function()
   -- add bait animation
    -- add requirement of having bait
    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)
    local pass, alert =  checkHuntingArea(position)

    if pass and ( lastSession == nil or  lastSession + timeout < GetGameTimer()) then 
        -- we can hunt
        TriggerServerEvent("hunting:removeBait")
        lastSession = GetGameTimer()
        if alert then 
            -- position variable for location of call
            TriggerEvent("hunting:pdalert",position)
        end
        TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 8.0, 0.0, -1, 0, 1.0, 0, 0, 0)
        local ainstance = generateHunt(position)
        table.insert(LAnimals,ainstance)
        QBCore.Functions.Progressbar('baitbar', 'Placing bait', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
            }, {}, {}, {}, function()
                -- This code runs if the progress bar completes successfully
                StopAnimTask(PlayerPedId(), "amb@medic@standing@kneel@base", "base")
                StopAnimPlayback(PlayerPedId(), 0, 0)
                ClearPedTasksImmediately(PlayerPedId())
            end, function()
                -- This code runs if the progress bar gets cancelled
                StopAnimTask(PlayerPedId(), "amb@medic@standing@kneel@base", "base")
                StopAnimPlayback(PlayerPedId(), 0, 0)
                ClearPedTasksImmediately(PlayerPedId())
        end)
    else
        TriggerEvent("hunting:message","There are no animals in the area, you need to wait a bit",'error')
    end

end)

RegisterNetEvent("native-hunting:client:knife", function()
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
        TriggerEvent("hunting:message","This is not the animal you were hunting",'error')
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

AddEventHandler('onPlayerWasted', function(deathCoords)
    LAnimals = removePeds(LAnimals)
end)


CreateThread(function()
    while true do
        local sleep = 1000
        if LocalPlayer.state['isLoggedIn'] then
            local pos = GetEntityCoords(PlayerPedId())
            local distance = #(pos - vector3(SellerLocation.x, SellerLocation.y, SellerLocation.z))
            if distance < 10 then
                if distance < 1.5 then
                    sleep = 0
                    DrawText3Ds(SellerLocation.x, SellerLocation.y, SellerLocation.z, 'Open Shop')
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent("hunting:client:openMenu")
                        sleep = 100
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('QBCore:Client:UpdateObject', function()
	QBCore = exports['qb-core']:GetCoreObject()
end)