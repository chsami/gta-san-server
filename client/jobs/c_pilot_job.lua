local LS_AIRPORT = createColRectangle ( 1403, -2627, 730,200)
local destinationName = ""

local start_pilot_job_marker = createMarker(1687, -2333, 13, "cylinder", 2, 0, 250, 0, 150)

outputChatBox("loaded...")

function showFlightDestinations(_, distance)
	if (source == localPlayer) then
		if not (getWindowDisplayed()) then
			GUIEditor.window[1] = guiCreateWindow(0.29, 0.31, 0.27, 0.46, "Fly destination", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.gridlist[1] = guiCreateGridList(0.07, 0.08, 0.61, 0.81, true, GUIEditor.window[1])
			guiGridListAddColumn(GUIEditor.gridlist[1], "Destination", 0.5)
			guiGridListAddColumn(GUIEditor.gridlist[1], "Price", 0.5)
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, "San Fierro", false, false)
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, tostring(distance[1]).."km", false, false)
			row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, "Desert", false, false)
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, tostring(distance[2]).."km", false, false)
			row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, "Las Venturas", false, false)
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, tostring(distance[3]).."km", false, false)
			GUIEditor.button[1] = guiCreateButton(0.73, 0.79, 0.23, 0.08, "Start", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF66FD01")
			GUIEditor.button[2] = guiCreateButton(396, 25, 14, 15, "X", false, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFD0000")
			addEventHandler("onClientGUIClick", GUIEditor.button[1], startFlightBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], closeFlightInterfaceBtn, false)
			showCursor(true)
		end    
	end
end

addEvent("showFlightInformation", true)
addEventHandler("showFlightInformation", localPlayer, showFlightDestinations)

function closeFlightInterfaceBtn()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
	end
end

function startFlightBtn()
	if (getWindowDisplayed()) then
		if (guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 ) ~= "") then
		destinationName = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
		showDrawDestinationLine(destinationName)
		destroyAll()
		showCursor(false)
		call ( getResourceFromName ( "sounds" ), "buttonSounds", "normal")
		end
	end
end



function showDxDrawPilotStatus(thePlayer)
	if (thePlayer == getLocalPlayer()) then
		addEventHandler("onClientRender", getRootElement(), dxDrawPilotStatus)
	end
end

function hideDxDrawPilotStatus(thePlayer)
	if (thePlayer == getLocalPlayer()) then
		removeEventHandler("onClientRender", getRootElement(), dxDrawPilotStatus)
	end
end

function dxDrawPilotStatus()
	if (getElementData(getLocalPlayer(), "total_passengers") and getElementData(getLocalPlayer(), "load_passengers")) then
		dxDrawText("Passengers loaded : " ..getElementData(getLocalPlayer(), "total_passengers").."\nStatus : " ..getElementData(getLocalPlayer(), "load_passengers"), 1200/1600*screenWidth, 600/900*screenHeight, 1555/1600*screenWidth, 803/900*screenHeight, tocolor(191, 253, 1, 255), 1.00, "pricedown", "left", "top", false, false, true, false, false)
	end
end

function isInLsAirport(theElement)
	if ( getElementType( theElement ) == "player" ) and ( theElement == getLocalPlayer( ) ) then
		showDxDrawPilotStatus(theElement)
	end
end

function leftLsAirport(theElement)
	if ( getElementType( theElement ) == "player" ) and ( theElement == getLocalPlayer( ) ) then
		if (source == LS_AIRPORT) then
			hideDxDrawPilotStatus(theElement)
		end
	end
end

function showDrawDestinationLine(thePlayer)
	if (getElementData(getLocalPlayer(), "dxLine") == 1) then
		addEventHandler("onClientRender", root, drawDestinationLine)
		setElementData(getLocalPlayer(), "dxLine", 0)
		call ( getResourceFromName ( "sounds" ), "buttonSounds", "succeed")
	end
end

	
function drawDestinationLine()
	if (getPedOccupiedVehicle(getLocalPlayer()) and getElementData(getLocalPlayer(), "load_passengers") == "Take-off") then
		local vehicle = getElementModel(getPedOccupiedVehicle (getLocalPlayer()))
		if ( vehicle == 593 or vehicle == 511 or vehicle == 519 or vehicle == 577) then
			local x, y , z = getElementPosition(getLocalPlayer())
			if (destinationName == "San Fierro") then
				dxDrawLine3D ( x, y, z, -1253, -45, 13, tocolor ( 255, 0, 0, 150 ), 4)
			elseif ( destinationName == "Desert") then
				dxDrawLine3D ( x, y, z, 803, 1139, 27, tocolor ( 255, 0, 0, 150 ), 4)
			elseif ( destinationName == "Las Venturas") then
				dxDrawLine3D ( x, y, z, 1537, 1468, 9.6, tocolor ( 255, 0, 0, 150 ), 4)
			end
		end
	end
