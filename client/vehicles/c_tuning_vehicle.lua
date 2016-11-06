local vehicleUpgrades = nil


function showMechanicOptionInterface()
	if not (getWindowDisplayed()) then
		if (source == localPlayer and isLoggedIn()) then
			local vehicle = getPedOccupiedVehicle(localPlayer)
			if (vehicle) then
				local occupant = getVehicleOccupant(vehicle, 0)
				if (occupant ~= nil) then
					if (occupant == localPlayer) then
						unbindAllKeys()
						showDXOptionInterface()
						GUIEditor.window[1] = guiCreateWindow(0.30, 0.18, 0.36, 0.56, "", true)
						guiWindowSetSizable(GUIEditor.window[1], false)
						guiSetAlpha(GUIEditor.window[1], 0.61)

						GUIEditor.button[1] = guiCreateButton(0.07, 0.83, 0.29, 0.09, "Upgrade vehicle", true, GUIEditor.window[1])
						guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF1BFA04")
						GUIEditor.button[2] = guiCreateButton(0.60, 0.83, 0.29, 0.09, "Repair vehicle", true, GUIEditor.window[1])
						guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF1BFA04")
						GUIEditor.button[3] = guiCreateButton(0.91, 0.05, 0.05, 0.06, "", true, GUIEditor.window[1])
						guiSetAlpha(GUIEditor.button[3], 0.0) 
						addEventHandler("onClientGUIClick", GUIEditor.button[1], handleUpgradeVehicleBtn, false)
						addEventHandler("onClientGUIClick", GUIEditor.button[2], handleRepairVehicleBtn, false)
						addEventHandler("onClientGUIClick", GUIEditor.button[3], handleCloseMechanicOptionInterfaceBtn, false)
						showCursor(true)
						setElementFrozen(vehicle, true)
					end
				end
			else
				outputChatBox("You need to be in a vehicle to perform any upgrade.", 255, 0, 0)
			end
		end
	end
end

addEvent("showTuneInterface", true)
addEventHandler("showTuneInterface", localPlayer, showMechanicOptionInterface)

function handleUpgradeVehicleBtn()
	if (getWindowDisplayed()) then
		handleCloseMechanicOptionInterfaceBtn()
		drawVehicleUpgradeInterface()
	end
end

function handleRepairVehicleBtn()
	if (getWindowDisplayed()) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if (vehicle) then
			local occupant = getVehicleOccupant(vehicle, 0)
			if (occupant ~= nil) then
				if (occupant == localPlayer) then
					triggerServerEvent("repairGarage", localPlayer)
				end
			end
		else
			outputChatBox("This vehicle is not yours!", 255, 0, 0)
		end
	end
end

function handleCloseMechanicOptionInterfaceBtn()
	if (getWindowDisplayed()) then
		hideDXOptionInterface()
		destroyAll()
		showCursor(false)
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if (vehicle) then
			local occupant = getVehicleOccupant(vehicle, 0)
				if (occupant ~= nil) then
					if (occupant == localPlayer) then
						setElementFrozen(vehicle, false)
					end
				end
		end
	end
end

function drawDXOptionInterface()
	if (isLoggedIn() and getWindowDisplayed()) then
		dxDrawImage(666/1600*screenWidth, 296/900*screenHeight, 210/1600*screenWidth, 178/900*screenHeight, "conf/images/mechanic.png", 348, 0, 0, tocolor(126, 126, 126, 255), true)
		dxDrawText("Los Santos Mechanic", 516/1600*screenWidth, 224/900*screenHeight, 1024/1600*screenWidth, 286/900*screenHeight, tocolor(255, 255, 255, 255), 1.00/900*screenHeight, "pricedown", "center", "center", false, true, true, false, false)
		dxDrawImage(1014/1600*screenWidth, 191/900*screenHeight, 15/1600*screenWidth, 19/900*screenHeight, "conf/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	else
		hideDXOptionInterface()
	end
end


function showDXOptionInterface()
	addEventHandler("onClientRender", root, drawDXOptionInterface)
end

function hideDXOptionInterface()
	removeEventHandler("onClientRender", root, drawDXOptionInterface)
end

function drawVehicleUpgradeInterface()
	if not (getWindowDisplayed()) then
		if (isPedInVehicle(localPlayer)) then
			if (isLoggedIn()) then
				unbindAllKeys()
				showDXVehicleUpgradeInterface()
				GUIEditor.window[1] = guiCreateWindow(0.60, 0.13, 0.36, 0.57, "Vehicle upgrade", true)
				guiWindowSetSizable(GUIEditor.window[1], false)
				guiWindowSetMovable ( GUIEditor.window[1], false )
				guiSetAlpha(GUIEditor.window[1], 0.30)

				handleVehicleUpgradesOnGridList()
				
				GUIEditor.button[1] = guiCreateButton(0.57, 0.80, 0.27, 0.18, "Upgrade", true, GUIEditor.window[1])
				guiSetFont(GUIEditor.button[1], "default-bold-small")
				guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF48FB02")
			
				GUIEditor.button[2] = guiCreateButton(0.92, 0.04, 0.05, 0.08, "", true, GUIEditor.window[1])
				guiSetAlpha(GUIEditor.button[2], 0.00) 
				
				GUIEditor.button[3] = guiCreateButton(0.57, 0.45, 0.27, 0.18, "Remove all components", true, GUIEditor.window[1])
				guiSetFont(GUIEditor.button[3], "default-bold-small")
				guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FF48FB02")
				
				addEventHandler("onClientGUIClick", GUIEditor.button[1], handleConfirmUpgradeBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[2], closeVehicleUpgradeInterfaceBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], handleShowVehicleUpgradeBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[3], handleRemoveAllComponentsBtn, false)
				showCursor(true)
			end
		else
			outputChatBox("You have to be in a vehicle to perform any upgrade.", 255, 0, 0)
		end
	end
