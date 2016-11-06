
local personalVehicleUpgrade = {}


local createGarageSpot = createColRectangle(1038, -1037, 9, 30)
local createGarageMarker = createMarker(1042, -1014, 30, "cylinder", 3, 0, 250, 0, 150)
local garageHint = createMarker(1041, -1028, 33.5, "corona", 2, 250, 0, 0, 250)


function handleUpgradeVehicle(upgradeValue, price)
	if (client == source) then
		if (isElement(client) and isLoggedIn(client)) then
			if (upgradeValue ~= nil and price ~= nil) then
				local vehicle = getPedOccupiedVehicle(client)
				if (vehicle) then
					local vehicleId = getVehicleId(client, vehicle)
					if (getPlayerMoney(client) >= tonumber(price)) then
						if(vehicleId ~= nil) then
							if (personalVehicleUpgrade[client][vehicleId] == nil) then
								addVehicleUpgrade ( vehicle, upgradeValue)
								personalVehicleUpgrade[client][vehicleId] = tostring(upgradeValue)
							else
								addVehicleUpgrade ( vehicle, upgradeValue)
								personalVehicleUpgrade[client][vehicleId] = personalVehicleUpgrade[client][vehicleId].." "..tostring(upgradeValue)
							end
							takePlayerMoney(client, price)
							triggerClientEvent(client, "getVehicleUpgradeFromServer", client, handleGetUpgradeFromServer, personalVehicleUpgrade[client][vehicleId])
							local jsonUpgrade = toJSON ( { upgrades = personalVehicleUpgrade[client][vehicleId]} )
							saveVehicleUpgrade(client, vehicle, jsonUpgrade)
							saveVehicleDatabase(client)
							loadVehicles(client)
							hideVehiclesOnLogout(client)
							outputChatBox("You succesfully upgraded your vehicle, press 'u' and select it to respawn the tuned vehicle.", client, 255, 0, 0)
						else
							outputChatBox("Looks like this is not your vehicle!", client, 255, 0, 0)
							
						end
					else
						outputChatBox("You need atleast $" ..price.." to upgrade your vehicle.", client, 255, 0, 0)
					end
				end
			end
		end
	end
end

function saveVehicleUpgrade(p, vehicle, upgrades)
	if (isElement(p) and isLoggedIn(p)) then
		if (vehicle) then
			local vehicleId = getVehicleId(p, vehicle)
			if (vehicleId ~= nil and vehicleId > 0) then
				executeSQLQuery("UPDATE servername_vehicles SET vehicleUpgrades=? WHERE vehicleid=?", upgrades, vehicleId)
			end
		end
	end
end

function loadVehicleUpgrade(p)
	if (isElement(p) and isLoggedIn(p)) then
		local upgrades = nil
		local vehicleId = nil
		local slotName = nil
		personalVehicleUpgrade[p] = {}
		local vehicles = executeSQLQuery("SELECT * FROM servername_vehicles WHERE vehicleOwner=?", getLoginName(p))
		for i, value in ipairs(vehicles) do
			if (value ~= nil) then
				if (value.vehicleUpgrades ~= nil) then
					vehicleId = value.vehicleid
					upgrades = fromJSON(value.vehicleUpgrades)
					if (upgrades ~= nil) then
						for i, value in pairs(upgrades) do
							if (vehicleId ~= nil) then
								if (personalVehicleUpgrade[p][vehicleId] ~= nil) then
									personalVehicleUpgrade[p][vehicleId] = personalVehicleUpgrade[p][vehicleId].." " ..tostring(value)
								else
									personalVehicleUpgrade[p][vehicleId] = tostring(value)
								end
								slotName = getVehicleUpgradeSlotName ( value )
								setVehicleUpgrades(p, vehicleId, value, slotName)
							end
						end
					end
				end
			end
		end
	end
end

function handleHitGarageSpot(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement)) then
		if (isPedInVehicle(hitElement)) then
			local vehicle = getPedOccupiedVehicle(hitElement)
			if (vehicle) then
				if not (isGarageOpen ( 10 )) then
					setGarageOpen ( 10, true )
					setVehicleOverrideLights ( vehicle, 2 )
				end
			end
		end
	end
end

function handleLeaveGarageSpot(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement)) then
		if (isPedInVehicle(hitElement)) then
			local vehicle = getPedOccupiedVehicle(hitElement)
			if (vehicle) then
				if (isGarageOpen ( 10 )) then
					setGarageOpen ( 10, false )
					setVehicleOverrideLights ( vehicle, 0 )
				end
			end
		end
	end
end

function handleHitGarageMarker(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement)) then
		if (isPedInVehicle(hitElement)) then
			triggerClientEvent(hitElement, "showTuneInterface", hitElement, showMechanicOptionInterface)
			addEventHandler("repairGarage", hitElement, repairVehicleAtGarage)
		else
			outputChatBox("You need to be a in a vehicle to tune it.", hitElement, 255, 0, 0)
		end
	end
end

function handleLeaveGarageMarker(leavingPlayer)
	if (isElement(leavingPlayer) and isLoggedIn(leavingPlayer)) then
		removeEventHandler("repairGarage", leavingPlayer, repairVehicleAtGarage)
	end
end

function repairVehicleAtGarage()
	if (client == source) then
		local vehicle = getPedOccupiedVehicle(client)
		if (vehicle) then
			local currentHealth = getElementHealth(vehicle)
			local costs = (1000-currentHealth) * 4
			if (getPlayerMoney(client) >= costs) then
				setElementHealth(vehicle, 1000)
				takePlayerMoney(client, costs)
				outputChatBox("You succesfully fixed your car for $"..costs, client)
			else
				outputChatBox("You need atleast $" ..costs.." to fix your car.", client, 255, 0, 0)
			end
		end
	end
end

addEvent("repairGarage", true)

addEvent("upgradeVehicle", true)
addEventHandler("upgradeVehicle", root, handleUpgradeVehicle)

addEventHandler("onColShapeHit", createGarageSpot, handleHitGarageSpot)
addEventHandler("onColShapeLeave", createGarageSpot, handleLeaveGarageSpot)
addEventHandler("onMarkerHit", createGarageMarker, handleHitGarageMarker)
addEventHandler ( "onClientMarkerLeave", createGarageMarker, handleLeaveGarageMarker)