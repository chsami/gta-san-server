function createSpawnVehiclesGui(_,vehicle1, vehicle2, vehicle3, vehicle4, vehicle5)
	if (source == getLocalPlayer()) then
		if not (getWindowDisplayed()) then
			GUIEditor.window[1] = guiCreateWindow(0.40, 0.25, 0.19, 0.41, "Choose vehicle", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.gridlist[1] = guiCreateGridList(10, 36, 278, 253, false, GUIEditor.window[1])
			guiGridListAddColumn(GUIEditor.gridlist[1], "Vehicles", 0.9)
			local row = nil
			row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle1, false, false)
			if (vehicle2 ~= nil) then
				row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle2, false, false)
			end
			if (vehicle3 ~= nil) then
				row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle3, false, false)
			end
			if (vehicle4 ~= nil) then
				row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle4, false, false)
			end
			if (vehicle5 ~= nil) then
				row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle5, false, false)
			end
			GUIEditor.button[1] = guiCreateButton(0.59, 0.83, 0.36, 0.12, "Close", true, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(0.03, 0.83, 0.36, 0.12, "Spawn", true, GUIEditor.window[1])  
			addEventHandler("onClientGUIClick", GUIEditor.button[2], handleCarSpawnBtn, false)	
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleCarCloseBtn, false)
			guiSetInputEnabled(true)
			showCursor(true)
		end
	end
end

function createSpawnVehiclesGuiClient(vehicle1, vehicle2, vehicle3, vehicle4, vehicle5) --client side	
	if (isLoggedIn()) then
		if not (getWindowDisplayed()) then
			GUIEditor.window[1] = guiCreateWindow(0.40, 0.25, 0.19, 0.41, "Choose vehicle", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.gridlist[1] = guiCreateGridList(10, 36, 278, 253, false, GUIEditor.window[1])
			guiGridListAddColumn(GUIEditor.gridlist[1], "Vehicles", 0.9)
			local row = nil
			row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle1, false, false)
			if (vehicle2 ~= nil) then
				row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle2, false, false)
			end
			if (vehicle3 ~= nil) then
				row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle3, false, false)
			end
			if (vehicle4 ~= nil) then
				row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle4, false, false)
			end
			if (vehicle5 ~= nil) then
				row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, vehicle5, false, false)
			end
			GUIEditor.button[1] = guiCreateButton(0.59, 0.83, 0.36, 0.12, "Close", true, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(0.03, 0.83, 0.36, 0.12, "Spawn", true, GUIEditor.window[1])  
			addEventHandler("onClientGUIClick", GUIEditor.button[2], handleCarSpawnBtn, false)	
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleCarCloseBtn, false)
			guiSetInputEnabled(true)
			showCursor(true)
		end
	end
end

function handleCarCloseBtn(button, state)
	if (getWindowDisplayed()) then
		destroyAll()
		guiSetInputEnabled(false)
		showCursor(false)
	end
end

function handleCarSpawnBtn(button, state)
	if (guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 ) ~= "") then
		if (getWindowDisplayed()) then
			local vehicleName = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
			destroyAll()
			guiSetInputEnabled(false)
			showCursor(false)
			triggerServerEvent("spawnTempVehicle", getLocalPlayer(), vehicleName)
		end
	end
end

function setElementGhostModeOn(_, thePlayer)
	if (getPedOccupiedVehicle(getLocalPlayer())) then
		local v = getPedOccupiedVehicle(localPlayer) -- Get her's Vehicle ID
		if (v) then
			if (getElementModel(v) == 532 or getElementModel(v) == 593 or getElementModel(v) == 511 or getElementModel(v) == 519 or getElementModel(v) == 577 or getElementModel(v) == 566 or getElementModel(v) == 420) then
				for index,vehicle in ipairs(getElementsByType("vehicle")) do --LOOP through all Vehicles
					setElementCollidableWith(vehicle, v, false) -- Set the Collison off with the Other vehicles.
				end
			end
		end
	end
end

function ghostmode_on()
	local v = getPedOccupiedVehicle(localPlayer) -- Get her's Vehicle ID
	if (v) then
		for index,vehicle in ipairs(getElementsByType("vehicle")) do --LOOP through all Vehicles
			setElementCollidableWith(vehicle, v, false) -- Set the Collison off with the Other vehicles.
		end
	end
end


addEvent("createSpawnVehiclesGui", true)
addEventHandler("createSpawnVehiclesGui", localPlayer, createSpawnVehiclesGui)

addEvent("setElementGhostModeOn", true)
addEventHandler("setElementGhostModeOn", localPlayer, setElementGhostModeOn)


