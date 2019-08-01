ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('esx_hotdog:buyItem')
AddEventHandler('esx_hotdog:buyItem', function(price)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local limit = xPlayer.getInventoryItem('hotdog').limit
	local qtty = xPlayer.getInventoryItem('hotdog').count
	if xPlayer.getMoney() >= price then
	    if qtty < limit then
	      	SetTimeout(5000, function()
	            xPlayer.removeMoney(price)
	            xPlayer.addInventoryItem('hotdog', 1)
	            TriggerClientEvent('esx:showNotification', _source, _U('bought') .. price .. '$~s~.')
	        end)
	    else
	        TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
	    end
	else
	    TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
	end
	

end)

ESX.RegisterUsableItem('hotdog', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hotdog', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 500000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_hotdog'))
end)
