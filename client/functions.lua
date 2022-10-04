function createSellNPC()
    RequestModel(Config.SellerHash)
    while not HasModelLoaded(Config.SellerHash) do
        Wait(10)
    end
    
    local created_ped = CreatePed(1, Config.SellerHash , vector3(Config.SellerLocation.x,Config.SellerLocation.y,Config.SellerLocation.z -1), Config.SellerLocation.rotation, false)
    FreezeEntityPosition(created_ped, true)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)

    return created_ped
end

function createNPC(hash,location,rotation,aggressive)
    local modelHash = hash
    RequestModel(modelHash)
    local spawned = false
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end

    local spawnCoords = GetSpawnCoords(location)

    local created_ped = CreatePed(1, modelHash , spawnCoords, rotation, true,false)

    if aggressive then 
        TaskCombatPed(created_ped,GetPlayerPed(-1),0,16)
    else
        TaskWanderInArea(created_ped, location,20.0,6,10.0)
    end

    return created_ped
end

function generateHunt(location)
    local odds = math.random(1,100)
    local pedList = nil
    local hash = nil
    local aggressive = false
    local rarity = 1
    local animal = nil
    local hash = nil
    RequestModel(Config.BaitHash)
    local spawned = false
    while not HasModelLoaded(Config.BaitHash) do
        Wait(1)
    end

    if odds < 75 then
        pedList = Config.spawnablePeds["common"]
    elseif odds < 90 then
        pedList = Config.spawnablePeds["uncommon"]
        rarity = 2
    elseif odds < 97 then
        pedList = Config.spawnablePeds["rare"]
        rarity = 2
    else 
        pedList = Config.spawnablePeds["epic"]
        rarity = 2
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
    local bait = CreateObject(Config.BaitHash,location.x, location.y, location.z -1,true,false,false)
    TriggerEvent("hunting:spawnAnimal",hash,location,aggressive)
    return {['ped'] = nil,['reward'] = animal, ['rarity'] = rarity, ['bait'] = bait}
end

function checkHuntingArea(position)
    local distanceCheck = GetDistanceBetweenCoords(position, Config.HuntingArea, true)
    local pass = false
    local pdAlert = false
    if position.y > 1400 then
        pass = true
        if distanceCheck > HuntingRadius then 
            pdAlert = true
        end
    end
    return pass, pdAlert
end

function cleanCarcass(animalInstance)
    
	TaskPlayAnim(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "base", 8.0, 0.0, -1, 0, 1.0, 0, 0, 0)
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@kneel@base", "base", 8.0, 0.0, -1, 0, 1.0, 0, 0, 0)
    QBCore.Functions.Progressbar('baitbar', 'Placing bait', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
        }, {}, {}, {}, function()
            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "base")
            StopAnimTask(PlayerPedId(), "amb@medic@standing@kneel@base", "base")
            StopAnimPlayback(PlayerPedId(), 0, 0)
            ClearPedTasksImmediately(PlayerPedId())
            sendRewards(animalInstance)
            DeletePed(animalInstance.ped)
        end, function()
            -- This code runs if the progress bar gets cancelled
            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@bodysearch@", "base")
            StopAnimTask(PlayerPedId(), "amb@medic@standing@kneel@base", "base")
            StopAnimPlayback(PlayerPedId(), 0, 0)
            ClearPedTasksImmediately(PlayerPedId())
    end)

    -- Send rewards, add pelts to inventory
end

function checkCarcassEvent(animalTable)
    length = 0
    for _ in pairs(animalTable) do length = length + 10 end
    if length > 49 then 
        local odds = math.random(1,100)
        if odds < length then
            animalTable = triggerAggressiveSpawn(animalTable)
        end
    end
    return animalTable
end

function triggerAggressiveSpawn(animalTable)
    local pedList = Config.spawnablePeds.common.aggressive
    local hash = nil
    local key = math.random(1, GetTableLng(pedList))
    local getN = 1
    local player = GetPlayerPed(-1)
    local position = GetEntityCoords(player)
    local animal = nil
    animalTable = removePeds(animalTable)
    for hashkey in pairs(pedList) do 
        if(getN == key) then
            animal = pedList[hashkey]
            hash = hashkey
        end
        getN = getN + 1
    end
    local count = 0
    repeat
        count = count + 1
        local anim = createNPC(hash,position, 0,true);
        local entry = {['ped'] = anim,['reward'] = animal, ['rarity'] = 1}
        table.insert(animalTable,entry)
    until count == 3
    return animalTable
end 

function sendRewards(animalInstance)

    local modifier = animalInstance.rarity
    print(GetPedCauseOfDeath(animalInstance.ped))
    if GetPedCauseOfDeath(animalInstance.ped) ~= Config.HuntingWeaponHash then 
        modifier = math.floor(modifier * .5)
    end

    if modifier > 0 then 
        animalInstance.multiplier = modifier
        TriggerEvent("hunting:addToInventory",animalInstance.reward,animalInstance.multiplier)
    else
        -- Send message to player
        TriggerEvent("hunting:message","Carcass was too badly damaged for usable material",'error')
    end
end

function removePeds(animalTable)
    for k, v in pairs(animalTable) do
        DeletePed(v.ped)
    end
    for i = #animalTable, 1, -1 do
       table.remove(animalTable)
    end
    return animalTable
end

function loadAnims()

    RequestAnimDict("anim@gangops@facility@servers@bodysearch@")
    RequestAnimDict("amb@medic@standing@kneel@base")
    while not HasAnimDictLoaded("amb@medic@standing@kneel@base") do
        Wait(0)
    end
end


function GetSpawnCoords(coords)

local radius = 50.0

local x = coords.x + math.random(-radius, radius)
local y = coords.y + math.random(-radius, radius)


local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), x, y, coords.z, true)
while distanceCheck < 15 do
    x = coords.x + math.random(-radius, radius)
    y = coords.y + math.random(-radius, radius)
    distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), x, y, coords.z, true)
end
local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), x, y, coords.z, true)


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
 --[[The MIT License (MIT)
Copyright (c) 2017 IllidanS4
Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:
The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
]]

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end
  
---Draws 3d text in the world on the given position
--- @param x number The x coord of the text to draw
--- @param y number The y coord of the text to draw
--- @param z number The z coord of the text to draw
--- @param text string The text to display
function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = string.len(text) / 370
    DrawRect(0.0, 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end