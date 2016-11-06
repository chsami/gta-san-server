
local vehiclesForSale = {
	vehicleLocalName = {"Landstalker", "Bravura"},
	vehicleLocalPrice = {"20000", "25000"},
	vehicleFuelTank = {80, 60}
}

local vehicleFuel = 60

local vehicleForDisplay = nil
	local theTimer = nil

local buy_vehicle_marker = createMarker(2167, -1800, 12, "cylinder", 2, 255, 0, 0, 120)


function getVehicleTank(vehicleName)
	for i, value in ipairs(vehiclesForSale.vehicleLocalName) do
		if (value == vehicleName) then
			return vehiclesForSale.vehicleFuelTank[i]
		end
	end
	return 0
end

function showBuyVehicleInterface()
	if not (getWindowDisplayed()) then
		local row = nil
		GUIEditor.window[1] = guiCreateWindow(0.01, 0.20, 0.35, 0.48, "Vehicle buy", true)
		guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetAlpha(GUIEditor.window[1], 0.49)

		GUIEditor.gridlist[1] = guiCreateGridList(0.09, 0.13, 0.40, 0.84, true, GUIEditor.window[1])
		guiGridListAddColumn(GUIEditor.gridlist[1], "Vehiclename", 0.5)
		guiGridListAddColumn(GUIEditor.gridlist[1], "Price", 0.5)
		guiGridListAddColumn(GUIEditor.gridlist[1], "FuelTank", 0.5)
		for i = 1, table.getn(vehiclesForSale.vehicleLocalName) do
			row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehiclesForSale.vehicleLocalName[i], false, false)
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 2,vehiclesForSale.vehicleLocalPrice[i], false, false)
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 3,vehiclesForSale.vehicleFuelTank[i], false, false)
		end
		GUIEditor.button[1] = guiCreateButton(0.56, 0.87, 0.40, 0.11, "Buy", true, GUIEditor.window[1])
		GUIEditor.button[2] = guiCreateButton(0.96, 0.06, 0.03, 0.03, "X", true, GUIEditor.window[1])
		guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleBuyVehicleBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], closebuyVehicleInterface, false)
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], displayVehicleForBuy, false)
		showCursor(true)
	end
end

function showVehicleOptionsInterface(_, vehicleAttributes)
	if (source == localPlayer) then
		if not (getWindowDisplayed()) then
			local counter = 0
			GUIEditor.window[1] = guiCreateWindow(0.32, 0.13, 0.38, 0.58, "Vehicle options", true)
			guiWindowSetSizable(GUIEditor.window[1], false)
			guiSetAlpha(GUIEditor.window[1], 0.70)

			 GUIEditor.gridlist[1] = guiCreateGridList(0.07, 0.08, 0.82, 0.33, true, GUIEditor.window[1])
			guiGridListAddColumn(GUIEditor.gridlist[1], "VehicleID", 0.3)
			guiGridListAddColumn(GUIEditor.gridlist[1], "Vehiclename", 0.3)
			guiGridListAddColumn(GUIEditor.gridlist[1], "Visible", 0.3)
			guiGridListAddColumn(GUIEditor.gridlist[1], "Status", 0.3)
			--return
			if (vehicleAttributes.vehicleIds[localPlayer]) then
				for i, value in pairs(vehicleAttributes.vehicleIds[localPlayer]) do
					if (value ~= nil) then
						--id
						guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1], counter, 1, tostring(i), false, false)
						--name
						guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1], counter, 2, vehicleAttributes.vehicleName[localPlayer][i], false, false)
						--visible
						guiGridListAddRow(GUIEditor.gridlist[1])
						if (vehicleAttributes.vehicleVisible[localPlayer][i] == 1) then
							guiGridListSetItemText(GUIEditor.gridlist[1], counter, 3, "true", false, false)
						else
							guiGridListSetItemText(GUIEditor.gridlist[1], counter, 3, "false", false, false)
						end
						--health
						guiGridListAddRow(GUIEditor.gridlist[1])
						if (vehicleAttributes.vehicleHealth[localPlayer][i] <= 250) then
							guiGridListSetItemText(GUIEditor.gridlist[1], counter, 4, "Destroyed", false, false)
						else
							guiGridListSetItemText(GUIEditor.gridlist[1], counter, 4, vehicleAttributes.vehicleHealth[localPlayer][i], false, false)
						end
					end
					counter = counter + 1
				end
			end
			GUIEditor.button[1] = guiCreateButton(0.09, 0.58, 0.20, 0.11, "Locate", true, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(0.09, 0.71, 0.20, 0.11, "Show", true, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(0.09, 0.85, 0.20, 0.11, "Hide", true, GUIEditor.window[1])
			GUIEditor.button[4] = guiCreateButton(0.69, 0.58, 0.20, 0.11, "Sell", true, GUIEditor.window[1])
			GUIEditor.button[5] = guiCreateButton(0.69, 0.71, 0.20, 0.11, "Repair", true, GUIEditor.window[1])
			GUIEditor.button[6] = guiCreateButton(0.69, 0.85, 0.20, 0.11, "Lock", true, GUIEditor.window[1])
			GUIEditor.button[7] = guiCreateButton(0.96, 0.07, 0.04, 0.04, "X", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[7], "NormalTextColour", "FFFE0000")
			GUIEditor.label[1] = guiCreateLabel(0.40, 0.50, 0.20, 0.05, "SET VEHICLE PRICE :", true, GUIEditor.window[1])
			guiSetFont(GUIEditor.label[1], "default-bold-small")
			guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
			GUIEditor.edit[1] = guiCreateEdit(0.69, 0.50, 0.43, 0.05, "", true, GUIEditor.window[1])   
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleLocateVehicleBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], handleShowVehicleBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[3], handleHideVehicleBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[4], handleSellVehicleBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[5], handleRepairPersonalVehicleBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[6], handleLockVehicleBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[7], handleCloseVehicleOptionInterface, false)
			showCursor(true)
		else
			handleCloseVehicleOptionInterface()
		end
	end
