local vehicleData = {
	vehicles = {},
}

local vehicleAttributes = {
	vehicleX = {}, vehicleY = {}, vehicleZ = {}, vehicleFuel={}, vehicleHealth = {}, vehicleVisible = {}, vehicleName = {}, vehicleIds = {}, vehicleUpgrades = {}
}

local vehicle_market_marker = createMarker(1279, -1350, 12.5, "cylinder", 2, 0, 250, 150, 150)
local REPAIRCOST = 15


function initVehicleData(p)
	vehicleData.vehicles[p] = {}
	vehicleAttributes.vehicleX[p] = {}
	vehicleAttributes.vehicleY[p] = {}
	vehicleAttributes.vehicleZ[p] = {}
	vehicleAttributes.vehicleUpgrades[p] = {}
	vehicleAttributes.vehicleName[p] = {}
	vehicleAttributes.vehicleVisible[p] = {}
	vehicleAttributes.vehicleHealth[p] = {}
	vehicleAttributes.vehicleFuel[p] = {}
	vehicleAttributes.vehicleIds[p] = {}
	vehicleAttributes.vehicleUpgrades[p] = {}
	for i = 1, 100 do
		vehicleData.vehicles[p][i] = nil
	end
end

function setVehicleUpgrades(p, vehicleId, value, slotName)
	if (isElement(p) and isLoggedIn(p) and vehicleId ~= nil and value ~= nil and slotName ~= nil) then
		vehicleAttributes.vehicleUpgrades[p][vehicleId][slotName] = value
		--outputChatBox("upgrades : " ..tostring(vehicleAttributes.vehicleUpgrades[p][vehicleId][slotName]), p)
	end
end


function createVehicleTable() --Create table for our vehicles
	executeSQLQuery("CREATE TABLE IF NOT EXISTS servername_vehicles (vehicleid INTEGER PRIMARY KEY AUTOINCREMENT, vehicleOwner TEXT, vehicleX INTEGER, vehicleY INTEGER, vehicleZ INTEGER, vehicleName TEXT, vehicleHealth INTEGER, vehicleFuel INTEGER)")
end

function createSellVehicleTable()
	executeSQLQuery("CREATE TABLE IF NOT EXISTS servername_sell_vehicles (vehicleid INTEGER, owner TEXT, vehicle_name TEXT, price INTEGER, description TEXT, status TEXT)")
end

function createPlayersSoldVehicles()
	executeSQLQuery("CREATE TABLE IF NOT EXISTS servername_sold_vehicles (username TEXT, vehicle_name TEXT, vehicle_price INTEGER, soldTo TEXT)")
end

function getPersonalVehicleById(p, vehicleId)
	if (isElement(p) and isLoggedIn(p)) then
		if (vehicleId ~= nil and vehicle ~= 0) then
			local vehicle = vehicleData.vehicles[p][vehicleId]
			return vehicle
		end
	end
end


function saveVehicle(p, vehicle)
	if (isElement(vehicle) and isElement(p) and isLoggedIn(p)) then
		if (vehicle ~= nil) then
			local vehicleHealth = getElementHealth(vehicle)
			local x, y , z = getElementPosition(vehicle)
			local visible = "true"
			if (getElementDimension(vehicle) ~= 0) then
				visible = "false"
			end
			local vehicleId = getVehicleId(p, vehicle)
			vehicleAttributes.vehicleFuel[p][vehicleId] = fuel
		end
	end
end

function handleBuyVehicleFromPlayer(vehicleId, vehiclePrice, vehicleName, playerName)
	if (client == source) then
		if (vehicleId ~= nil) then
			local continue = false
			if (getPlayerMoney(client) >= vehiclePrice) then
				local checkVehicleStillForSale = executeSQLQuery("SELECT * FROM servername_sell_vehicles")
				for i, value in ipairs(checkVehicleStillForSale) do
					if (value ~= nil) then
						if (value.vehicleid == vehicleId) then
							continue = true
							break
						end
					end
				end
				if (continue) then
					deleteVehicleFromDatabaseSelling(client, vehicleId, playerName, vehicleName)
					insertPlayerNeedsToReceiveMoney(client, playerName, vehicleName, getLoginName(client), vehiclePrice)
					takePlayerMoney(client, vehiclePrice)
					outputChatBox("You succesfully bought the car for $" ..vehiclePrice, client)
				else
					outputChatBox("This vehicle is not available anymore.", client)
				end
			else
				outputChatBox("You need atleast $" ..vehiclePrice.. " to buy this car.", client)
			end
		end
	end
