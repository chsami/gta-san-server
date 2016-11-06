
local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)


local ROB_TIMER_SMALL = 30000 -- 30 seconds
local RUN_TIMER_SMALL = 60000  -- 60 seconds
local cash_loot = 0
local dx_shown = false
local time_left = 0

local cash_object = nil


function finishCashCollecting(total_money)
	outputChatBox("You finished collecting $"..total_money)
end


function showDrawDxRobbingText()
	if (dx_shown == false) then
		addEventHandler("onClientRender", getRootElement(), drawDxRobbingText)
		dx_shown = true
	end
end

function hideDrawDxRobbingText()
	removeEventHandler("onClientRender", getRootElement(), drawDxRobbingText)
	dx_shown = false
end

function drawDxRobbingText()
	if (getElementInterior(localPlayer) == 9 and isLoggedIn()) then
		local scale = 1.00/900*screenHeight
		if (cash_loot > 0) then
			dxDrawText("Cash : "..cash_loot.."$ \nTime : " ..time_left, 1251/1600*screenWidth, 720/900*screenHeight, 1577/1600*screenWidth, 816/900*screenHeight, tocolor(254, 0, 0, 255), scale, "pricedown", "left", "top", false, false, true, false, false)
		end
	else
		hideDrawDxRobbingText()
	end
end

function robMoneyHit(thePickup, thePlayer)
    if (thePlayer == getLocalPlayer()) then
		if (getElementModel(thePickup) == 1212) then
			local rnd = math.random(10, 50)
			local total_cash = rnd + getElementData(getLocalPlayer(), "rob_cash")
			setElementData(getLocalPlayer(), "rob_cash", total_cash)
			destroyElement(thePickup)
			respawnNewStack()
		end
	end--security
end

function respawnNewStack()
	local cash = nil
	if (getElementData(getLocalPlayer(), "robbing") == "true" and getElementData(getLocalPlayer(), "arrested") == "false") then
		local x = math.random(364, 371)
		cash = createPickup ( x, -7, 1001, 3, 1212)
		setElementInterior(cash, getElementInterior(getLocalPlayer()))
		playSFX("genrl", 53, 7, false)
		if (getElementInterior(getLocalPlayer()) == 9) then
			local rnd = math.random(1, 40)
			if (rnd == 1) then
				playSFX("spc_fa", 17, 15, false)
			elseif (rnd == 2) then
				playSFX("spc_fa", 17, 16, false)
			elseif( rnd == 3) then
				playSFX("spc_fa", 17, 17, false)
			elseif( rnd == 4) then
				playSFX("spc_fa", 17, 18, false)
			elseif( rnd == 5) then
				playSFX("spc_fa", 17, 19, false)
			elseif ( rnd == 6) then
				playSFX("spc_fa", 17, 25, false)
			elseif ( rnd == 7) then
				playSFX("spc_fa", 17, 27, false)
			elseif ( rnd == 8) then
				playSFX("spc_fa", 17, 28, false)
			end
		end
	end
end

function drawCriminalJobInterface()
	if (source == localPlayer) then
		if not (getWindowDisplayed()) then
			if (isLoggedIn()) then
				GUIEditor.window[1] = guiCreateWindow(0.34, 0.21, 0.37, 0.54, "Los santos criminal depot", true)
				guiWindowSetSizable(GUIEditor.window[1], false)

				GUIEditor.button[1] = guiCreateButton(0.14, 0.77, 0.26, 0.11, "Become a criminal!", true, GUIEditor.window[1])
				guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF1DFE00")
				GUIEditor.button[2] = guiCreateButton(0.57, 0.77, 0.26, 0.11, "Buy drugs", true, GUIEditor.window[1])
				guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF1DFE00")
				GUIEditor.button[3] = guiCreateButton(0.91, 0.06, 0.07, 0.06, "", true, GUIEditor.window[1])
				guiSetAlpha(GUIEditor.button[3], 0.00)   
				addEventHandler("onClientGUIClick", GUIEditor.button[1], handleShowSkinPickInterface, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[2], handleBuyDrugsBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[3], handleCloseCriminalJobInterface, false)
				showCursor(true)
				showDXCriminalInterface()
			end
		end
	end
end

addEvent("showCriminalJob", true)
addEventHandler("showCriminalJob", localPlayer, drawCriminalJobInterface)


function handleShowSkinPickInterface()
	if (getWindowDisplayed()) then
		handleCloseCriminalJobInterface()
		drawCriminalSkinInterface()
	end
end

