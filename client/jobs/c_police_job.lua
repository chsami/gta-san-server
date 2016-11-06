

local restock_marker = createMarker(1571, -1633, 12.5, "cylinder", 2, 0, 0, 255, 150)
local police_car_marker = createMarker(1561, -1611, 12.5, "cylinder", 4, 0, 0, 200, 150)
local jail_player_marker = createMarker(1588, -1633, 12.5, "cylinder", 3, 255, 0, 0, 150)

function MarkerPoliceHit(hitElement)
	if (hitElement == getLocalPlayer() and getElementType(hitElement) == "player") then
		if (getElementData(hitElement, "arrested")) then
			if (getElementData(hitElement, "arrested") == "true") then
				return
			end
		end
		if (source == restock_marker) then
			if (getCurrentJob() == "police") then
				triggerServerEvent("restock", getLocalPlayer())
			else
				drawNotificationMessageClient("You have to be a police officer to work here!")
			end
		elseif (source == police_car_marker) then
			if (getCurrentJob() == "police") then
				createSpawnVehiclesGuiClient("Police LV", "Police LS", "Police SF", "Police Ranger", "FBI Rancher")
			else
				drawNotificationMessageClient("You have to be a police officer to work here!")
			end
		elseif (source == jail_player_marker) then
			if (getCurrentJob() == "police") then
				if (getElementData(hitElement, "player_arrest") ~= 0) then
					triggerServerEvent("jailPlayer", hitElement)
				else
					drawNotificationMessageClient("You have no arrest!")
				end
			else
				drawNotificationMessageClient("You have to be a police officer to work here!")
			end
		end
	end--security
end

function playTaserSound()
	if (source == getLocalPlayer()) then
		local x , y, z = getElementPosition(localPlayer)
		local sound = playSound3D ( "conf/sounds/taser.wav", x, y , z, false)
		setSoundVolume(sound, 1.5) -- set the sound volume to 50%
		setSoundMaxDistance(sound, 50)
	end
end

function disablePlayerInput()
	if (source == getLocalPlayer()) then
		guiSetInputEnabled(true)
	end
end

function enablePlayerInput()
	if (source == getLocalPlayer()) then
		guiSetInputEnabled(false)
	end
end

function showDrawDXJailTimer()
	if (source == localPlayer) then
		addEventHandler("onClientRender", root, drawDXJailTimer)
	end
end

function hideDrawDXJailTimer()
	if (source == localPlayer) then
		removeEventHandler("onClientRender", root, drawDXJailTimer)
	end
end

function drawDXJailTimer()
	local scale = 1/900*screenHeight
	dxDrawText("Jail Timer : " ..getElementData(getLocalPlayer(), "jail_timer"), 1225/1600*screenWidth, 727/900*screenHeight, 1584/1600*screenWidth, 830/900*screenHeight, tocolor(0, 0, 0, 255), scale, "bankgothic", "left", "center", false, false, true, false, false)
	dxDrawText("Jail Timer : " ..getElementData(getLocalPlayer(), "jail_timer"), 1225/1600*screenWidth, 725/900*screenHeight, 1584/1600*screenWidth, 828/900*screenHeight, tocolor(0, 0, 0, 255), scale, "bankgothic", "left", "center", false, false, true, false, false)
	dxDrawText("Jail Timer : " ..getElementData(getLocalPlayer(), "jail_timer"), 1223/1600*screenWidth, 727/900*screenHeight, 1582/1600*screenWidth, 830/900*screenHeight, tocolor(0, 0, 0, 255), scale, "bankgothic", "left", "center", false, false, true, false, false)
	dxDrawText("Jail Timer : " ..getElementData(getLocalPlayer(), "jail_timer"), 1223/1600*screenWidth, 725/900*screenHeight, 1582/1600*screenWidth, 828/900*screenHeight, tocolor(0, 0, 0, 255), scale, "bankgothic", "left", "center", false, false, true, false, false)
	dxDrawText("Jail Timer : " ..getElementData(getLocalPlayer(), "jail_timer"), 1224/1600*screenWidth, 726/900*screenHeight, 1583/1600*screenWidth, 829/900*screenHeight, tocolor(13, 253, 1, 255), scale, "bankgothic", "left", "center", false, false, true, false, false)
end


function drawPoliceJobInterface()
	if (source == localPlayer) then
		if not (getWindowDisplayed()) then
			if (isLoggedIn()) then
				GUIEditor.window[1] = guiCreateWindow(0.34, 0.21, 0.37, 0.54, "Los Santos Police Department", true)
				guiWindowSetSizable(GUIEditor.window[1], false)

				GUIEditor.button[1] = guiCreateButton(0.14, 0.77, 0.26, 0.11, "Become a Police Officer!", true, GUIEditor.window[1])
				guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF1DFE00")
				GUIEditor.button[2] = guiCreateButton(0.57, 0.77, 0.26, 0.11, "Enter the building", true, GUIEditor.window[1])
				guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF1DFE00")
				GUIEditor.button[3] = guiCreateButton(0.91, 0.06, 0.07, 0.06, "", true, GUIEditor.window[1])
				guiSetAlpha(GUIEditor.button[3], 0.00)   
				addEventHandler("onClientGUIClick", GUIEditor.button[1], handleBecomePoliceOfficerBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[2], handleEnterTheBuildingBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[3], handleClosePoliceJobInterface, false)
				showCursor(true)
				showDXPoliceInterface()
			end
		end
	end
