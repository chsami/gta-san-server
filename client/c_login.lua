local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height

local counter = 0

playerLoggedIn = false

local fileHandle = nil


function handleSuccesLogin(_, loggedIn)
	if (source == localPlayer) then
		if (loggedIn == 1) then
			playerLoggedIn = true
		else
			playerLoggedIn = false
		end
	end
end

function isLoggedIn()
	if (playerLoggedIn) then
		return true
	end
	return false
end

addEventHandler("onClientResourceStart", resourceRoot,
    function()    
    end
)

local time = getRealTime()
local hour = time.hour
local minutes = time.minute 
local seconds = time.second

local clockTimer = nil

function buildLoginPanel()
	drawLoginPanel()
	guiSetInputEnabled(true)
	showCursor(true)
	setDevelopmentMode ( true )
	showTime(true)
	addEvent("succesLogin", true)
	addEventHandler("succesLogin", localPlayer, handleSuccesLogin)
	loadPedsWorldMap()
	sendEncryptKey()
end

function drawDXTime()
	if (isLoggedIn()) then
		dxDrawText("Realtime : " ..hour.. ":"..minutes..":"..seconds, 800/1600*screenWidth, 800/900*screenHeight, 1200/1600*screenWidth, 800/900*screenHeight, tocolor(255, 255, 255, 255), 0.8*screenHeight/900, "bankgothic", "left", "center", false, false, true, false, false)
	end
end


function handleShowTime()
	addEventHandler("onClientRender", root, drawDXTime)
end

function handleHideTime()
	removeEventHandler("onClientRender", root, drawDXTime)
end


function sendEncryptKey()
	triggerServerEvent("simpleEncrypt", localPlayer, "C0123456789CazertyuiopC")
end



function showTime(state)
	if (state == true and not isTimer(clockTimer)) then
		handleShowTime()
	end
	if (state == true) then
	clockTimer = setTimer(function()
		
			--local x, y, z, vx, vy, vz, roll, view = getCameraMatrix ()
			time = getRealTime()
			hour = time.hour
			minutes = time.minute
			seconds = time.second
			--outputChatBox("x : " ..round(x,0).. " y : " ..round(y,0).. " z : " ..round(z,0).. " viewX : " ..round(vx,0).. " viewY : " ..round(vy,0).. " vz : " ..round(vz,0).. " roll : " ..roll.. " view : " ..view)
	end, 1000, 0)
	else
		if (isTimer(clockTimer)) then
			killTimer(clockTimer)
			handleHideTime()
		end
	end
end

function storeCameraPosition(commandName, description)
	local x, y, z, vx, vy, vz, roll, view = getCameraMatrix ()
	fileHandle = fileCreate(description..".txt")
	if fileHandle then                                    -- check if the creation succeeded
		fileWrite(fileHandle, "setCameraMatrix("..x..", "..y.."y, " ..z..", " ..vx..", " ..vy..", " ..vz..", " ..roll..", "..view..")--"..description.."\n")     -- write a text line
		fileClose(fileHandle)                             -- close the file once you're done with it
	end
end

addCommandHandler("store", storeCameraPosition)

function loginPanel(_, thePlayer)
	if (thePlayer == getLocalPlayer()) then
		playerLoggedIn = false
		destroyAll() --destroy all current interfaces
		drawLoginPanel()
		guiSetInputEnabled(true)
		showCursor(true)
		sendEncryptKey()
	end
end

