
-- Specific Framework events are in this file, this file should be modified

AddEventHandler("hunting:message", function(message,type)
    -- Replace with framework calls to send message to players
    QBCore.Functions.Notify(message, type, 5000)
end)


AddEventHandler("hunting:addToInventory", function(items, itemsCount)
    -- Replace with framework calls to add Items to players inventory
    TriggerServerEvent("hunting:reward",items.items,itemsCount)
end)

AddEventHandler("hunting:pdalert",function(location)
    -- Replace with framework PD Alert call
    print("Call PD")
end)


RegisterNetEvent('hunting:client:openSellShop', function(data)
    QBCore.Functions.TriggerCallback('hunting:server:getInv', function(inventory)
        local PlyInv = inventory
        local huntMenu = {
            {
                header = 'Hunting Lodge',
                isMenuHeader = true,
            }
        }
        for _, v in pairs(PlyInv) do
            for i = 1, #data do
                if v.name == data[i].name then
                    huntMenu[#huntMenu + 1] = {
                        header = data[i].label,
                        txt = 'Sell item $'.. data[i].price,
                        params = {
                            event = 'hunting:client:sellItems',
                            args = {
                                label = data[i].label,
                                price = data[i].price,
                                name = v.name,
                                amount = v.amount
                            }
                        }
                    }
                end
            end
        end
        huntMenu[#huntMenu + 1] = {
            header = 'Back Info',
            params = {
                event = 'hunting:client:openMenu'
            }
        }
        exports['qb-menu']:openMenu(huntMenu)
    end)
end)


RegisterNetEvent('hunting:client:sellItems', function(item)
    local sellingItem = exports['qb-input']:ShowInput({
        header = "Sell Amount",
        submitText = "sell",
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = "Max" .. item.amount
            }
        }
    })
    if sellingItem then
        if not sellingItem.amount then
            return
        end

        if tonumber(sellingItem.amount) > 0 then
            TriggerServerEvent('hunting:server:sellItems', item.name, item.label, sellingItem.amount, item.price)
        else
            QBCore.Functions.Notify("Error Selling", 'error')
        end
    end
end)

RegisterNetEvent('hunting:client:openMenu', function()
    local pawnShop = {
        {
            header = "Hunting Lodge",
            isMenuHeader = true,
        },
        {
            header = "Buy Items",
            txt = "",
            params = {
                event = 'hunting:client:openBuyShop'
            }
        },
    
        {
            header = "Sell Items",
            txt = "",
            params = {
                event = 'hunting:client:openSellShop',
                args = ItemList
                
            }
        },{
            header = "Exit Shop",
            txt = "",
            params = {
                event = 'exports["qb-menu"]:closeMenu'
            }
        }
    }
    exports['qb-menu']:openMenu(pawnShop)
end)

RegisterNetEvent('hunting:client:openBuyShop', function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_Hunting" , Shop)
end)