end

function handleShowSellCarInterface(_, vehicles)
	if (source == localPlayer) then
			if not (getWindowDisplayed()) then
				local counter = 0
				GUIEditor.window[1] = guiCreateWindow(0.01, 0.01, 0.42, 0.74, "Vehicle market", true)
				guiWindowSetSizable(GUIEditor.window[1], false)
				guiSetAlpha(GUIEditor.window[1], 0.70)

				GUIEditor.gridlist[1] = guiCreateGridList(0.05, 0.04, 0.85, 0.83, true, GUIEditor.window[1])
				guiGridListAddColumn(GUIEditor.gridlist[1], "ID", 0.3)
				guiGridListAddColumn(GUIEditor.gridlist[1], "Vehicles", 0.3)
				guiGridListAddColumn(GUIEditor.gridlist[1], "Price", 0.3)
				guiGridListAddColumn(GUIEditor.gridlist[1], "Owner", 0.3)
				if (vehicles) then
					for i, value in pairs(vehicles) do
						guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1], counter, 1, value.vehicleid, false, false)
						guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1], counter, 2, value.vehicle_name, false, false)
						guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1], counter, 3, value.price, false, false)
						guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1], counter, 4, value.owner, false, false)
						counter = i
					end
					
				end
				GUIEditor.button[1] = guiCreateButton(0.05, 0.89, 0.20, 0.09, "Delete vehicle", true, GUIEditor.window[1])
				GUIEditor.button[2] = guiCreateButton(0.38, 0.89, 0.20, 0.09, "Buy vehicle", true, GUIEditor.window[1])
				GUIEditor.button[3] = guiCreateButton(0.70, 0.89, 0.20, 0.09, "Show vehicle", true, GUIEditor.window[1])
				GUIEditor.button[4] = guiCreateButton(0.95, 0.05, 0.03, 0.03, "X", true, GUIEditor.window[1])
				guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFFF0000") 
				showCursor(true)
				addEventHandler("onClientGUIClick", GUIEditor.button[1], handleDeleteVehicleBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[2], handleBuyVehicleFromPlayerBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[3], handleShowBuyVehicleBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[4], handleCloseSellingVehicleInterface, false)
				
		end
	end