end

function handleRemoveAllComponentsBtn()
	if (getWindowDisplayed()) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if (vehicle ~= nil) then
			local occupant = getVehicleOccupant(vehicle, 0)
				if (occupant ~= nil) then
					if (occupant == localPlayer) then
						for i = 1000, 1200 do
							removeVehicleUpgrade ( vehicle, i )
						end
					end
				end
		end
	end
end

function handleVehicleUpgradesOnGridList()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (vehicle) then
		local occupant = getVehicleOccupant(vehicle, 0)
		if (occupant ~= nil) then
			if (occupant == localPlayer) then
				GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.05, 0.38, 0.93, true, GUIEditor.window[1])
				guiGridListAddColumn(GUIEditor.gridlist[1], "Slot", 0.5)
				guiGridListAddColumn(GUIEditor.gridlist[1], "Price", 0.5)
				guiGridListAddColumn(GUIEditor.gridlist[1], "Upgrade", 0.5)
				
				local upgrades = getVehicleCompatibleUpgrades ( vehicle )
				local row
				for upgradeKey, upgradeValue in ipairs ( upgrades ) do
					row = guiGridListAddRow(GUIEditor.gridlist[1])
					guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, getVehicleUpgradeSlotName(upgradeValue)..""..getNitroType(upgradeValue), false, false)
					guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, "$"..getVehicleUpgradePrice(upgradeValue), false, false)
					guiGridListSetItemText(GUIEditor.gridlist[1], row, 3, tostring(upgradeValue), false, false)
				end
			end
		end
	end
end

function getNitroType(value)
	if (value == 1008) then
		return " x2"
	elseif (value == 1009) then
		return " x5"
	elseif (value == 1010) then
		return " x10"
	end
	return ""
end

function handleConfirmUpgradeBtn()
	if (getWindowDisplayed()) then
		local upgradeName = getListItem(1)
		local price = getListItem(2)
		local upgradeValue = getListItem(3)
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if (upgradeValue ~= nil and upgradeName ~= nil) then
			if (vehicle) then
				local occupant = getVehicleOccupant(vehicle, 0)
				if (occupant ~= nil) then
					if (occupant == localPlayer) then
						local colPrice = string.gsub(tostring(price), "[$]", "")
						if (getPlayerMoney() >= tonumber(colPrice) ) then
							closeVehicleUpgradeInterfaceBtn()
							triggerServerEvent("upgradeVehicle", localPlayer, upgradeValue, colPrice )
							
						else
							outputChatBox("You need atleast $" ..colPrice .." to upgrade your vehicle.", 255, 0, 0)
						end
					end
				end
			end
		end
	end
end

function handleGetUpgradeFromServer(_, par_vehicleUpgrades)
	if (source == localPlayer) then
		if (par_vehicleUpgrades ~= nil) then
			vehicleUpgrades = par_vehicleUpgrades
		end
	end
end

addEvent("getVehicleUpgradeFromServer", true)
addEventHandler("getVehicleUpgradeFromServer", localPlayer, handleGetUpgradeFromServer)

function closeVehicleUpgradeInterfaceBtn()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
		hideDXVehicleUpgradeInterface()
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if (vehicle) then
			local occupant = getVehicleOccupant(vehicle, 0)
			if (occupant ~= nil) then
				if (occupant == localPlayer) then
					setElementFrozen(vehicle, false)
					if (vehicleUpgrades ~= nil) then
						if (type(vehicleUpgrades) == "table") then
							for i, value in pairs(vehicleUpgrades) do
								if (value ~= nil) then
									for x in string.gmatch(value, "%S+") do
										addVehicleUpgrade(vehicle, tonumber(x))
									end
								end
							end
						else
							for x in string.gmatch(vehicleUpgrades, "%S+") do
								addVehicleUpgrade(vehicle, tonumber(x))
							end
						end
					else
						for i = 1000, 1200 do
							removeVehicleUpgrade ( vehicle, i )
						end
					end
				end
			end
		end
	end
