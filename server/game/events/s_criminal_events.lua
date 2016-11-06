

function initializeCriminalEvents(p)
	if (isElement(p) and isLoggedIn(p)) then
		local theTimer = nil
		theTimer = setTimer(function()
			if (getCurrentJob(p) == "criminal") then
				if (getCriminalCooldown(p) > 0) then
					triggerClientEvent(p, "criminalEvent", p, startCriminalEvent)
					addEventHandler("criminalEventCompleted", p, handleCriminalEventCompleted)
					killTimer(theTimer)
				end
			end
		end, 30000, 0)
	end
end


function handleCriminalEventCompleted()
	if (client == source) then
		givePlayerMoney(client, 300)
		removeEventHandler("criminalEventCompleted", client, handleCriminalEventCompleted)
	end
end

addEvent("criminalEventCompleted", true)