end
local occupant
function drawDXSpeed()
	local theVehicle = getPedOccupiedVehicle ( getLocalPlayer() )
    if ( theVehicle ) then      -- check if the player is in a car
			local vehicleDamage = math.floor(getElementHealth(theVehicle) - 250) / 10
			local fuel = getVehicleFuel()
			--outputChatBox("fuel ; " ..fuel)
			if (fuel == nil or fuel <= 0) then 
				if (getVehicleEngineState(theVehicle)) then
					setVehicleEngineState(theVehicle, false)
				end
				fuel = 0 
			end
			local vehicleDamagePercent = (vehicleDamage / 10)
			-- find a player named "someguy" and get his velocity.
			local speedx, speedy, speedz = getElementVelocity ( theVehicle )
			 
			-- use pythagorean theorem to get actual velocity
			-- raising something to the exponent of 0.5 is the same thing as taking a square root.
			local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
			 
			-- multiply by 50 to obtain the speed in metres per second
			local mps = actualspeed * 50
			 
			-- other useful conversions
			-- kilometres per hour
			--Font size resolution bug & Posx, posY
			local kmh = math.floor(actualspeed * 180)
			dxDrawText("Speed : " ..kmh.. "km/h\nFuel : " ..fuel.. "L\nHealth : " ..vehicleDamage.."%", 1173/1600*screenWidth, 710/900*screenHeight, 1456/1600*screenWidth, 799/900*screenHeight, tocolor(255, 255, 255, 150), 1.00/900*screenHeight, "bankgothic", "left", "center", false, false, true, false, false)
	else
		hideVehicleSpeed()
	end
end

function showVehicleSpeed(thePlayer, seat)
	if (thePlayer == localPlayer and isElement(source)) then
		if (seat == 0)then
			calculateFuel()
			addEventHandler("onClientRender", root, drawDXSpeed)
		end
	end
end


function hideVehicleSpeed()
	removeEventHandler("onClientRender", root, drawDXSpeed)
end

function getVehicleFuel()
	return round(vehicleFuel, 2)
end

function setVehicleFuel(par_fuel)
	vehicleFuel = par_fuel
end

function getVehicleFuelFromServer(_, par_vehicleFuel)
	if (source == localPlayer) then
		if (par_vehicleFuel < 0) then vehicleFuel = 0 return end
		vehicleFuel = par_vehicleFuel
	end
end

function calculateFuel()
	local theTimer = nil
	local fuelUsage = 0.5
	local x, y, z = nil
	local counter = 0
	local theVehicle = getPedOccupiedVehicle(localPlayer)
	xnow, ynow, znow = getElementPosition(localPlayer)
	theTimer = setTimer(function()
		if (isElement(theVehicle)) then
			if (getVehicleEngineState(theVehicle)) then
				fuelUsage = 0.5
			else
				fuelUsage = 0
			end
			if (vehicleFuel ~= nil) then
				if (vehicleFuel > 0 and isPedInVehicle(localPlayer)) then
					if (counter == 0) then
						x, y , z =  getElementPosition(localPlayer)
						distance = round(getDistanceBetweenPoints3D(xnow, ynow, znow, x, y , z), 0)
						vehicleFuel = vehicleFuel - ((fuelUsage + distance) / 100)
						counter = counter + 1
						triggerServerEvent("sendVehicleFuel", localPlayer, vehicleFuel, theVehicle)
					elseif (counter > 0) then
						xnow, ynow, znow = getElementPosition(localPlayer)
						counter = counter + 1
						if (counter > 5) then
							counter = 0
						end
					end
				else
					if (isTimer(theTimer)) then
						killTimer(theTimer)
					end
				end
			else
				if (isTimer(theTimer)) then
					killTimer(theTimer)
				end
			end
		else
			if (isTimer(theTimer)) then
					killTimer(theTimer)
				end
		end
	end, 2000, 0)
end

addEvent("vehicleFuel", true)
addEventHandler("vehicleFuel", localPlayer, getVehicleFuelFromServer)

function handleDeleteVehicleBtn()
	if (getWindowDisplayed()) then
		local vehicleId = getListItem(1)
		local vehicleName = getListItem(2)
		local owner = getListItem(4)
		local row, column = guiGridListGetSelectedItem ( GUIEditor.gridlist[1] )
		if (vehicleId ~= nil) then
			if (owner ~= nil) then
				if (getLoginName() == owner) then
					guiGridListRemoveRow ( GUIEditor.gridlist[1], row )
					triggerServerEvent("deleteVehicle", localPlayer, tonumber(vehicleId), vehicleName)
				else
					outputChatBox("This isn't your car to delete.")
				end
			end
		end
	end
end

function handleBuyVehicleFromPlayerBtn()
	if (getWindowDisplayed()) then
		local vehicleId = getListItem(1)
		local vehicleName = getListItem(2)
		local price = getListItem(3)
		local owner = getListItem(4)
		if (vehicleId ~= nil) then
			if (owner ~= nil) then
				if (getLoginName() ~= owner) then
					triggerServerEvent("buyVehicePlayer", localPlayer, tonumber(vehicleId), tonumber(price), vehicleName, owner)
				else
					outputChatBox("You can't buy your own car.")
				end
			end
		end
	end
