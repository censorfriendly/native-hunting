

QBCore.Functions.CreateUseableItem("bait", function(source)
    TriggerClientEvent('native-hunting:client:bait', source)
end)

QBCore.Functions.CreateUseableItem("hunting_knife", function(source)
    TriggerClientEvent('native-hunting:client:knife', source)
end)