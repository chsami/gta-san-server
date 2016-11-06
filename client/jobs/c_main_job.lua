local information_icon_farmer = createPickup( -1188, -1124, 129.2, 3, 1239)
local information_icon_police =  createPickup( 1277, -1325, 13.3, 3, 1239)


local function clientPickupHit(thePlayer, matchingDimension)
	if (thePlayer == getLocalPlayer() and getElementType(thePlayer) == "player") then
		if (source) then
			local pickupModel = getElementModel(source)
			local tick = 0
			if (pickupModel == 1212 and getElementData(getLocalPlayer(), "robbing") == "true") then
				robMoneyHit(source, thePlayer)
			elseif (pickupModel == 1212 and getElementData(getLocalPlayer(), "robbing") == "false") then
				destroyElement(source)
			elseif (pickupModel == 1279) then
				triggerServerEvent("handlePickedUpClient", getLocalPlayer(), pickupModel)
				destroyElement(source)
			end
		end
	end
end


function onClientHitInformation(p, matchingDimension)
	if (isElement(p) and p == localPlayer) then
		showHelpScreen()
	end
end



function displayJobScreen()
	if (source == localPlayer) then
		if not (getWindowDisplayed()) then
			showCursor(true)
			guiSetInputEnabled(true)
			GUIEditor.window[1] = guiCreateWindow(0, 0, 1596/1600*screenWidth, 873/900*screenHeight, "", false)
			guiWindowSetSizable(GUIEditor.window[1], false)
			guiSetAlpha(GUIEditor.window[1], 0.98)
			guiSetProperty(GUIEditor.window[1], "CaptionColour", "FFFF0000")

			GUIEditor.tabpanel[1] = guiCreateTabPanel(10/1600*screenWidth, 23/900*screenHeight, 970/1600*screenWidth, 834/900*screenHeight, false, GUIEditor.window[1])

			GUIEditor.tab[1] = guiCreateTab("police", GUIEditor.tabpanel[1])

			GUIEditor.button[1] = guiCreateButton(844/1600*screenWidth, 138/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Get Job", false, GUIEditor.tab[1])
			guiSetAlpha(GUIEditor.button[1], 0.57)
			guiSetFont(GUIEditor.button[1], "default-bold-small")
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF66F804")
			GUIEditor.button[2] = guiCreateButton(844/1600*screenWidth, 28/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Quit Job", false, GUIEditor.tab[1])
			guiSetAlpha(GUIEditor.button[2], 0.57)
			guiSetFont(GUIEditor.button[2], "default-bold-small")
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFF80303")

			GUIEditor.tab[2] = guiCreateTab("criminal", GUIEditor.tabpanel[1])
			
			GUIEditor.button[3] = guiCreateButton(844/1600*screenWidth, 138/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Get Job", false, GUIEditor.tab[2])
			guiSetAlpha(GUIEditor.button[3], 0.57)
			guiSetFont(GUIEditor.button[3], "default-bold-small")
			guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FF66F804")
			GUIEditor.button[4] = guiCreateButton(844/1600*screenWidth, 28/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Quit Job", false, GUIEditor.tab[2])
			guiSetAlpha(GUIEditor.button[4], 0.57)
			guiSetFont(GUIEditor.button[4], "default-bold-small")
			guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFF80303")
			
			GUIEditor.tab[3] = guiCreateTab("farmer", GUIEditor.tabpanel[1])
			
			GUIEditor.button[5] = guiCreateButton(844/1600*screenWidth, 138/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Get Job", false, GUIEditor.tab[3])
			guiSetAlpha(GUIEditor.button[5], 0.57)
			guiSetFont(GUIEditor.button[5], "default-bold-small")
			guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FF66F804")
			GUIEditor.button[6] = guiCreateButton(844/1600*screenWidth, 28/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Quit Job", false, GUIEditor.tab[3])
			guiSetAlpha(GUIEditor.button[6], 0.57)
			guiSetFont(GUIEditor.button[6], "default-bold-small")
			guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFF80303")
			
			GUIEditor.tab[4] = guiCreateTab("pilot", GUIEditor.tabpanel[1])
			
			GUIEditor.button[7] = guiCreateButton(844/1600*screenWidth, 138/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Get Job", false, GUIEditor.tab[4])
			guiSetAlpha(GUIEditor.button[7], 0.57)
			guiSetFont(GUIEditor.button[7], "default-bold-small")
			guiSetProperty(GUIEditor.button[7], "NormalTextColour", "FF66F804")
			GUIEditor.button[8] = guiCreateButton(844/1600*screenWidth, 28/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Quit Job", false, GUIEditor.tab[4])
			guiSetAlpha(GUIEditor.button[8], 0.57)
			guiSetFont(GUIEditor.button[8], "default-bold-small")
			guiSetProperty(GUIEditor.button[8], "NormalTextColour", "FFF80303")
				
			GUIEditor.tab[5] = guiCreateTab("test4", GUIEditor.tabpanel[1])
			GUIEditor.tab[6] = guiCreateTab("test5", GUIEditor.tabpanel[1])   
			
			GUIEditor.button[9] = guiCreateButton(1000/1600*screenWidth, 28/900*screenHeight, 116/1600*screenWidth, 37/900*screenHeight, "Close", false, GUIEditor.window[1])
			guiSetAlpha(GUIEditor.button[9], 0.57)
			guiSetFont(GUIEditor.button[9], "default-bold-small")
			guiSetProperty(GUIEditor.button[9], "NormalTextColour", "FFF80303")

			addEventHandler ( "onClientGUIClick", GUIEditor.button[1], startJob, false)
			addEventHandler ( "onClientGUIClick", GUIEditor.button[3], startJob, false)
			addEventHandler ( "onClientGUIClick", GUIEditor.button[5], startJob, false)
			addEventHandler ( "onClientGUIClick", GUIEditor.button[7], startJob, false)
			addEventHandler ( "onClientGUIClick", GUIEditor.button[2], quitJob, false)
			addEventHandler ( "onClientGUIClick", GUIEditor.button[4], quitJob, false)
			addEventHandler ( "onClientGUIClick", GUIEditor.button[6], quitJob, false)
			addEventHandler ( "onClientGUIClick", GUIEditor.button[8], quitJob, false)
			addEventHandler ( "onClientGUIClick", GUIEditor.button[9], closeJobInterface, false)
			addEventHandler("onClientRender", root, displayJobText)
			setElementFrozen(getLocalPlayer(), true)
		end
	end
end

function closeJobInterface()
	if (getWindowDisplayed()) then
		destroyAll()
		removeEventHandler("onClientRender", root, displayJobText)
		showCursor(false)
		guiSetInputEnabled(false)
		setElementFrozen(getLocalPlayer(), false)
	end
end

function quitJob()
	if (getWindowDisplayed()) then
		triggerServerEvent("quitJob", getLocalPlayer())
		closeJobInterface()
	end
end

function startJob()
	if (getWindowDisplayed()) then
	local tab = guiGetSelectedTab ( GUIEditor.tabpanel[1])
	if (tab == GUIEditor.tab[1]) then
		triggerServerEvent("startPoliceJob", getLocalPlayer())
	elseif (tab == GUIEditor.tab[2]) then
		triggerServerEvent("startGangsterJob", getLocalPlayer())
	elseif (tab == GUIEditor.tab[3]) then
		triggerServerEvent("startFarmerJob", getLocalPlayer())
	elseif (tab == GUIEditor.tab[4]) then
		triggerServerEvent("startPiloteJob", getLocalPlayer())
	end
		closeJobInterface()
	end
end





function displayJobText()
	if (getWindowDisplayed()) then
		local tab = guiGetSelectedTab ( GUIEditor.tabpanel[1])
		dxDrawRectangle(550/1600*screenWidth, 178/900*screenHeight, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawLine(594/1600*screenWidth, 187/900*screenHeight, 594/1600*screenWidth, 187/900*screenHeight, tocolor(255, 255, 255, 255), 1, true)
		dxDrawRectangle(864/1600*screenWidth, 153/900*screenHeight, 0, 102/900*screenHeight, tocolor(255, 255, 255, 255), true)
		dxDrawRectangle(296/1600*screenWidth, 247/900*screenHeight, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawText("Current Job : " ..getElementData(getLocalPlayer(), "jobType"), 22/1600*screenWidth, 58/900*screenHeight, 346/1600*screenWidth, 88/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
		if (getElementData(getLocalPlayer(), "jobType") == "Farmer") then
			dxDrawText("Current Progress : " ..getElementData(getLocalPlayer(), "tempJobProgress_farmer"), 27/1600*screenWidth, 115/900*screenHeight, 545/1600*screenWidth, 436/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
		elseif (getElementData(getLocalPlayer(), "jobType") == "Gangster") then
			dxDrawText("Current Progress : " ..getElementData(getLocalPlayer(), "tempJobProgress_gangster"), 27/1600*screenWidth, 115/900*screenHeight, 545/1600*screenWidth, 436/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
		elseif( getElementData(getLocalPlayer(), "jobType") == "Police") then
			dxDrawText("Current Progress : " ..getElementData(getLocalPlayer(), "tempJobProgress_police"), 27/1600*screenWidth, 115/900*screenHeight, 545/1600*screenWidth, 436/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
		elseif( getElementData(getLocalPlayer(), "jobType") == "Pilot") then
			dxDrawText("Current Progress : " ..getElementData(getLocalPlayer(), "tempJobProgress_pilote"), 27/1600*screenWidth, 115/900*screenHeight, 545/1600*screenWidth, 436/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
		end
		if (tab == GUIEditor.tab[1]) then
			if (getElementData(getLocalPlayer(), "tempJobProgress_police") >= 0 and getElementData(getLocalPlayer(), "tempJobProgress_police") < 100) then
				dxDrawText("Sergeant", 22/1600*screenWidth, 328/900*screenHeight, 540/1600*screenWidth, 360/900*screenHeight, tocolor(93, 242, 11, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
			elseif (getElementData(getLocalPlayer(), "tempJobProgress_police") >= 0 and getElementData(getLocalPlayer(), "tempJobProgress_police") < 100) then
				dxDrawText("FBI Agent", 22/1600*screenWidth, 328/900*screenHeight, 540/1600*screenWidth, 360/900*screenHeight, tocolor(93, 242, 11, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
			end
			dxDrawText("Start As Job Rank : Patrol Officer", 22/1600*screenWidth, 188/900*screenHeight, 540/1600*screenWidth, 220/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
			dxDrawText("Next Job Rank : Sergeant", 22/1600*screenWidth, 220/900*screenHeight, 540/1600*screenWidth, 252/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
		elseif (tab == GUIEditor.tab[2]) then
			if (getElementData(getLocalPlayer(), "tempJobProgress_gangster") >= 0 and getElementData(getLocalPlayer(), "tempJobProgress_gangster") < 100) then
				dxDrawText("Crook", 22/1600*screenWidth, 328/900*screenHeight, 540/1600*screenWidth, 360/900*screenHeight, tocolor(93, 242, 11, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
			elseif (getElementData(getLocalPlayer(), "tempJobProgress_gangster") >= 0 and getElementData(getLocalPlayer(), "tempJobProgress_gangster") < 100) then
					dxDrawText("Gangster Boss", 22/1600*screenWidth, 328/900*screenHeight, 540/1600*screenWidth, 360/900*screenHeight, tocolor(93, 242, 11, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
			end
			dxDrawText("Start As Job Rank : Gangster", 22/1600*screenWidth, 188/900*screenHeight, 540/1600*screenWidth, 220/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
			dxDrawText("Next Job Rank : BOSS OR SOMETHING?", 22/1600*screenWidth, 220/900*screenHeight, 540/1600*screenWidth, 252/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
		elseif (tab == GUIEditor.tab[3]) then
			if (getElementData(getLocalPlayer(), "tempJobProgress_farmer") >= 0 and getElementData(getLocalPlayer(), "tempJobProgress_farmer") < 100) then
				dxDrawText("Lead Farmer", 22/1600*screenWidth, 328/900*screenHeight, 540/1600*screenWidth, 360/900*screenHeight, tocolor(93, 242, 11, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
			elseif (getElementData(getLocalPlayer(), "tempJobProgress_farmer") >= 100 and getElementData(getLocalPlayer(), "tempJobProgress_farmer") < 200) then
				dxDrawText("Council Farmer", 22/1600*screenWidth, 328/900*screenHeight, 540/1600*screenWidth, 360/900*screenHeight, tocolor(93, 242, 11, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
			end
			dxDrawText("Start As Job Rank : Farmer", 22/1600*screenWidth, 188/900*screenHeight, 540/1600*screenWidth, 220/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
			dxDrawText("Next Job Rank : PRO FARMER? not sure", 22/1600*screenWidth, 220/900*screenHeight, 540/1600*screenWidth, 252/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
		elseif (tab == GUIEditor.tab[4]) then
			if (getElementData(getLocalPlayer(), "tempJobProgress_pilote") >= 0 and getElementData(getLocalPlayer(), "tempJobProgress_pilote") < 100) then
				dxDrawText("Head pilot", 22/1600*screenWidth, 328/900*screenHeight, 540/1600*screenWidth, 360/900*screenHeight, tocolor(93, 242, 11, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
			elseif (getElementData(getLocalPlayer(), "tempJobProgress_pilote") >= 100 and getElementData(getLocalPlayer(), "tempJobProgress_pilote") <= 200) then
				dxDrawText("Airline investigator", 22/1600*screenWidth, 328/900*screenHeight, 540/1600*screenWidth, 360/900*screenHeight, tocolor(93, 242, 11, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
			end
			dxDrawText("Start As Job Rank : Co-pilot", 22/1600*screenWidth, 188/900*screenHeight, 540/1600*screenWidth, 220/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
			dxDrawText("Next Job Rank : Head pilot", 22/1600*screenWidth, 220/900*screenHeight, 540/1600*screenWidth, 252/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, "bankgothic", "left", "top", false, false, true, false, false)
		end
		
		dxDrawLine(12/1600*screenWidth, 148/900*screenHeight, 977/1600*screenWidth, 148/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, true)
		dxDrawLine(12/1600*screenWidth, 274/900*screenHeight, 977/1600*screenWidth, 274/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, true)
		dxDrawLine(12/1600*screenWidth, 388/900*screenHeight, 977/1600*screenWidth, 388/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, true)
		dxDrawRectangle(27/1600*screenWidth, 454/900*screenHeight, 834/1600*screenWidth, 20/900*screenHeight, tocolor(7, 248, 1, 255), true)
		dxDrawRectangle(27/1600*screenWidth, 454/900*screenHeight, 834/1600*screenWidth, 20/900*screenHeight, tocolor(0, 0, 0, 255), true)
		dxDrawText("Promotion Ranking :", 22/1600*screenWidth, 286/900*screenHeight, 540/1600*screenWidth, 318/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900-0.30, "bankgothic", "left", "top", false, false, true, false, false)
		dxDrawLine(12/1600*screenWidth, 508/900*screenHeight, 977/1600*screenWidth, 508/900*screenHeight, tocolor(255, 255, 255, 255), screenHeight/900, true)
	end
end


addCommandHandler ( "job", displayJobScreen)

--CLIENT EVENTS--

addEvent("displayJobScreen", true)
addEventHandler("displayJobScreen", localPlayer, displayJobScreen)

addEventHandler("onClientPickupHit", information_icon_farmer, onClientHitInformation)
addEventHandler("onClientPickupHit", information_icon_police, onClientHitInformation)
addEventHandler("onClientPickupHit", root, clientPickupHit)