end

function handleShowBuyVehicleBtn()
	if (getWindowDisplayed()) then
		displayVehicleForBuy("left", "up", 2)
	end
end


function handleCloseSellingVehicleInterface()
	destroyAll()
	showCursor(false)
end

addEvent("showSellCarInterface", true)
addEventHandler("showSellCarInterface", localPlayer, handleShowSellCarInterface)

function handleBuyVehicleBtn() --buy vehicle from database not store owner
	if (getWindowDisplayed()) then
		
	end
end

function handleHideVehicleBtn() --hide vehicle on the map
	if (getWindowDisplayed()) then	
		local vehicleId = getListItem(1)
		local vehicleHidden = getListItem(3)
		local vehicleHealth = getListItem(4)
		if (vehicleId ~= nil) then
			if (vehicleHealth ~= "Destroyed") then
				if (vehicleHidden ~= nil and vehicleHidden == "true") then
					triggerServerEvent("hideVehicle",localPlayer, tonumber(vehicleId))
					guiGridListSetItemText(GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 3, "false", false, false)
					removeEventHandler("onClientRender", root, handleDrawDXLine)
				else
					outputChatBox("This vehicle is already off the map.")
				end
			else
				outputChatBox("This vehicle is total loss.")
			end
		else
			outputChatBox("No vehicle selected.")
		end
	end
end

function handleLocateVehicleBtn() -- locate a vehicle
	if (getWindowDisplayed()) then
		local vehicleId = getListItem(1)
		if (vehicleId ~= nil) then
			triggerServerEvent("locateVehicle", localPlayer, tonumber(vehicleId))
		else
			outputChatBox("No vehicle selected.", 255, 0, 0)
		end
	end
end

function handleLockVehicleBtn() -- lock a specific vehicle
	if (getWindowDisplayed()) then
		local vehicleId = getListItem(1)
		local vehicleHidden = getListItem(3)
		local vehicleHealth = getListItem(4)
		if (vehicleId ~= nil) then
			if (vehicleHealth ~= "Destroyed" and vehicleHidden == "true") then
				triggerServerEvent("lockVehicle", localPlayer, tonumber(vehicleId))
			else
				outputChatBox("You can't lock a vehicle that is not on the map or destroyed.", 255, 0, 0)
			end
		end
	end
end

function handleRepairPersonalVehicleBtn() --repair a specific vehicle
	if (getWindowDisplayed()) then
		local vehicleId = getListItem(1)
		local vehicleSpawn = getListItem(3)
		local vehicleHealth = getListItem(4)
		if (vehicleId ~= nil) then
			if (vehicleSpawn ~= nil) then
				if (vehicleSpawn ~= "false") then
					if (vehicleHealth ~= nil) then
						if (tonumber(vehicleHealth) < 1000) then
							triggerServerEvent("repairVehicle", localPlayer, tonumber(vehicleId))
						else
							outputChatBox("Your vehicle is already fixed.", 255, 0, 0)
						end
					end
				else
					outputChatBox("Your vehicle is not visible on the map.", 255, 0, 0)
				end
			end
			
		end
	end
end

function handleSellVehicleBtn() --sell a specific vehicle
	if (getWindowDisplayed()) then
		local pattern = "[0123456789]"
		local vehicleId = getListItem(1)
		local vehicleHealth = getListItem(4)
		local vehiclePrice = guiGetText(GUIEditor.edit[1])
		local row, column = guiGridListGetSelectedItem ( GUIEditor.gridlist[1] )
		if (vehicleId ~= nil) then
			if (vehicleHealth ~= "Destroyed") then
				if (vehiclePrice ~= nil and vehiclePrice ~= "") then
					if (string.match(vehiclePrice, pattern)) then
						if (tonumber(vehiclePrice) > 0) then
							guiGridListRemoveRow(GUIEditor.gridlist[1], row)
							triggerServerEvent("sellVehicle", localPlayer, tonumber(vehicleId), tonumber(vehiclePrice))
						else
							outputChatBox("You can't sell a car for lower than $1")
						end
					else
						outputChatBox("Invalid vehicle price!")
					end
				else
					outputChatBox("Set your vehicle price in the edit box!")
				end
			else
				outputChatBox("You can't sell a destroyed vehicle.")
			end
		end
		
	end
