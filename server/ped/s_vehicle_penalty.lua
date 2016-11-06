local vehiclePenalty = {}

function initializeVehiclePenalty(p)
	if(isElement(p) and isLoggedIn(p)) then
		vehiclePenalty[p] = 0
	end
end

function getVehiclePenalty(p)
	if(isElement(p) and isLoggedIn(p)) then
		return vehiclePenalty[p]
	end
end	

function addVehiclePenalty(p, add_value, reason)
	if(isElement(p) and isLoggedIn(p)) then
		vehiclePenalty[p] = vehiclePenalty[p] + add_value
		givePlayerWarning(p, vehiclePenalty[p])
		removeVehiclePermit(p, vehiclePenalty[p])
		outputChatBox("You got 1 penalty for : " ..reason.. "!", p, 255, 0, 0)
	end
end

function removeVehiclePenalty(p, remove_value, reason)
	if(isElement(p) and isLoggedIn(p)) then
		vehiclePenalty[p] = vehiclePenalty[p] - remove_value
		outputChatBox("You lost 1 penalty for : " ..reason.. "!", p, 255, 0, 0)
	end
end

function setVehiclePenalty(p, par_value)
	if(isElement(p) and isLoggedIn(p)) then
		if (par_value ~= nil) then
			if (par_value >= 0) then
				vehiclePenalty[p] = par_value
				outputChatBox("Your vehicle penalty has been set to : " ..par_value, p, 255, 0, 0)
			end
		else
			vehiclePenalty[p] = 0
		end
	end
end

function givePlayerWarning(p, par_value)
	if(isElement(p) and isLoggedIn(p)) then
		if (par_value ~= nil) then
			if (par_value == 4) then
				outputChatBox("[WARNING]1 more vehicle penalty and the government will take your permit!", p, 255, 0, 0)
			end
		end
	end
end

function removeVehiclePermit(p, par_value)
	if(isElement(p) and isLoggedIn(p)) then
		if (par_value ~= nil) then
			if (par_value >= 5) then
				setElementData(p, "permit_car", 0)
				outputChatBox("[PERMIT] This was your fifth penalty there-for you lost your vehicle permit.", p, 255, 0, 0)
				vehiclePenalty[p] = 0
			end
		end
	end
end