end

addEvent("showPoliceJob", true)
addEventHandler("showPoliceJob", localPlayer, drawPoliceJobInterface)


function handleBecomePoliceOfficerBtn()
	if (getWindowDisplayed()) then
		handleClosePoliceJobInterface()
		drawPoliceSkinInterface()
	end
end

function handleEnterTheBuildingBtn()
	if (getWindowDisplayed()) then
		outputChatBox("The building is currently under construction.")
		handleClosePoliceJobInterface()
	end
end

function handleClosePoliceJobInterface()
	destroyAll()
	showCursor(false)
	hideDXPoliceInterface()
end


function drawDXPoliceInterface()
        dxDrawImage(1082/1600*screenWidth, 220/900*screenHeight, 18/1600*screenWidth, 20/900*screenHeight, ":ghetto/conf/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("Welcome to Los Santos Police Department", 595/1600*screenWidth, 291/900*screenHeight, 1061/1600*screenWidth, 459/900*screenHeight, tocolor(255, 255, 255, 255), 0.70/900*screenHeight, "bankgothic", "center", "center", false, true, true, false, false)
end

function showDXPoliceInterface()
	addEventHandler("onClientRender", root, drawDXPoliceInterface)
end

function hideDXPoliceInterface()
	removeEventHandler("onClientRender", root, drawDXPoliceInterface)
end



local skins = {280, 281, 282, 283, 288}
local temp_save_skin = nil

function drawPoliceSkinInterface()
	if not (getWindowDisplayed()) then
		unbindAllKeys()
		temp_save_skin = getElementModel(localPlayer)
		local x, y, z = getElementPosition(localPlayer)
        GUIEditor.window[1] = guiCreateWindow(0.15, -0.00, 0.26, 0.65, "Police job", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetAlpha(GUIEditor.window[1], 1.00)

        GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.13, 0.95, 0.59, true, GUIEditor.window[1])
        buildPoliceSkinList()
		if (getCurrentJob() ~= "police") then
			GUIEditor.button[1] = guiCreateButton(0.33, 0.74, 0.34, 0.12, "Become a Police Officer", true, GUIEditor.window[1])
		else
			GUIEditor.button[1] = guiCreateButton(0.33, 0.74, 0.34, 0.12, "Change skin", true, GUIEditor.window[1])
		end
        GUIEditor.button[2] = guiCreateButton(0.93, 0.04, 0.04, 0.04, "X", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")   
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleBecomePoliceBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleClosePoliceSkinInterfaceBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], handlePickPoliceSkinBtn, false)
		showCursor(true)
		setCameraMatrix(1556.0402832031, -1676.3374023438, 21.181741714478, 1503.9351806641, -1665.2481689453, -63.447372436523, 0, 70)--policz
	end
end

function handlePickPoliceSkinBtn()
	if (getWindowDisplayed()) then
		local skinId = getListItem(1)
		if (skinId ~= nil) then
			setElementModel(localPlayer, skinId)
		end
	end
end	

function buildPoliceSkinList()
	if (getWindowDisplayed()) then
		local counter = 0
		guiGridListAddColumn(GUIEditor.gridlist[1], "Skin", 0.5)
		for i = 1, #skins do
			guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], counter, 1, skins[i], false, false)
			counter = counter + 1
		end
	end
end

function handleBecomePoliceBtn()
	if (getWindowDisplayed()) then
		local skinId = getListItem(1)
		if (skinId ~= nil) then
			setCameraTarget(localPlayer)
			triggerServerEvent("setNewJob", localPlayer, "police", skinId)
			setCurrentJob("police")
			destroyAll()
			showCursor(false)
		end
	end
end

function handleClosePoliceSkinInterfaceBtn()
	destroyAll()
	showCursor(false)
	if (temp_save_skin ~= nil) then setElementModel(localPlayer, temp_save_skin) end
end


--CUSTOM EVENTS--

addEvent("showDrawDXJailTimer", true)
addEventHandler("showDrawDXJailTimer", localPlayer, showDrawDXJailTimer)

addEvent("hideDrawDXJailTimer", true)
addEventHandler("hideDrawDXJailTimer", localPlayer, hideDrawDXJailTimer)

addEvent("enablePlayerInput", true)
addEventHandler("enablePlayerInput", localPlayer, enablePlayerInput)

addEvent("disablePlayerInput", true)
addEventHandler("disablePlayerInput", localPlayer, disablePlayerInput)

addEvent("playTaserSound", true)
addEventHandler("playTaserSound", localPlayer, playTaserSound)

--CLIENT EVENTS

addEventHandler ( "onClientMarkerHit", getRootElement(), MarkerPoliceHit )