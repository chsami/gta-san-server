function handleRefillFuel(fuel, price, vehicle)
	if (client == source) then
		outputChatBox("check 1 ")
			outputChatBox("vehicle " ..tostring(vehicle).. " price : " ..tostring(price).. " fuel : " ..tostring(fuel), client) 
			if (getPlayerMoney(client) >= price) then
				setVehicleFuel(client, vehicle, fuel)
				takePlayerMoney(client, price)
			else
				outputChatBox("You don't have enough money to buy this amount of gas...", client, 255, 0, 0)
			end
	end
end

addEvent("refillFuel", true)
addEventHandler("refillFuel", root, handleRefillFuel)