function drawLoginPanel()
	GUIEditor.window[1] = guiCreateWindow(0.32, 0.25, 0.41, 0.33, "", true)
	guiWindowSetSizable(GUIEditor.window[1], false)
	guiWindowSetMovable(GUIEditor.window[1], false)

	GUIEditor.button[1] = guiCreateButton(0.67, 0.81, 0.18, 0.11, "Register", true, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(0.12, 0.81, 0.18, 0.11, "Login", true, GUIEditor.window[1])
	GUIEditor.edit[1] = guiCreateEdit(0.15, 0.33, 0.18, 0.10, "", true, GUIEditor.window[1]) --name login
	GUIEditor.edit[2] = guiCreateEdit(0.20, 0.51, 0.18, 0.10, "", true, GUIEditor.window[1]) --password login
	GUIEditor.edit[3] = guiCreateEdit(0.71, 0.15, 0.18, 0.10, "", true, GUIEditor.window[1]) --username register
	GUIEditor.edit[4] = guiCreateEdit(0.71, 0.33, 0.18, 0.10, "", true, GUIEditor.window[1]) --npassword1 register
	GUIEditor.edit[5] = guiCreateEdit(0.71, 0.51, 0.18, 0.10, "", true, GUIEditor.window[1]) --password2 register
	
	--configuration of the editfields
	guiEditSetMasked(GUIEditor.edit[2], true) --password field for login
	guiEditSetMasked(GUIEditor.edit[4], true) --password field for registration1
	guiEditSetMasked(GUIEditor.edit[5], true) --password field for registration2
	guiEditSetMaxLength(GUIEditor.edit[1], 30) --length of the field is 30
	guiEditSetMaxLength(GUIEditor.edit[2], 30) --length of the field is 30
	guiEditSetMaxLength(GUIEditor.edit[4], 30) --length of the field is 30
	guiEditSetMaxLength(GUIEditor.edit[3], 30) --length of the field is 30
	guiEditSetMaxLength(GUIEditor.edit[5], 30) --length of the field is 30


	GUIEditor.window[2] = guiCreateWindow(0.12, 0.25, 0.17, 0.33, "", true)
	guiWindowSetSizable(GUIEditor.window[2], false)
	guiSetAlpha(GUIEditor.window[2], 0.73)

	GUIEditor.memo[1] = guiCreateMemo(0.03, 0.13, 0.93, 0.83, "Welcome to the ghetto,\nTry to survive and become the big leader who runs the city!", true, GUIEditor.window[2]) 

	addEventHandler("onClientGUIClick", GUIEditor.button[1], handleRegisterButton, false)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[2], handleLoginButton, false)	


	addEventHandler("onClientRender", root, drawDXLoginPanel)
	


end


function drawDXLoginPanel()
	dxDrawLine(820/1600*screenWidth, 242/900*screenHeight, 820/1600*screenWidth, 511/900*screenHeight, tocolor(255, 255, 255, 255), 1/900*screenHeight, true)
	dxDrawText("Name:", 517/1600*screenWidth, 324/900*screenHeight, 578/1600*screenWidth, 344/900*screenHeight, tocolor(255, 255, 255, 255), 0.50/900*screenHeight, "bankgothic", "left", "top", false, false, true, false, false)
	dxDrawText("Password:", 513/1600*screenWidth, 379/900*screenHeight, 574/1600*screenWidth, 399/900*screenHeight, tocolor(255, 255, 255, 255), 0.50/900*screenHeight, "bankgothic", "left", "top", false, false, true, false, false)
	dxDrawText("Name:", 841/1600*screenWidth, 274/900*screenHeight, 902/1600*screenWidth, 294/900*screenHeight, tocolor(255, 255, 255, 255), 0.50/900*screenHeight, "bankgothic", "left", "top", false, false, true, false, false)
	dxDrawText("Password:", 841/1600*screenWidth, 325/900*screenHeight, 902/1600*screenWidth, 345/900*screenHeight, tocolor(255, 255, 255, 255), 0.50/900*screenHeight, "bankgothic", "left", "top", false, false, true, false, false)
	dxDrawText("Password:", 841/1600*screenWidth, 379/900*screenHeight, 902/1600*screenWidth, 399/900*screenHeight, tocolor(255, 255, 255, 255), 0.50/900*screenHeight, "bankgothic", "left", "top", false, false, true, false, false)
	dxDrawText("Register", 965/1600*screenWidth, 244/900*screenHeight, 1026/1600*screenWidth, 264/900*screenHeight, tocolor(255, 255, 255, 255), 0.50/900*screenHeight, "bankgothic", "left", "top", false, false, true, false, false)
	dxDrawText("Login", 606/1600*screenWidth, 252/900*screenHeight, 667/1600*screenWidth, 272/900*screenHeight, tocolor(255, 255, 255, 255), 0.50/900*screenHeight, "bankgothic", "left", "top", false, false, true, false, false)
end

function drawDXErrorMessage()
	dxDrawText(message, 657/1600*screenWidth, 341/900*screenHeight, 928/1600*screenWidth, 377/900*screenHeight, tocolor(255, 0, 0, 255), 0.45/900*screenHeight, "bankgothic", "center", "top", false, false, true, false, false)
end