end

function handleShowVehicleUpgradeBtn()
	if (getWindowDisplayed()) then
		local upgradeValue = getListItem(3)
		local upgradeName = getListItem(1)
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if (vehicle) then
			local occupant = getVehicleOccupant(vehicle, 0)
			if (upgradeName ~= nil) then
				if (occupant ~= nil) then
					if (isLoggedIn() and occupant == localPlayer) then
						setCameraTowardsVehicle(upgradeName)
						addVehicleUpgrade ( vehicle, upgradeValue)
						setElementFrozen(vehicle, true)
					end
				end
			end
		end
	end
end

function setCameraTowardsVehicle(upgradeName)
	local x, y, z = getElementPosition(getLocalPlayer())
	if (upgradeName == "Wheels" or upgradeName == "Sideskirt") then
		setCameraMatrix(1046, -1014, 32, 948, -1015, 7, 0, 120)
	elseif (upgradeName == "Exhaust" or upgradeName == "Rear Bumper") then
		setCameraMatrix(1044, -1025, 33, 1019, -931, 10)
	elseif (upgradeName == "Front Bumper" or upgradeName == "Headlights") then
		setCameraMatrix(1041, -1007, 33, 1039, -1104, 8)
	else
		setCameraMatrix(1040, -1009, 35, 1069, -1092, -6)
	end
		--[[
	if (upgradeName == "Wheels") then
		setCameraMatrix ( x - 5, y + 2, z+1 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Spoiler") then
		setCameraMatrix ( x - 5, y - 3, z+4 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Nitro") then
		setCameraMatrix ( x - 2, y + 6, z+3 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Front Bumper") then
		setCameraMatrix ( x - 2, y - 6, z+1 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Rear Bumper") then
		setCameraMatrix ( x - 2, y + 6, z+2 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Roof") then
		setCameraMatrix ( x - 5, y + 2, z+1 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Sideskirt") then
		setCameraMatrix ( x - 5, y + 2, z+1 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Exhaust") then
		setCameraMatrix ( x - 2, y + 5, z , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Headlights") then
		setCameraMatrix ( x - 2, y - 6, z+1 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Vent") then
		setCameraMatrix ( x - 2, y - 6, z+1 , x, y, z, 0, 70 ) --wheels
	elseif (upgradeName == "Hood") then
		setCameraMatrix ( x - 2, y - 6, z+1 , x, y, z, 0, 70 ) --wheels
	end]]
end

function drawDXVehicleUpgradeInterface()
	if (isLoggedIn() and getWindowDisplayed()) then
		dxDrawImage(1500/1600*screenWidth, 144/900*screenHeight, 18/1600*screenWidth, 20/900*screenHeight, "conf/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawText("TUNING SHOP", 1650/1600*screenWidth, 254/900*screenHeight, 1025/1600*screenWidth, 326/900*screenHeight, tocolor(203, 253, 1, 70), 1.00/900*screenHeight, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawLine(1500/1600*screenWidth, 315/900*screenHeight, 1230/1600*screenWidth, 315/900*screenHeight, tocolor(255, 255, 255, 255), 1, true)
	else
		hideDXVehicleUpgradeInterface()
	end
end

function showDXVehicleUpgradeInterface()
	addEventHandler("onClientRender", root, drawDXVehicleUpgradeInterface)
end

function hideDXVehicleUpgradeInterface()
	removeEventHandler("onClientRender", root, drawDXVehicleUpgradeInterface)
end

function getVehicleUpgradePrice(value)
	if (isLoggedIn() and isElement(localPlayer)) then
		local name = getVehicleUpgradeSlotName(value)
		if not (getSpecialVehicleUpgrades(value)) then
			if (name == "Wheels") then 
				return 500
			elseif (name == "Spoiler") then
				return 600
			elseif (name == "Sideskirt") then
				return 800
			elseif (name == "Front Bumper") then
				return 600
			elseif (name == "Rear Bumper") then
				return 600
			elseif (name == "Exhaust") then
				return 150
			elseif (name == "Vent") then
				return 400
			elseif (name == "Hood") then
				return 700
			elseif (name == "Nitro") then
				return 2000
			elseif (name == "Headlights") then
				return 300
			elseif (name == "Stereo") then
				return 100
			elseif (name == "Hydraulics") then
				return 3000
			elseif (name == "Roof") then
				return 850
			end
		end
		return getSpecialVehicleUpgrades(value)
	end
end

function getSpecialVehicleUpgrades(value)
	if (isElement(localPlayer) and isLoggedIn()) then
		if (value == 1080) then
			return 800
		elseif (value == 1082) then
			return 750
		elseif (value == 1083) then
			return 900
		elseif (value == 1085) then
			return 600
		elseif (value == 1096) then
			return 700
		elseif (value == 1009) then
			return 4000
		elseif (value == 1010) then
			return 8000
		end
		return false
	end
end