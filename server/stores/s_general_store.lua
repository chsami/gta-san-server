

function handleBuyGeneralStoreItem(item, price)
	if (client == source) then
		outputChatBox(tostring(price))
		if (getPlayerMoney(client) >= price) then
			--add item here
			takePlayerMoney(client, price)
		else
			outputChatBox("You do not have enough money to purchase this item.", client)
		end
	end
end

addEvent("buyGeneralStore", true)
addEventHandler("buyGeneralStore", root, handleBuyGeneralStoreItem)