function drawErrorMessage(_, thePlayer, par_message)
	if (thePlayer == getLocalPlayer()) then
		if (GUIEditor.window[3] == nil) then
			message = par_message
			removeEventHandler("onClientRender", root, drawDXLoginPanel)
			GUIEditor.window[3] = guiCreateWindow(0.30, 0.33, 0.40, 0.13, "Error message", true)
			guiWindowSetSizable(GUIEditor.window[3], false)

			GUIEditor.button[3] = guiCreateButton(0.39, 0.71, 0.23, 0.21, "OK", true, GUIEditor.window[3])
			
			addEventHandler("onClientRender", root, drawDXErrorMessage)
			
			addEventHandler("onClientGUIClick", GUIEditor.button[3], handleOkErrorMessageButton, false)
			if (GUIEditor.window[1]) then
				guiSetVisible(GUIEditor.window[1], false)
			end
			if (GUIEditor.window[2]) then
				guiSetVisible(GUIEditor.window[2], false)
			end
			guiSetInputEnabled(true)
			showCursor(true)
		end
	end
end

function handleOkErrorMessageButton()
	guiSetInputEnabled(false)
	showCursor(false)
	if (GUIEditor.window[1]) then
		guiSetVisible(GUIEditor.window[1], true)
	end
	if (GUIEditor.window[2]) then
		guiSetVisible(GUIEditor.window[2], true)
	end
	destroyElement(GUIEditor.window[3])
	GUIEditor.window[3] = nil
	if (GUIEditor.window[1] and GUIEditor.window[2]) then
		addEventHandler("onClientRender", root, drawDXLoginPanel)
		guiSetInputEnabled(true)
		showCursor(true)
	end
	removeEventHandler("onClientRender", root, drawDXErrorMessage)
	
end




function handleRegisterButton(button, state)
	local username = guiGetText(GUIEditor.edit[3])
	local password1 = guiGetText(GUIEditor.edit[4])
	local password2 = guiGetText(GUIEditor.edit[5])
	if (username ~= "" and password1 ~= "" and password2 ~= "") then
		if (password1 == password2) then
			if(username ~= "player" or username ~= "players" or username ~= "admin" or username == "moderator" or username == "mod") then
				if (string.len(password1) >= 5) then
					local checkName = string.find(username, "[*+-/%¨$µ=:;_)àç!è§('&]") --characters that are not allowed
					if (checkName == nil) then
						triggerServerEvent("registerPlayer", getLocalPlayer(), username, password1)
					else
						drawErrorMessage(_, getLocalPlayer(), "Your name contains invalid characters!")
					end
				else
					drawErrorMessage(_, getLocalPlayer(), "Your password must be at least 5 characters long!")
				end
			else
				drawErrorMessage(_, getLocalPlayer(), "You are not allowed to take that name!")
			end
		else
			drawErrorMessage(_, getLocalPlayer(), "Your password fields are not the same!")
		end
	else
		drawErrorMessage(_, getLocalPlayer(), "Fields are empty!")
	end
end

function drawSuccesfullMessage(_, thePlayer, par_message)
	if (thePlayer == getLocalPlayer()) then
		message = par_message
		removeEventHandler("onClientRender", root, drawDXLoginPanel)
		GUIEditor.window[4] = guiCreateWindow(0.30, 0.33, 0.40, 0.13, "Registered", true)
		guiWindowSetSizable(GUIEditor.window[1], false)

		GUIEditor.button[4] = guiCreateButton(0.31, 0.73, 0.23, 0.21, "OK", true, GUIEditor.window[4])
		
		addEventHandler("onClientRender", root, drawDXErrorMessage)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[4], handleOkSuccesMessage, false)
			  
		guiSetVisible(GUIEditor.window[1], false)
		guiSetVisible(GUIEditor.window[2], false)
	end
end

function handleOkSuccesMessage()
	guiSetVisible(GUIEditor.window[1], true)
	guiSetVisible(GUIEditor.window[2], true)
	destroyElement(GUIEditor.window[4])
	GUIEditor.window[4] = nil
	removeEventHandler("onClientRender", root, drawDXErrorMessage)
	addEventHandler("onClientRender", root, drawDXLoginPanel)
end

function handleLoginButton(button, state)
	local pressButton = false
	if (pressButton == false) then
		pressButton = true
		local username = guiGetText(GUIEditor.edit[1])
		local password = guiGetText(GUIEditor.edit[2])
		if (username ~= "" and password ~= "") then
			triggerServerEvent("loginPlayer", getLocalPlayer(), string.lower(username), password)
		end
		setTimer(function()
			pressButton = false
		end, 1000, 1)
	else
		outputChatBox("Account is logging in...", getLocalPlayer())
	end
end

