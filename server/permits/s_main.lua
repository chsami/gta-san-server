function payForPermit(amount)
	if (client == source) then
		if (isElement(client)) then
			if (getPlayerMoney(client) >= amount) then
				takePlayerMoney(client, amount)
				outputChatBox("You payed " .. amount .."$ to start your exam...", client)
				triggerClientEvent("startExam", client, showKeyCombination)
				addEventHandler("setFightingStyle", client, setNewFightingStyle)
			end
		end
	end
end


function setNewFightingStyle(style)
	if (client == source) then
		setPedFightingStyle(client, style)
		removeEventHandler("setFightingStyle", client, setNewFightingStyle)
	end
end

addEvent("setFightingStyle", true)




addEvent("payPermit", true)
addEventHandler("payPermit", root, payForPermit)