end

function insertPlayerNeedsToReceiveMoney(p, receiver, vehicleName, soldTo, price)
	if (isElement(p) and isLoggedIn(p)) then
		executeSQLQuery("INSERT INTO servername_sold_vehicles(username, vehicle_name, vehicle_price, soldTo) VALUES(?,?,?,?)", receiver, vehicleName, price, soldTo)
	end
end


function checkToReceiveMoneyFromSoldVehicle(p)
	if (isElement(p) and isLoggedIn(p)) then
		local soldVehicles = executeSQLQuery("SELECT * FROM servername_sold_vehicles")
		for i, value in ipairs(soldVehicles) do
			if (value ~= nil) then
				if (value.username == getLoginName(p)) then
					givePlayerMoney(p, value.vehicle_price)
					outputChatBox("It looks like you sold a " ..value.vehicle_name.. " for $" ..value.vehicle_price.. " to : " ..value.soldTo, p, 0, 255, 0)
				end
			end
		end
		executeSQLQuery("DELETE FROM servername_sold_vehicles WHERE username=?", getLoginName(p))
	end
end

function deleteVehicleFromDatabaseSelling(p, vehicleId, name, vehicleName)
	if (isElement(p) and isLoggedIn(p)) then
		local sqlDelete = executeSQLQuery("DELETE FROM servername_sell_vehicles WHERE vehicleid=? AND owner=?", vehicleId, name)
		if (sqlDelete) then
			outputChatBox("Succesfully deleted vehicleId " ..vehicleId, client)
			insertVehicleInDatabase(p, vehicleName)
			reloadPlayerVehicles(p)
		else
			outputChatBox("Error deleting vehicleId " ..vehicleId, client)
		end
	end
end

function handleDeleteVehicle(vehicleId, vehicleName)
	if (client == source) then
		if (vehicleId ~= nil) then
			deleteVehicleFromDatabaseSelling(client, vehicleId, getLoginName(client), vehicleName)
		end
	end
end

addEvent("deleteVehicle", true)
addEventHandler("deleteVehicle", root, handleDeleteVehicle)

function insertVehicleInDatabase(p, vehicleName)
	if (isElement(p) and isLoggedIn(p)) then
		executeSQLQuery("INSERT INTO servername_vehicles (vehicleOwner, vehicleX, vehicleY, vehicleZ, vehicleName, vehicleHealth, vehicleFuel) VALUES(?,?,?,?,?,?,?)", getLoginName(p), 2184, -1799, 13.5, vehicleName, 1000, 1000)
		reloadPlayerVehicles(p)
	end
end

--Check for money, enough money? buy vehicle and insert into sql table
function handleBuyVehicle(vehicleName, vehiclePrice, fuelTank)
	if (client == source) then
		if (vehicleName ~= nil or vehicleName ~= "") then
			if (vehiclePrice ~= nil or vehiclePrice > 0) then
				if (getPlayerMoney(client) >= tonumber(vehiclePrice)) then
					insertVehicleInDatabase(client, vehicleName, fuelTank)
					takePlayerMoney(client, vehiclePrice)
					outputChatBox("You succesfully bought a " ..vehicleName.. " for the price of $" ..vehiclePrice, client)
				else
					outputChatBox("You need atleast $" ..vehiclePrice.." to buy this vehicle.", client, 255, 0, 0)
				end
			end
		end
	end
end

addEvent("buyVehicle", true)
addEventHandler("buyVehicle", root, handleBuyVehicle)