function closeAll(_, thePlayer)
	if (thePlayer == getLocalPlayer()) then
		destroyElement(GUIEditor.window[1])
		destroyElement(GUIEditor.window[2])
		GUIEditor.window[1] = nil
		GUIEditor.window[2] = nil
		GUIEditor.window[4] = nil
		GUIEditor.window[5] = nil
		removeEventHandler("onClientRender", root, drawDXLoginPanel)
		guiSetInputEnabled(false)
		showCursor(false)
	end
end

function drawLoadingText()
	if (counter < 40) then
		dxDrawText("LOADING ", 537/1600*screenWidth, 331/900*screenHeight, 1052/1600*screenWidth, 482/900*screenHeight, tocolor(255, 255, 255, 255), 1.00/900*screenHeight, "bankgothic", "center", "center", false, false, true, false, false)
	elseif (counter >= 40 and counter < 80) then
		dxDrawText("LOADING . ", 537/1600*screenWidth, 331/900*screenHeight, 1052/1600*screenWidth, 482/900*screenHeight, tocolor(255, 255, 255, 255), 1.00/900*screenHeight, "bankgothic", "center", "center", false, false, true, false, false)
	elseif (counter >= 80 and counter < 130) then
		dxDrawText("LOADING . .", 537/1600*screenWidth, 331/900*screenHeight, 1052/1600*screenWidth, 482/900*screenHeight, tocolor(255, 255, 255, 255), 1.00/900*screenHeight, "bankgothic", "center", "center", false, false, true, false, false)
	elseif (counter >= 130 and counter < 160) then
		dxDrawText("LOADING . . .", 537/1600*screenWidth, 331/900*screenHeight, 1052/1600*screenWidth, 482/900*screenHeight, tocolor(255, 255, 255, 255), 1.00/900*screenHeight, "bankgothic", "center", "center", false, false, true, false, false)
	elseif (counter >= 160) then
		counter = 0
	end
	counter = counter + 1
end

function startLoading()
	if (source == localPlayer) then
		addEventHandler("onClientRender", root, drawLoadingText)
	end
end

function stopLoading()
	if (source == localPlayer) then
		removeEventHandler("onClientRender", root, drawLoadingText)
	end
end

function informationBoard(_, thePlayer)
	if (thePlayer == getLocalPlayer()) then
		GUIEditor.window[4] = guiCreateWindow(0.27, 0.04, 0.44, 0.56, "Information", true)
		guiWindowSetSizable(GUIEditor.window[4], false)

		GUIEditor.gridlist[1] = guiCreateGridList(0.01, 0.05, 0.30, 0.46, true, GUIEditor.window[4])
		guiGridListAddColumn(GUIEditor.gridlist[1], "Player type", 0.9)
		guiGridListSetItemText ( GUIEditor.gridlist[1], guiGridListAddRow (GUIEditor.gridlist[1]), 1, "criminal", false, true )
		guiGridListSetItemText ( GUIEditor.gridlist[1], guiGridListAddRow (GUIEditor.gridlist[1]), 1, "farmer", false, true )
		guiGridListSetItemText ( GUIEditor.gridlist[1], guiGridListAddRow (GUIEditor.gridlist[1]), 1, "police", false, true )
		GUIEditor.button[5] = guiCreateButton(0.02, 0.54, 0.28, 0.09, "Spawn", true, GUIEditor.window[4])
		guiSetFont(GUIEditor.button[5], "default-bold-small")
		guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FF36FD01") 

		addEventHandler("onClientGUIClick", GUIEditor.button[5], handleSpawnButton, false)		
		
		addEventHandler("onClientRender", root, drawDXInformationBoard)
		
		guiSetInputEnabled(true)
		showCursor(true)
	
	end
end

