
function giveReward(text, amount)
	if (client == source) then
		givePlayerMoney(client, amount)
		outputChatBox("You received " ..amount.."$ for completing " ..text.."!", client)
	end
end

addEvent("giveMoney", true)
addEventHandler("giveMoney", root, giveReward)