

function checkPilotRequirements(thePlayer, vehicleName)
	if (vehicleName == "Beagle" and tonumber(getJobAttribute(thePlayer, "pilot", getJobLevelIndex())) < 1) then
		return false
	elseif (vehicleName == "Shamal" and tonumber(getJobAttribute(thePlayer, "pilot", getJobLevelIndex())) < 2) then
		return false
	elseif ( vehicleName == "AT400" and tonumber(getJobAttribute(thePlayer, "pilot", getJobLevelIndex())) < 3) then
		return false
	else
		return true
	end
end

function checkPoliceRequirements(thePlayer, vehicleName)
	if (vehicleName == "Police Ranger" and tonumber(getJobAttribute(thePlayer, "police", getJobLevelIndex())) < 1) then
		return false
	elseif (vehicleName == "FBI Rancher" and tonumber(getJobAttribute(thePlayer, "police", getJobLevelIndex())) < 2) then
		return false
	else
		return true
	end
end

function spawnTempVehicle(vehicleName)
	if (client == source) then
		if (vehicleName ~= nil) then
			if (checkPilotRequirements(source, vehicleName) and checkPoliceRequirements(source, vehicleName)) then
				if (getElementData(source, "tempVehicle") ~= 0 and getElementData(source, "tempVehicle") ~= nil) then
					local vehicleToDestroy = getElementData(source, "tempVehicle")
					local allVehicles = getElementsByType("vehicle")
					if (vehicleToDestroy ~= nil and vehicleToDestroy ~= 0) then
						for i, value in ipairs(allVehicles) do
							if (vehicleToDestroy == value) then
								destroyElement(vehicleToDestroy)
							end
						end
					end
				end
				local x, y , z = getElementPosition(source)
				local theVehicle = createVehicle(getVehicleModelFromName ( vehicleName ), x, y , z + 1)
				warpPedIntoVehicle ( source, theVehicle)
				setElementData(source, "tempVehicle", theVehicle)
				triggerClientEvent("setElementGhostModeOn", getRootElement(), setElementGhostModeOn, source)
				triggerClientEvent(client, "vehicleFuel", client, getVehicleFuelFromServer, 60)
			else
				triggerClientEvent(client, "notificationMessage", client, drawNotificationMessage, "You do not have the skils to control a " ..vehicleName..".")
			end
		else
			outputChatBox("Error on vehicleName class : s_vehicle_spawn.lua", source)
		end
	end
end

function destroyTempVehicle(thePlayer)
	if (thePlayer) then
		if (getElementType(thePlayer) == "player") then
			if (getElementData(thePlayer, "tempVehicle")) then
				local vehicleToDestroy = getElementData(thePlayer, "tempVehicle")
				if (isElement(vehicleToDestroy)) then
					if (vehicleToDestroy ~= 0 and vehicleToDestroy ~= 1 and vehicleToDestroy ~= nil) then
						destroyElement(vehicleToDestroy)
					end
				end
			end
		end
	end
end

function handleDestroyTempVehicleClient()
	if (client == source) then
		local vehicleToDestroy = getElementData(client, "tempVehicle")
		if (isElement(vehicleToDestroy)) then
			if (vehicleToDestroy ~= 0 and vehicleToDestroy ~= 1 and vehicleToDestroy ~= nil) then
				destroyElement(vehicleToDestroy)
			end
		end
	end
end

function spawnVehicles()
	local farmVehicle1 = createVehicle ( 536, -7, -4, 5 )
	if (farmVehicle1) then
		outputChatBox("Vehicles succesfully loaded!")
	else
		outputChatBox("Error loading vehicles!")
	end
end

function onVehicleExplode()
	local vehicle = source
	local thePlayer = getVehicleOccupant (source)
	if (thePlayer) then
		if (source == getElementData(thePlayer, "tempVehicle")) then
			setElementData(thePlayer, "tempVehicle", 0)
		end
	end
	if (vehicle) then
		destroyElement(vehicle)
		outputDebugString("destroy element")
	end
end


--CUSTOM EVENTS--

addEvent("destroyTempVehicle", true)
addEventHandler("destroyTempVehicle", root, handleDestroyTempVehicleClient)

addEvent("spawnTempVehicle", true)
addEventHandler("spawnTempVehicle", root, spawnTempVehicle)

--SERVER EVENTS--

addEventHandler ( "onVehicleExplode", root, onVehicleExplode )


--RESOURCE EVENTS--



addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), spawnVehicles)