function destroyVehicle(p, vehicleId)
	if (isElement(p) and isLoggedIn(p)) then
		local vehicle = vehicleData.vehicles[p][vehicleId]
		if (vehicle ~= nil) then
			destroyElement(vehicle)
			vehicleData.vehicles[p][vehicleId] = nil
		end
	end
end

function handleSellVehicle(vehicleId, vehiclePrice)
	if (client == source) then
		if (vehicleId ~= nil) then
			local vehicle = vehicleData.vehicles[client][vehicleId]
			local sqlTable = executeSQLQuery("INSERT INTO servername_sell_vehicles (vehicleid, owner, vehicle_name, price, description, status) VALUES(?,?,?,?,?,?)", vehicleId, getLoginName(client), getVehicleName(vehicle), vehiclePrice, "Great car!", "selling")
			executeSQLQuery("DELETE FROM servername_vehicles WHERE vehicleid=?", vehicleId)
			destroyVehicle(client, vehicleId)
			if (sqlTable) then
				reloadPlayerVehicles(client)
			else
				outputChatBox("Fail", client)
			end
		end
	end
end

addEvent("sellVehicle", true)
addEventHandler("sellVehicle", root, handleSellVehicle)

function sendSellingVehiclesToClient(p)
	if (isElement(p) and isLoggedIn(p)) then
		local vehicles = executeSQLQuery("SELECT * FROM servername_sell_vehicles")
		triggerClientEvent(p, "showSellCarInterface", p, handleShowSellCarInterface, vehicles)
	end
end

addCommandHandler("kart", sendSellingVehiclesToClient)




function handleShowVehicles(vehicleId) --works
	if (client == source) then
		if (vehicleId  ~= nil) then
			local x = vehicleAttributes.vehicleX[client][vehicleId]
			local y = vehicleAttributes.vehicleY[client][vehicleId]
			local z = vehicleAttributes.vehicleZ[client][vehicleId]
			local health = vehicleAttributes.vehicleHealth[client][vehicleId]
			local fuel = vehicleAttributes.vehicleFuel[client][vehicleId]
			local name = vehicleAttributes.vehicleName[client][vehicleId]
			local vehicle = createVehicle(getVehicleModelFromName(name), x, y , z)
			local slotName = nil
			setElementHealth(vehicle, health)
			vehicleAttributes.vehicleVisible[client][vehicleId] = 1 --visible
			vehicleData.vehicles[client][vehicleId] = vehicle
			vehicleData.vehicles[client][vehicle] = vehicleId
			setVehicleCosmeticState(vehicle, health)
			triggerClientEvent(client, "getVehicleUpgradeFromServer", client, handleGetUpgradeFromServer, vehicleAttributes.vehicleUpgrades[client][vehicleId])
			if (vehicleAttributes.vehicleUpgrades[client][vehicleId] ~= nil) then
				for i, value in pairs(vehicleAttributes.vehicleUpgrades[client][vehicleId]) do
					if (value ~= nil) then
						if (i ~= "Hood") then
							--outputChatBox("value : " ..tostring(value).. " i : " ..i)
							for x in string.gmatch(value, "%S+") do
								slotName = getVehicleUpgradeSlotName ( x )
								vehicleAttributes.vehicleUpgrades[client][vehicleId][i] = x
								addVehicleUpgrade(vehicle, vehicleAttributes.vehicleUpgrades[client][vehicleId][slotName])
								--outputChatBox("string : " ..x)
							end
						end
					end
				end
			end
		end
	end
end

addEvent("showVehicle", true)
addEventHandler("showVehicle", root, handleShowVehicles)

function handleHideVehicle(vehicleId) --hide vehicle on the map
	if (client == source) then
		if (vehicleId  ~= nil) then
			if not (isPedInVehicle(client)) then
				local vehicle = vehicleData.vehicles[client][vehicleId]
				vehicleAttributes.vehicleX[client][vehicleId], vehicleAttributes.vehicleY[client][vehicleId], vehicleAttributes.vehicleZ[client][vehicleId] =getElementPosition(vehicle)
				vehicleAttributes.vehicleHealth[client][vehicleId] = getElementHealth(vehicle)
				vehicleAttributes.vehicleVisible[client][vehicleId] = 0--visible
				destroyElement(vehicle)
				vehicleData.vehicles[client][vehicleId] = nil
			else
				outputChatBox("You can't hide your vehicle if your in it!", client)
			end
		end
	end
