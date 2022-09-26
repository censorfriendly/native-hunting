-- Specific Framework events are in this file, this file should be modified

AddEventHandler("hunting:message", function(message)
    -- Replace with framework calls to send message to players
    print(message)
end)


AddEventHandler("hunting:addToInventory", function(items, itemsCount)
    -- Replace with framework calls to add Items to players inventory
    print(dump(items))
    print(dump(itemsCount))
end)

AddEventHandler("hunting:pdalert",function(location)
    -- Replace with framework PD Alert call
    print("Call PD")
end)

AddEventHandler("hunting:sell",function()
    -- Replace with framework Opening shop menu, to either buy/sell items appropriate to the shop
    print("Open shop interface")
end)

AddEventHandler("hunting:removeBait",function()
    -- Replace with framework calls to remove bait form players inventory
    print("Remove bait")
end)