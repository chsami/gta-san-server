
local SPEED_TICKET = 5000

function handlePaySpeedTicket()
	if (client == source) then
		takePlayerMoney(client, SPEED_TICKET)
	 addVehiclePenalty(client, 1, "SPEEDING")
	end
end

function initSpeedHandler(p)
	if (isElement(p) and isLoggedIn(p)) then
		addEventHandler("paySpeedTicket", p, handlePaySpeedTicket)
		addEventHandler ("onVehicleExit", p,  finalizedSpeedHandler)
	end
end

function finalizedSpeedHandler(p)
	if (isElement(p) and isLoggedIn(p)) then
		removeEventHandler("paySpeedTicket", p, handlePaySpeedTicket)
		removeEventHandler("onVehicleExit", p,  finalizedSpeedHandler)
	end
end


addEvent("paySpeedTicket", true)
addEventHandler ( "onVehicleEnter", root,  initSpeedHandler)
