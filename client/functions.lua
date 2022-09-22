function createSellNPC()
    RequestModel(SellerHash)
    while not HasModelLoaded(SellerHash) do
        Wait(10)
    end
    
    local created_ped = CreatePed(1, SellerHash , vector3(SellerLocation.x,SellerLocation.y,SellerLocation.z -1), SellerLocation.rotation, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    return created_ped
end

function createNPC(hash,location,rotation,aggressive)
    local modelHash = hash
    local waittime = math.random(2,12) * 10000
    RequestModel(modelHash)
    local spawned = false
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    -- Wait(waittime)
    local spawnCoords = GetSpawnCoords(location)

    local created_ped = CreatePed(1, modelHash , spawnCoords, rotation, true,true)

    if aggressive then 
        TaskCombatPed(created_ped,GetPlayerPed(-1),0,16)
    else
        TaskWanderInArea(created_ped, location,20,12,8.4)
    end

    return created_ped
end

function generateHunt(location)
    local odds = math.random(1,100)
    local pedList = nil
    local hash = nil
    local aggressive = false

    if odds < 75 then
        pedList = spawnablePeds["common"]
        rarity = 1
    elseif odds < 90 then
        pedList = spawnablePeds["uncommon"]
        rarity = 2
    elseif odds < 97 then
        pedList = spawnablePeds["rare"]
        rarity = 4
    else 
        pedList = spawnablePeds["epic"]
        rarity = 4
    end
    if (odds % 10 == 0) then
        pedList = pedList['aggressive']
        aggressive = true
    else
        pedList = pedList['nonaggressive']
    end
    local key = math.random(1, GetTableLng(pedList))
    local getN = 1
    for hashkey in pairs(pedList) do 
        if(getN == key) then
            animal = pedList[hashkey]
            hash = hashkey
        end
        getN = getN + 1
    end
    return createNPC(hash,location, 0,aggressive), animal
end

function cleanCarcass(ped)

    RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
    RequestAnimDict("amb@medic@standing@kneel@base")

	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "base", 8.0, 0.0, -1, 0, 1.0, 0, 0, 0)
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 8.0, 0.0, -1, 0, 1.0, 0, 0, 0)
    Wait(5000)

	StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "base")
	StopAnimTask(PlayerPedId(), "amb@medic@standing@kneel@base", "base")
	StopAnimPlayback(PlayerPedId(), 0, 0)
	ClearPedTasksImmediately(PlayerPedId())
    -- Send rewards, add pelts to inventory
    sendRewards()
     -- DeletePed(ped)
end

function sendRewards()
    print(rarity)
    print(reward)
end


function GetSpawnCoords(coords)

local radius = 50.0

local x = coords.x + math.random(-radius, radius)
local y = coords.y + math.random(-radius, radius)

local spawnOnPavement = false -- Change this if you want to spawn the ped on the nearest pavement

local foundSafeCoords, safeCoords = GetSafeCoordForPed(x, y, coords.z, spawnOnPavement , 16)

if not foundSafeCoords then -- The native couldn't find a safe spawn point, in which case we'll calculate the coordinates ourselves. It would probably be better to just not spawn the ped at this coordinates, and recalculate it.
    local z = 0

    repeat
        local onGround, safeZ = GetGroundZFor_3dCoord(coords)
        if not onGround then
            z = z + 0.1
        end
    until onGround

    safeCoords = vector3(x, y, safeZ)
end

return safeCoords

end


function GetTableLng(tbl)
    local getN = 0
    for n in pairs(tbl) do 
        getN = getN + 1 
    end
    return getN
end



function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end