end

addEvent("hideVehicle", true)
addEventHandler("hideVehicle", root, handleHideVehicle)

function handleRepairVehicle(vehicleId)
	if (client == source) then
		if (vehicleId  ~= nil) then
			if not (isPedInVehicle(client)) then
				local vehicle = vehicleData.vehicles[client][vehicleId]
				if (vehicle) then
					local currentHealth = getElementHealth(vehicle)
					local costs = (1000-currentHealth) * REPAIRCOST
					if (getPlayerMoney(client) >= costs) then
						setElementHealth(vehicle, 1000)
						takePlayerMoney(client, costs)
						outputChatBox("You succesfully fixed your car for $"..costs, client)
						outputChatBox("[INFO] Go to a mechanic shop to fix it for a cheaper price.", 255, 0, 0)
					else
						outputChatBox("You need atleast : $" ..costs.." to repair this vehicle.", client, 220, 0, 0)
					end
				end
			end
		end
	end
end

addEvent("repairVehicle", true)
addEventHandler("repairVehicle", root, handleRepairVehicle)

function handleShowPlayerOwnedVehicles() --show vehicles on interface
	if (client == source) then
		triggerClientEvent(client, "showPersonalVehicles", client, showVehicleOptionsInterface, vehicleAttributes)
	end
end

--TODO : Attributes of vehicles, health, x, y, z etc
function loadVehicles(p)
	if (isElement(p) and isLoggedIn(p)) then
		local upgrades = nil
		local slotName = nil
		local vehicleId = nil
		local loadVehicles = executeSQLQuery("SELECT * FROM servername_vehicles WHERE vehicleOwner=?", getLoginName(p))
		for i, value in ipairs(loadVehicles) do
			if (value ~= nil) then
				if (value.vehicleid > 0) then
					vehicleAttributes.vehicleName[p][value.vehicleid] = value.vehicleName
					vehicleAttributes.vehicleX[p][value.vehicleid] = value.vehicleX
					vehicleAttributes.vehicleY[p][value.vehicleid] = value.vehicleY
					vehicleAttributes.vehicleZ[p][value.vehicleid] = value.vehicleZ
					vehicleAttributes.vehicleHealth[p][value.vehicleid] = value.vehicleHealth
					vehicleAttributes.vehicleFuel[p][value.vehicleid] = value.vehicleFuel
					vehicleAttributes.vehicleIds[p][value.vehicleid] = value.vehicleid
					vehicleAttributes.vehicleVisible[p][value.vehicleid] = 0
					if (value.vehicleUpgrades ~= nil) then
						vehicleAttributes.vehicleUpgrades[p][value.vehicleid] = {}
						upgrades = fromJSON(value.vehicleUpgrades)
						vehicleId = value.vehicleid
						if (upgrades ~= nil) then
							for i, value in pairs(upgrades) do
								for x in string.gmatch(value, "%S+") do
									slotName = getVehicleUpgradeSlotName ( x )
									vehicleAttributes.vehicleUpgrades[p][vehicleId][slotName] = x
									--outputChatBox("Vehicle id : " ..vehicleId.. " slotname : " ..slotName.." x : " ..x)
								end
							end
						end
					end
				end
			end
		end
	end
end

function test11(p)
--
end

function setVehicleCosmeticState(vehicle, vehicleHealth)
	local state = round((vehicleHealth-250/250), 0)
	for i=1, 6 do
		setVehiclePanelState ( vehicle, i, state )
	end
end

function loadPlayerVehicles(p)
	if (isElement(p) and isLoggedIn(p)) then
		initVehicleData(p)
		loadVehicles(p)
	end
end