function drawDXInformationBoard()
	dxDrawText("hello\nhello\nhello\nhello\nhello\nhello", 731/1600*screenWidth, 72/900*screenHeight, 1122/1600*screenWidth, 512/900*screenHeight, tocolor(0, 0, 0, 255), 1.00/900*screenHeight, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("hello\nhello\nhello\nhello\nhello\nhello", 731/1600*screenWidth, 70/900*screenHeight, 1122/1600*screenWidth, 510/900*screenHeight, tocolor(0, 0, 0, 255), 1.00/900*screenHeight, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("hello\nhello\nhello\nhello\nhello\nhello", 729/1600*screenWidth, 72/900*screenHeight, 1120/1600*screenWidth, 512/900*screenHeight, tocolor(0, 0, 0, 255), 1.00/900*screenHeight, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("hello\nhello\nhello\nhello\nhello\nhello", 729/1600*screenWidth, 70/900*screenHeight, 1120/1600*screenWidth, 510/900*screenHeight, tocolor(0, 0, 0, 255), 1.00/900*screenHeight, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawText("hello\nhello\nhello\nhello\nhello\nhello", 730/1600*screenWidth, 71/900*screenHeight, 1121/1600*screenWidth, 511/900*screenHeight, tocolor(255, 255, 255, 255), 1.00/900*screenHeight, "default-bold", "center", "center", false, false, true, false, false)
	dxDrawLine(728/1600*screenWidth, 71/900*screenHeight, 728/1600*screenWidth, 512/900*screenHeight, tocolor(77, 77, 77, 255), 3/900*screenHeight, true)
	dxDrawLine(727/1600*screenWidth, 511/900*screenHeight, 1119*1600*screenWidth, 511/900*screenHeight,tocolor(77, 77, 77, 255), 3/900*screenHeight, true)
	dxDrawLine(1119/1600*screenWidth, 71/900*screenHeight, 1119/1600*screenWidth, 512/900*screenHeight, tocolor(77, 77, 77, 255), 3/900*screenHeight, true)
	dxDrawLine(728/1600*screenWidth, 71/900*screenHeight, 1120/1600*screenWidth, 71/900*screenHeight, tocolor(77, 77, 77, 255), 3/900*screenHeight, true)
end

function drawInGameErrorMessage(par_message)
	message = par_message
	removeEventHandler("onClientRender", root, drawDXLoginPanel)
	GUIEditor.window[1] = guiCreateWindow(0.38, 0.33, 0.24, 0.13, "Error message", true)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.button[6] = guiCreateButton(0.39, 0.71, 0.23, 0.21, "OK", true, GUIEditor.window[1])
	
	addEventHandler("onClientRender", root, drawDXErrorMessage)
	
	addEventHandler("onClientGUIClick", GUIEditor.button[6], handleInGameOkErrorMessageButton, false)
end

function handleSpawnButton(button, state)
	if (guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 ) ~= "") then
		local classType = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
		triggerServerEvent("finishedPlayerClass", getLocalPlayer(), classType)
		destroyElement(GUIEditor.window[4])
		GUIEditor.window[4] = nil
		guiSetInputEnabled(false)
		showCursor(false)
		removeEventHandler("onClientRender", root, drawDXInformationBoard)
	else
		drawInGameErrorMessage("You need to select a class first!")
	end
end

function handleInGameOkErrorMessageButton()
	destroyAll()
	removeEventHandler("onClientRender", root, drawDXErrorMessage)
end



function getPlayerPos()
	addEventHandler("onClientRender", getRootElement(), createPosText)        -- onClientRender keeps the 3D Line visible.
end

function createPosText()
	x, y , z = getElementPosition(getLocalPlayer())
	dxDrawText("posX: " ..x.."\nPosY: " ..y.."\nPosZ: " ..z, 731, 72, 10, 10, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "center", false, false, true, false, false)
end

function teleportPlayer(commandName, x, y , z)
	setElementPosition(getLocalPlayer(), x, y , z)
end


 --SECURITY
 
function checkChange(dataName,oldValue)
	if source then
		if (source ~= localPlayer) then
			outputChatBox(tostring(source).. " : " ..tostring(localPlayer))
			outputChatBox( "Illegal setting of "..tostring(dataName).."' by '"..tostring(getPlayerName(localPlayer)) )
			setElementData( localPlayer, dataName, oldValue ) -- Set back the original value
		end
	end
end
addEventHandler("onClientElementDataChange", localPlayer,checkChange)



--COMMANDS

addCommandHandler("tele", teleportPlayer)
addCommandHandler("pos", getPlayerPos)

--CUSTOM EVENTS

addEvent("informationBoard", true)
addEventHandler("informationBoard", root, informationBoard)

addEvent("loginPanel", true)
addEventHandler("loginPanel", root, loginPanel)

addEvent("stopLoading", true)
addEventHandler("stopLoading", root, stopLoading)

addEvent("startLoading", true)
addEventHandler("startLoading", root, startLoading)

addEvent("closeAll", true)
addEventHandler("closeAll", root, closeAll)

addEvent("drawErrorMessage", true)
addEventHandler("drawErrorMessage", root, drawErrorMessage)

addEvent("drawSuccesfullMessage", true)
addEventHandler("drawSuccesfullMessage", root, drawSuccesfullMessage)

--RESOURCE EVENTS


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), buildLoginPanel)