function handleBuyDrugsBtn()
	if (getWindowDisplayed()) then
		outputChatBox("There are not drugs left.")
		handleCloseCriminalJobInterface()
	end
end

function handleCloseCriminalJobInterface()
	destroyAll()
	showCursor(false)
	hideDXCriminalInterface()
end

function drawDXCriminalInterface()
        dxDrawImage(1082/1600*screenWidth, 220/900*screenHeight, 18/1600*screenWidth, 20/900*screenHeight, ":ghetto/conf/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("Welcome to the criminal hideout", 595/1600*screenWidth, 291/900*screenHeight, 1061/1600*screenWidth, 459/900*screenHeight, tocolor(255, 255, 255, 255), 0.70/900*screenHeight, "bankgothic", "center", "center", false, true, true, false, false)
end

function showDXCriminalInterface()
	addEventHandler("onClientRender", root, drawDXCriminalInterface)
end

function hideDXCriminalInterface()
	removeEventHandler("onClientRender", root, drawDXCriminalInterface)
end


local skins = {105, 102, 114, 108, 121, 173, 117, 247, 111, 124}
local temp_save_skin = nil

function drawCriminalSkinInterface()
	if not (getWindowDisplayed()) then
		temp_save_skin = getElementModel(localPlayer)
		local x, y, z = getElementPosition(localPlayer)
        GUIEditor.window[1] = guiCreateWindow(0.15, -0.00, 0.26, 0.65, "Criminal job", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetAlpha(GUIEditor.window[1], 1.00)

        GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.13, 0.95, 0.59, true, GUIEditor.window[1])
        buildCriminalSkinList()
		if (getCurrentJob() ~= "criminal") then
			GUIEditor.button[1] = guiCreateButton(0.33, 0.74, 0.34, 0.12, "Become a criminal", true, GUIEditor.window[1])
		else
			GUIEditor.button[1] = guiCreateButton(0.33, 0.74, 0.34, 0.12, "Change skin", true, GUIEditor.window[1])
		end
        GUIEditor.button[2] = guiCreateButton(0.93, 0.04, 0.04, 0.04, "X", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")   
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleBecomeCriminalBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleCloseCriminalSkinInterfaceBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], handlePickCriminalSkinBtn, false)
		showCursor(true)
		setCameraMatrix(1000.3358154297, -1372.8009033203, 16.438709259033, 1078.9136962891, -1316.796875, -9.8114910125732, 0, 70)--criminalz

	end
end

function handlePickCriminalSkinBtn()
	if (getWindowDisplayed()) then
		local skinId = getListItem(1)
		if (skinId ~= nil) then
			setElementModel(localPlayer, skinId)
		end
	end
end	

function buildCriminalSkinList()
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

function handleBecomeCriminalBtn()
	if (getWindowDisplayed()) then
		local skinId = getListItem(1)
		if (skinId ~= nil) then
			setCameraTarget(localPlayer)
			triggerServerEvent("setNewJob", localPlayer, "criminal", skinId)
			setCurrentJob("criminal")
			destroyAll()
			showCursor(false)
		end
	end
end

function handleCloseCriminalSkinInterfaceBtn()
	destroyAll()
	showCursor(false)
	if (temp_save_skin ~= nil) then setElementModel(localPlayer, temp_save_skin) end
end


function handleInitializePlayerRob()
	if (source == localPlayer) then
		local x, y, z = getElementPosition(localPlayer)
		cash_object = createObject ( 1212, x, y+1, z-0.5)
		setElementInterior(cash_object, 9)
		setObjectScale ( cash_object, 2.2)
		showDrawDxRobbingText()
	end
end

addEvent("initializePlayerRob", true)
addEventHandler("initializePlayerRob", localPlayer, handleInitializePlayerRob)

function handleRobProcess(_, par_cash_loot, par_time_left)
	if (source == localPlayer and isLoggedIn()) then
		if (par_time_left > 1) then
			time_left = par_time_left
			cash_loot = par_cash_loot
		else
			handleStopRob(par_cash_loot)
		end
	end
end

function handleStopRob(par_cash_loot)
	finishCashCollecting(par_cash_loot)
	if (isElement(cash_object)) then
		destroyElement(cash_object)
	end
	hideDrawDxRobbingText()
end

addEvent("rob_process", true)
addEventHandler("rob_process", localPlayer, handleRobProcess)


function cancelPedDamage ( attacker )
	if (getElementModel(source) == 155 and getElementModel(source) == 7) then
		cancelEvent() -- cancel any damage done to peds
	end
end

--CLIENT EVENTS--

addEventHandler ( "onClientPedDamage", getRootElement(), cancelPedDamage )