function reloadPlayerVehicles(p)
	if (isElement(p) and isLoggedIn(p)) then
		initVehicleData(p)
		loadVehicles(p)
	end
end




function saveSingleVehicleDatabase(p, i)
	if (isElement(p) and isLoggedIn(p) and vehicleData.vehicles[p][i] ~= nil) then
		local vehicle = nil
		local x, y, z = 0
		local vehicleHealth = 1000
		vehicle = vehicleData.vehicles[p][i]
		x, y , z = getElementPosition(vehicle)
		vehicleHealth = getElementHealth(vehicle)
		local update = executeSQLQuery("UPDATE servername_vehicles SET vehicleX=?, vehicleY=?, vehicleZ=?, vehicleHealth=? WHERE vehicleOwner=? AND vehicleid=?", x, y, z, vehicleHealth, getLoginName(p), i)
	end
end

function saveVehicleDatabase(p) --saves all the vehicles from a player in the database
	if (isElement(p) and isLoggedIn(p)) then
		local vehicle = nil
		local x, y, z = 0
		local vehicleHealth = 1000
		local vehicleFuel = 60
		for i, value in pairs(vehicleData.vehicles[p]) do
			if (vehicleData.vehicles[p][i] ~= nil) then
					vehicle = vehicleData.vehicles[p][i]
					if (isElement(vehicle)) then
						x, y , z = getElementPosition(vehicle)
						vehicleHealth = getElementHealth(vehicle)
						vehicleFuel = vehicleAttributes.vehicleFuel[p][i]
						executeSQLQuery("UPDATE servername_vehicles SET vehicleX=?, vehicleY=?, vehicleZ=?, vehicleHealth=?, vehicleFuel=? WHERE vehicleOwner=? AND vehicleid=?", x, y, z, vehicleHealth, vehicleFuel, getLoginName(p), i)
						outputDebugString("Car saved!")
					end
			end
		end
	end
end

function hideVehiclesOnLogout(p)
	if (isElement(p) and isLoggedIn(p)) then
		local vehicle
		if ((vehicleData.vehicles[p] ~= nil)) then
			saveVehicleDatabase(p)
			for i, value in pairs(vehicleData.vehicles[p]) do
			if (vehicleData.vehicles[p][i] ~= nil) then
					vehicle = vehicleData.vehicles[p][i]
					outputDebugString("test : " ..tostring(vehicle))
					if (isElement(vehicle)) then
						destroyElement(vehicle)
					end
					vehicleData.vehicles[p][i] = nil
				end
			end
		end
	end
end

function handleLocateVehicle(vehicleId)
	if (client == source) then
		local x, y, z = 0
		local vehicle = vehicleData.vehicles[client][vehicleId]
		if (vehicle ~= nil) then
			if (isElement(vehicle)) then
				triggerClientEvent(client, "showLine", client, handleShowLine, vehicle)
			end
		else
			outputChatBox("This vehicle is hidden.", client)
		end
	end
end

function handleLockVehicle(vehicleId)
	if (client == source) then
		local vehicle = vehicleData.vehicles[client][vehicleId]
		if (vehicle ~= nil) then
			if (isVehicleLocked(vehicle)) then
				setVehicleLocked(vehicle, false)
				outputChatBox("You unlocked your vehicle")
			else
				setVehicleLocked(vehicle, true)
				outputChatBox("You locked the vehicle.")
			end
		end
	end
end

function handleVehicleEngine(p)
	local vehicle = getPedOccupiedVehicle ( p )
	if (vehicle) then
		if (getVehicleEngineState(vehicle)) then
			outputChatBox("You turned the vehicle engine off...",p)
			setVehicleEngineState ( vehicle, false )
		else
			outputChatBox("You turned the vehicle engine on...",p)
			setVehicleEngineState ( vehicle, true )
		end
	end
end

addCommandHandler("engine", handleVehicleEngine)

