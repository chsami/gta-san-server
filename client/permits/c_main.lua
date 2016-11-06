
local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)


local page_number = 0

function drawPermits()
	if (getWindowDisplayed()) then 
		local scale = 0.6*screenHeight/900
		local permits = ""
		local hasPermit = 0
		permit = "Car permit"
		permit = "Fly permit"
		permit = "Fight permit"
		permit = "Store permit"
		permit = "Life permit"
		if (page_number == 0) then
			permit = "Car permit"
			hasPermit = getElementData(localPlayer, "permit_car")
		elseif (page_number == 1) then
			permit = "Fighting permit"
			hasPermit = getElementData(localPlayer, "permit_fight")
		elseif (page_number == 2) then
			permit = "Fly permit"
			hasPermit = getElementData(localPlayer, "permit_fly")
		elseif (page_number == 3) then
			permit = "Store permit"
			hasPermit = getElementData(localPlayer, "permit_store")
		elseif (page_number == 4) then
			permit = "Life permit"
			hasPermit = getElementData(localPlayer, "permit_life")
		end
		if (hasPermit == 0 or hasPermit == nil) then
			hasPermit = tostring(hasPermit)
			hasPermit = "No"
		else
			hasPermit = tostring(hasPermit)
			hasPermit = "Yes"
		end
		dxDrawText(permit, 820/1600*screenWidth, 392/900*screenHeight, 987/1600*screenWidth, 422/900*screenHeight, tocolor(5, 0, 0, 200), scale, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawImage ( screenWidth/3, screenHeight/3, 512/1600*screenWidth, 340/900*screenHeight, 'conf/images/paper.png')
		dxDrawText("Name :", 581/1600*screenWidth, 334/900*screenHeight, 749/1600*screenWidth, 289/900*screenHeight, tocolor(0, 0, 0, 200), scale, "bankgothic", "left", "top", false, false, true, false, false)
		dxDrawText("Permit name :", 581/1600*screenWidth, 399/900*screenHeight, 749/1600*screenWidth, 354/900*screenHeight, tocolor(0, 0, 0, 200), scale, "bankgothic", "left", "top", false, false, true, false, false)
		dxDrawText("Owned : ", 581/1600*screenWidth, 464/900*screenHeight, 749/1600*screenWidth, 419/900*screenHeight, tocolor(0, 0, 0, 200), scale, "bankgothic", "left", "top", false, false, true, false, false)
		dxDrawText(getPlayerName(localPlayer), 820/1600*screenWidth, 327/900*screenHeight, 987/1600*screenWidth, 357/900*screenHeight, tocolor(5, 0, 0, 200), scale, "bankgothic", "center", "center", false, false, true, false, false)
		
		dxDrawText(tostring(hasPermit), 820/1600*screenWidth, 461/900*screenHeight, 987/1600*screenWidth, 491/900*screenHeight, tocolor(5, 0, 0, 200), scale, "bankgothic", "center", "center", false, false, true, false, false)
		
		dxDrawText("Current job : ", 581/1600*screenWidth, 525/900*screenHeight, 749/1600*screenWidth, 419/900*screenHeight, tocolor(0, 0, 0, 200), scale, "bankgothic", "left", "top", false, false, true, false, false)
		
		dxDrawText(tostring(getElementData(localPlayer, "jobType")), 820/1600*screenWidth, 570/900*screenHeight, 987/1600*screenWidth, 491/900*screenHeight, tocolor(5, 0, 0, 200), scale, "bankgothic", "center", "center", false, false, true, false, false)
	else
		handleClosePermitInterfaceBtn()
	end
	  
end

function drawButtons()
	page_number = 0
	if not (getWindowDisplayed()) then
		GUIEditor.window[1] = guiCreateWindow ( 0, 0, 0, 0, "", false )
		guiSetAlpha ( GUIEditor.window[1], 0 )
		GUIEditor.button[1] = guiCreateButton(0.58, 0.64, 0.04, 0.03, ">>", true)
		GUIEditor.button[2] = guiCreateButton(0.36, 0.64, 0.04, 0.03, "<<", true)
		GUIEditor.button[3] = guiCreateButton(993/1600*screenWidth, 307/900*screenHeight, 15/1600*screenWidth, 15/900*screenHeight, "X", false)
		guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFE50000")  
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleNextPageBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handlePreviousPageBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[3], handleClosePermitInterfaceBtn, false)
	end
end

function handleNextPageBtn()
	if (page_number == 0) then
		page_number = page_number + 1
	elseif (page_number == 1) then
		page_number = page_number + 1
	elseif (page_number == 2) then
		page_number = page_number + 1
	elseif (page_number == 3) then
		page_number = page_number + 1
	elseif (page_number == 4) then
		page_number = 0
	end
end

function handlePreviousPageBtn()
	if (page_number == 0) then
		page_number = 4
	elseif (page_number == 1) then
		page_number = page_number - 1
	elseif (page_number == 2) then
		page_number = page_number - 1
	elseif (page_number == 3) then
		page_number = page_number - 1
	elseif (page_number == 4) then
		page_number = page_number - 1
	end
end



function handleClosePermitInterfaceBtn()
	if (getWindowDisplayed()) then 
		destroyAll()--destroy everything in the interface
	end
	showCursor(false)
	setElementFrozen(localPlayer, false)
	hidePermits()
end

function showPermits()
	if not (getWindowDisplayed()) then 
		drawButtons()
		addEventHandler("onClientRender", root, drawPermits)
	else
		hidePermits()
		destroyAll()
	end
end

function hidePermits()
	removeEventHandler("onClientRender", root, drawPermits)
end
