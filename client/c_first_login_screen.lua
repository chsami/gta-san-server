local skins = {}
local rotateZ = 0
local rotateX = 0
function initializeSkins()
	skins["police"] = {280, 281, 282, 283, 288}
	skins["farmer"] = {128, 129, 130, 131, 132, 133, 157, 158, 159, 160, 196, 197, 198, 199, 161}
	skins["criminal"] = {105, 102, 114, 108, 121, 173, 117, 247, 111, 124}
	skins["pilot"] = {61, 17, 9, 57, 59}
end

function finalizeSkins()
	skins = {}
end

function drawFirstLoginScreenInterface()
	if not (getWindowDisplayed()) then
		setElementPosition(localPlayer, 1000, 1000, 500)
		setElementAlpha (localPlayer, 0 )
		setElementFrozen(localPlayer, true)
		unbindAllKeys()
		initializeSkins()
		GUIEditor.window[1] = guiCreateWindow(0.01, 0.02, 0.40, 0.95, "Welcome to ghetto", true)
		guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetAlpha(GUIEditor.window[1], 0.81)
		GUIEditor.gridlist[1] = guiCreateGridList(0.01, 0.42, 0.29, 0.30, true, GUIEditor.window[1])
		guiGridListAddColumn(GUIEditor.gridlist[1], "Jobs", 0.9)
		guiGridListAddRow(GUIEditor.gridlist[1])
		guiGridListSetItemText(GUIEditor.gridlist[1], 0, 1, "police", false, false)
		guiGridListAddRow(GUIEditor.gridlist[1])
		guiGridListSetItemText(GUIEditor.gridlist[1], 1, 1, "criminal", false, false)
		guiGridListAddRow(GUIEditor.gridlist[1])
		guiGridListSetItemText(GUIEditor.gridlist[1], 2, 1, "farmer", false, false)
		guiGridListAddRow(GUIEditor.gridlist[1])
		guiGridListSetItemText(GUIEditor.gridlist[1], 3, 1, "pilot", false, false)
		GUIEditor.button[1] = guiCreateButton(0.32, 0.88, 0.39, 0.11, "Start your adventure!", true, GUIEditor.window[1])
		GUIEditor.label[1] = guiCreateLabel(0.35, 0.42, 0.31, 0.28, "Test test test test test test test test test", true, GUIEditor.window[1])
		guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
		guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
		GUIEditor.gridlist[2] = guiCreateGridList(445, 358, 185, 257, false, GUIEditor.window[1])
		guiGridListAddColumn(GUIEditor.gridlist[2], "Skin", 0.9)
		GUIEditor.button[2] = guiCreateButton(0.95, 0.03, 0.03, 0.03, "", true, GUIEditor.window[1])
		guiSetAlpha(GUIEditor.button[2], 0.00)    
		GUIEditor.button[3] = guiCreateButton(0.74, 0.46, 0.04, 0.04, "Turn right", true)

		GUIEditor.button[4] = guiCreateButton(0.63, 0.46, 0.04, 0.04, "Turn left", true)

		GUIEditor.button[5] = guiCreateButton(0.69, 0.41, 0.04, 0.04, "Turn up", true)

		GUIEditor.button[6] = guiCreateButton(0.69, 0.53, 0.04, 0.04, "Turn down", true)    
		showCursor(true)
		guiGetInputEnabled(true)
		showDXHeader()
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleStartAdventureBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], handlePickJobBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[2], handlePickSkinBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[3], handleTurnRightBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[4], handleTurnLeftBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[5], handleTurnUpBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[6], handleTurnDownBtn, false)
	end
end

addEvent("firstLogin", true)
addEventHandler("firstLogin", localPlayer, drawFirstLoginScreenInterface)

function handleTurnDownBtn()
	rotateX = rotateX + 10
	outputChatBox("rotatex : " ..rotateX)
	local x, y , z = getElementPosition(localPlayer)
	if (x == 1000 and y == 1000 and z == 500) then --ok ped is right place, move on
		setElementRotation(localPlayer, rotateX, 0, 180)
	end
end

function handleTurnLeftBtn()
	rotateZ = rotateZ - 10
	local x, y , z = getElementPosition(localPlayer)
	if (x == 1000 and y == 1000 and z == 500) then --ok ped is right place, move on
		setElementRotation(localPlayer, rotateX, 0, rotateZ)
	end
end

function handleTurnRightBtn()
	rotateZ = rotateZ	+ 10
	local x, y , z = getElementPosition(localPlayer)
	if (x == 1000 and y == 1000 and z == 500) then --ok ped is right place, move on
		setElementRotation(localPlayer, rotateX, 0, rotateZ)
	end
end

function handleTurnUpBtn()
	rotateX = rotateX - 10
	local x, y , z = getElementPosition(localPlayer)
	if (x == 1000 and y == 1000 and z == 500) then --ok ped is right place, move on
		setElementRotation(localPlayer, rotateX, 0, 180)
	end
end

function buildSkinsGridList(job)
	local counter = 0
	for i = 0, guiGridListGetRowCount(GUIEditor.gridlist[2]) do --empty gridlist first
		guiGridListRemoveRow ( GUIEditor.gridlist[2], i )
	end
	for i = 1, #skins[job] do --fill it with the skins
		guiGridListAddRow(GUIEditor.gridlist[2])
		guiGridListSetItemText(GUIEditor.gridlist[2], counter, 1, skins[job][i], false, false)
		counter = counter + 1
	end
end

function handlePickJobBtn()
	if (getWindowDisplayed()) then
		local job = getListItem(1)
		if (job ~= nil) then
			for i = 0, guiGridListGetRowCount(GUIEditor.gridlist[2]) do --empty gridlist first
				guiGridListRemoveRow ( GUIEditor.gridlist[2], i )
			end
			buildSkinsGridList(job)
		end
	end
end

function handlePickSkinBtn()
	if (getWindowDisplayed()) then
		local skin = getListItem(1, 2)
		if (skin ~= nil) then
			if (getElementModel(localPlayer) ~= tonumber(skin)) then
				setElementPosition(localPlayer, 1000, 1000, 500)
				setPlayerHudComponentVisible ( "all", false )
				setElementAlpha (localPlayer, 255 )
				setElementRotation(localPlayer, 0, 0, 180)
				setElementDimension(localPlayer, 1)
				setElementModel(localPlayer, skin)
				setCameraTarget ( localPlayer )
			end
		end
	end
end

function handleStartAdventureBtn()
	if (getWindowDisplayed()) then
		local job = getListItem(1)
		local skin = getListItem(1, 2)
		if (skin and job ~= nil) then
			setPlayerHudComponentVisible ( "all",  true )
			triggerServerEvent("startAdventure", localPlayer, job, tonumber(skin))
			finalizeSkins()
			closeFirstLoginScreenInterface()
		else
			outputChatBox("Select your job and skin first.", 255, 0, 0)
		end
	end
end

function closeFirstLoginScreenInterface()
	destroyAll()
	showCursor(false)
	guiGetInputEnabled(false)
	hideDXHeader()
end




function drawDXHeader()
	dxDrawImage(17, 70, 639, 282, ":ghetto/conf/images/header.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

function showDXHeader()
	addEventHandler("onClientRender", root, drawDXHeader)
end

function hideDXHeader()
	removeEventHandler("onClientRender", root, drawDXHeader)
end

addCommandHandler("mimi", drawFirstLoginScreenInterface)


addCommandHandler("letmefly", function(p)
local x, y , z = getElementPosition(localPlayer)
setElementPosition(localPlayer, x, y, 1000)
end)