function enterVehicle(player, seat, jacked)
	if (isElement(source) and isLoggedIn(player)) then
		if (getLoginName(player) ~= "sami") then
			local vehicleId = getVehicleId(player, source)
			if (jacked) then
				if (source ~= vehicleData.vehicles[player][vehicleId]) then
					outputChatBox("this is not your vehicle!", player, 120, 0, 0)
					outputChatBox("[INFO] Buy a vehicle at a car dealer.", player, 220, 0, 0)
					cancelEvent()
				end
			end
		end
	else
		cancelEvent()
	end
end

function enteredVehicle(player, seat, jacked)
	if (isElement(source) and isLoggedIn(player)) then
		sendVehicleFuel(player, source)
	end
end

function getVehicleFuel(p, theVehicle)
	for i, value in pairs(vehicleData.vehicles[p]) do
		outputChatBox(" values : " ..tostring(values))
		if (theVehicle == value) then
			return vehicleAttributes.vehicleFuel[p][i]
		end
	end
	return 50
end

function receiveVehicleFuelFromClient(fuel, theVehicle)
	if (client == source) then
		if (theVehicle) then
			local vehicleId = getVehicleId(client, theVehicle)
			if (vehicleAttributes.vehicleFuel[client] ~= nil) then
				if (vehicleAttributes.vehicleFuel[client][vehicleId]) then
					if (fuel < 0) then vehicleAttributes.vehicleFuel[client][vehicleId] = 0 end
					vehicleAttributes.vehicleFuel[client][vehicleId] = fuel
				end
			end
		end
	end
end

addEvent("sendVehicleFuel", true)
addEventHandler("sendVehicleFuel", root, receiveVehicleFuelFromClient)


function sendVehicleFuel(p, theVehicle)
	if (p ~= nil and theVehicle ~= nil) then
		if (isElement(p) and isLoggedIn(p)) then
			if (theVehicle) then
				local vehicleId = getVehicleId(p, theVehicle)
				if (vehicleId ~= nil) then
					if (vehicleAttributes.vehicleFuel[p][vehicleId] > 0) then
						triggerClientEvent(p, "vehicleFuel", p, getVehicleFuelFromServer, vehicleAttributes.vehicleFuel[p][vehicleId])
						outputChatBox("vehicle fuel sent : " ..tostring(vehicleAttributes.vehicleFuel[p][vehicleId]), p)
					else
						outputChatBox("Your vehicle has run out of fuel...", p, 255, 0, 0)
						triggerClientEvent(p, "vehicleFuel", p, getVehicleFuelFromServer, 0)
					end
				else
					triggerClientEvent(p, "vehicleFuel", p, getVehicleFuelFromServer, 60)
				end
			end
		end
	end
end

function getVehicleId(p, theVehicle)
	if (isElement(p) and isLoggedIn(p)) then
		if (theVehicle) then
			if (vehicleData.vehicles[p] ~= nil) then
				return vehicleData.vehicles[p][theVehicle]
			end
		end
	end
end

function setVehicleFuel(p, theVehicle, newvalue)
	if (isElement(p) and isLoggedIn(p)) then
		if (theVehicle) then
			local vehicleId = getVehicleId(p, theVehicle)
			if (vehicleId ~= nil) then
				vehicleAttributes.vehicleFuel[p][vehicleId] = newvalue
			end
		end
	end
end



addEvent("lockVehicle", true)
addEventHandler("lockVehicle", root, handleLockVehicle)

addEvent("locateVehicle", true)
addEventHandler("locateVehicle", root, handleLocateVehicle)


addEvent("showPersonalVehicles", true)
addEventHandler("showPersonalVehicles", root, handleShowPlayerOwnedVehicles)

addEventHandler("onResourceStart", root , function()
	createVehicleTable()
	createSellVehicleTable()
	createPlayersSoldVehicles()
end)


addEvent("buyVehicePlayer", true)
addEventHandler("buyVehicePlayer", root, handleBuyVehicleFromPlayer)

addEventHandler ( "onVehicleStartEnter", getRootElement(), enterVehicle ) 
addEventHandler ( "onVehicleEnter", root, enteredVehicle)

addEventHandler("onMarkerHit", vehicle_market_marker, sendSellingVehiclesToClient)