end

function showPilotJobInterface()
	if not (getWindowDisplayed()) then
		if (isLoggedIn()) then
			GUIEditor.window[1] = guiCreateWindow(0.34, 0.21, 0.37, 0.54, "Los santos airport", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.14, 0.77, 0.26, 0.11, "Apply for pilot job", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF1DFE00")
			GUIEditor.button[2] = guiCreateButton(0.57, 0.77, 0.26, 0.11, "Enter airport", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF1DFE00")
			GUIEditor.button[3] = guiCreateButton(0.91, 0.06, 0.07, 0.06, "", true, GUIEditor.window[1])
			guiSetAlpha(GUIEditor.button[3], 0.00)   
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleApplyForPilotJobBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], handleEnterAirportBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[3], handleClosePilotJobInterfaceBtn, false)
			showCursor(true)
			showDXPilotInterface()
		end
	end
end

function handleApplyForPilotJobBtn()
	if (getWindowDisplayed()) then
		handleClosePilotJobInterfaceBtn()
		drawPilotSkinInterface()
	end
end

function handleEnterAirportBtn()
	if (getWindowDisplayed()) then
		if (getCurrentJob() == "pilot") then
			handleClosePilotJobInterfaceBtn()
			fadeCamera(false, 3)
			setTimer(function()
				setElementPosition(localPlayer, 1927, -2648, 13.6)
				fadeCamera(true, 3)
			end, 2500, 1)
		else
			outputChatBox("Only pilots can enter the airport.")
		end
	end
end

function handleClosePilotJobInterfaceBtn()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
		hideDXPilotInterface()
	end
end

function drawDXPilotJobInterface()
        dxDrawImage(1082, 220, 18, 20, ":ghetto/conf/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("Welcome to Los Santos International Airport", 595, 291, 1061, 459, tocolor(255, 255, 255, 255), 0.70, "bankgothic", "center", "center", false, true, true, false, false)
end

function showDXPilotInterface()
	addEventHandler("onClientRender", root, drawDXPilotJobInterface)
end

function hideDXPilotInterface()
	removeEventHandler("onClientRender", root, drawDXPilotJobInterface)
end


local skins = {61, 17, 9, 57, 59}
local temp_save_skin = nil

function drawPilotSkinInterface()
	if not (getWindowDisplayed()) then
		temp_save_skin = getElementModel(localPlayer)
		local x, y, z = getElementPosition(localPlayer)
        GUIEditor.window[1] = guiCreateWindow(0.15, -0.00, 0.26, 0.65, "Pilot job", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetAlpha(GUIEditor.window[1], 1.00)

        GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.13, 0.95, 0.59, true, GUIEditor.window[1])
        buildPilotSkinList()
		if (getCurrentJob() ~= "pilot") then
			GUIEditor.button[1] = guiCreateButton(0.33, 0.74, 0.34, 0.12, "Become a Pilot", true, GUIEditor.window[1])
		else
			GUIEditor.button[1] = guiCreateButton(0.33, 0.74, 0.34, 0.12, "Change skin", true, GUIEditor.window[1])
		end
        GUIEditor.button[2] = guiCreateButton(0.93, 0.04, 0.04, 0.04, "X", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")   
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleBecomePilotBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleClosePilotSkinInterfaceBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], handlePickPilotSkinBtn, false)
		showCursor(true)
		setCameraMatrix(1693.3177490234, -2335.1911621094, 15.863315582275, 1602.8210449219, -2307.4443359375, -16.392818450928, 0, 70)--skinairport
	end
end

function handlePickPilotSkinBtn()
	if (getWindowDisplayed()) then
		local skinId = getListItem(1)
		if (skinId ~= nil) then
			setElementModel(localPlayer, skinId)
		end
	end
end	

function buildPilotSkinList()
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

function handleBecomePilotBtn()
	if (getWindowDisplayed()) then
		local skinId = getListItem(1)
		if (skinId ~= nil) then
			setCameraTarget(localPlayer)
			triggerServerEvent("setNewJob", localPlayer, "pilot", skinId)
			setCurrentJob("pilot")
			destroyAll()
			showCursor(false)
		end
	end
end

function handleClosePilotSkinInterfaceBtn()
	destroyAll()
	showCursor(false)
	if (temp_save_skin ~= nil) then setElementModel(localPlayer, temp_save_skin) end
end

--CLIENT EVENTS--

addEventHandler( "onClientColShapeHit", LS_AIRPORT, isInLsAirport)


addEventHandler( "onClientColShapeLeave", LS_AIRPORT, leftLsAirport)

addEventHandler("onClientMarkerHit", start_pilot_job_marker, showPilotJobInterface)