end

function handleShowVehicleBtn() --show a specific vehicle on the map
	if (getWindowDisplayed()) then
		local vehicleId = getListItem(1)
		local vehicleHidden = getListItem(3)
		local vehicleHealth = getListItem(4)
		if (vehicleId ~= nil) then
			if (vehicleHealth ~= "Destroyed") then
				if (vehicleHidden ~= nil and vehicleHidden == "false") then
					triggerServerEvent("showVehicle",localPlayer, tonumber(vehicleId))
					guiGridListSetItemText(GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 3, "true", false, false)
				else
					outputChatBox("This vehicle is already on the map.")
				end
			else
				outputChatBox("This vehicle is total loss.")
			end
		else
			outputChatBox("No vehicle selected.")
		end
	end
end

function handleCloseVehicleOptionInterface()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
	end
end



addEvent("showPersonalVehicles", true)
addEventHandler("showPersonalVehicles", localPlayer, showVehicleOptionsInterface)

function getOwnedVehicles()
	triggerServerEvent("showPersonalVehicles", localPlayer)
end

function handleBuyVehicleBtn()
	if (getWindowDisplayed()) then
		local vehicleName = getListItem(1)
		local vehiclePrice = getListItem(2)
		local vehicleFuel = getListItem(3)
		triggerServerEvent("buyVehicle", localPlayer, vehicleName, vehiclePrice, vehicleFuel)
		closebuyVehicleInterface()
	end
end

function closebuyVehicleInterface()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
		setElementFrozen(localPlayer, false)
		destroyDisplayedVehicle()
		setCameraTarget ( localPlayer )
		setElementDimension(localPlayer, 0)
	end
end

function destroyDisplayedVehicle()
	if (vehicleForDisplay ~= nil) then
		destroyElement(vehicleForDisplay)
		vehicleForDisplay = nil
	end
end

function handleBuyVehicleMarkerHit(hitElement, matchingDimension)
	if (isElement(hitElement)) then
		if not (isPedInVehicle(hitElement)) then
			showBuyVehicleInterface()
			setElementFrozen(localPlayer, true)
		end
	end
end

function killShowTimer()
	if (isTimer(theTimer)) then
		killTimer(theTimer)
	end
end

function displayVehicleForBuy(button, state, list)
	if (list ~= 2) then
		list = 1
	end
	local vehicleName = getListItem(list)
	local rotX, rotY, rotZ = nil
	if (vehicleName ~= nil and vehicleName ~= "") then
			local x, y , z = getElementPosition(localPlayer)
			 x =  x + 5
			if (vehicleForDisplay == nil) then
				setCameraMatrix(x+8, y, 17, x, y, z, 10, 120)
				vehicleForDisplay = createVehicle(getVehicleModelFromName(vehicleName), x, y, z)
				rotX, rotY, rotZ = getElementRotation(vehicleForDisplay) -- get the local players's 
				setElementDimension(localPlayer, 1)
				setElementDimension(vehicleForDisplay, 1)
				startRotationTimer(rotZ)
			elseif (vehicleName == getVehicleName(vehicleForDisplay) and list == 1) then
				outputChatBox("You already selected this car...")
				return
			else
				destroyDisplayedVehicle()
				vehicleForDisplay = createVehicle(getVehicleModelFromName(vehicleName), x, y, z)
				rotX, rotY, rotZ = getElementRotation(vehicleForDisplay) -- get the local players's
				setElementDimension(vehicleForDisplay, 1)
				killShowTimer()
				startRotationTimer(rotZ)
			end
	end
end

function startRotationTimer(rotZ)
	theTimer = setTimer(function()
		if (getWindowDisplayed()) then
			if (vehicleForDisplay ~= nil and rotZ ~= nil) then
				rotZ = rotZ + 1
				setElementRotation(vehicleForDisplay,0,0,rotZ,"default") -- turn the player 10 degrees clockwise
			else
				killTimer(theTimer)
			end
		else
			destroyDisplayedVehicle()
			if (isTimer(theTimer)) then
				killTimer(theTimer)
			end
		end
	end, 100, 0)
end

addEventHandler("onClientVehicleEnter", root, showVehicleSpeed)

addEventHandler("onClientMarkerHit", buy_vehicle_marker, handleBuyVehicleMarkerHit)