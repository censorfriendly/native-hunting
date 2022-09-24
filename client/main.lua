rarity = nil
local animal = nil
local reward = nil
local timeout = TimeToBait
local huntingBlip = {}

RegisterCommand("bait",function(source,args)

    -- add bait animation
    -- add requirement of having bait
    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)

    local pass, alert =  checkHuntingArea(position)

    if pass then 
        -- we can hunt
        if alert then 
            -- position variable for location of call
            -- ADD PD ALERT FUNCTION HERE SNAILY/FRAMEWORK CALL
            print("ALERT PD ")
        end
        animal, reward = generateHunt(position)
        
        RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
        RequestAnimDict("amb@medic@standing@kneel@base")
    end
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
        -- @SNAILY Send message that this isnt the animal you were hunting
    -- end
end)


Citizen.CreateThread(function()

    -- for _, info in pairs(blips) do
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
        local coords = vector3(0.0, 0.0, 0.0)
    --   end

end)