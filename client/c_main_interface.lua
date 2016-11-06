

--CUSTOM INTERFACE HANDLER MADE BY AINTARO V1.0
--DATE: 27 JUNE 2014




GUIEditor = {
    button = {},
    window = {},
    label = {},
	edit = {},
	memo = {},
	tab = {},
	tabpanel = {},
	gridlist = {},
	combobox = {},
	checkbox = {}
}

local message = ""

screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height

function resetWindow()
	local arraySize = table.getn(GUIEditor.window)
	for i = 1, arraySize do	
		if (isElement(GUIEditor.window[i])) then
			destroyElement(GUIEditor.window[i])
			GUIEditor.window[i] = nil
		end
	end
end

function resetButton()
	local arraySize = table.getn(GUIEditor.button)
	for i = 1, arraySize do
		if (isElement(GUIEditor.button[i])) then
			destroyElement(GUIEditor.button[i])
			GUIEditor.button[i] = nil
		end
	end
end

function resetLabel()
	local arraySize = table.getn(GUIEditor.label)
	for i = 1, arraySize do
		if (isElement(GUIEditor.label[i])) then
			destroyElement(GUIEditor.label[i])
			GUIEditor.label[i] = nil
		end
	end
end

function resetEdit()
	local arraySize = table.getn(GUIEditor.edit)
	for i = 1, arraySize do
		if (isElement(GUIEditor.edit[i])) then
		destroyElement(GUIEditor.edit[i])
		GUIEditor.edit[i] = nil
		end
	end
end

function resetMemo()	
	local arraySize = table.getn(GUIEditor.memo)
	for i = 1, arraySize do
		if (isElement(GUIEditor.memo[i])) then
			destroyElement(GUIEditor.memo[i])
			GUIEditor.memo[i] = nil
		end
	end
end

function resetTab()
	local arraySize = table.getn(GUIEditor.tab)
	for i = 1, arraySize do
		if (isElement(GUIEditor.tab[i])) then
			destroyElement(GUIEditor.tab[i])
			GUIEditor.tab[i] = nil
		end
	end
end

function resetTabPanel()
	local arraySize = table.getn(GUIEditor.tabpanel)
	for i = 1, arraySize do
		if (isElement(GUIEditor.tabpanel[i])) then
			destroyElement(GUIEditor.tabpanel[i])
			GUIEditor.tabpanel[i] = nil
		end
	end
end

function resetGridList()
	local arraySize = table.getn(GUIEditor.gridlist)
	for i = 1, arraySize do
		if (isElement(GUIEditor.gridlist[i])) then
			destroyElement(GUIEditor.gridlist[i])
			GUIEditor.gridlist[i] = nil
		end
	end
end

function resetCheckBox()
	local arraySize = table.getn(GUIEditor.checkbox)
	for i = 1, arraySize do
		if (isElement(GUIEditor.checkbox[i])) then
			destroyElement(GUIEditor.checkbox[i])
			GUIEditor.checkbox[i] = nil
		end
	end
end

function resetComboBox()
	local arraySize = table.getn(GUIEditor.combobox)
	for i = 1, arraySize do
		if (isElement(GUIEditor.combobox[i])) then
			destroyElement(GUIEditor.combobox[i])
			GUIEditor.combobox[i] = nil
		end
	end
end

function getWindowDisplayed()
	local arraySize = table.getn(GUIEditor.window)
	if (isInPermit()) then
		return true
	end
	if not(isLoggedIn()) then
		return false
	end
	for i = 1, arraySize do
		if (isElement(GUIEditor.window[i])) then
			return true
		end
	end
	return false
end

function getButtonDisplayed()
	local arraySize = table.getn(GUIEditor.button)
	for i = 1, arraySize do
		if (isElement(GUIEditor.button[i])) then
			return true
		end
	end
	return false
end

function getLabelDisplayed()
	local arraySize = table.getn(GUIEditor.label)
	for i = 1, arraySize do
		if (isElement(GUIEditor.label[i])) then
			return true
		end
	end
	return false
end

function getEditDisplayed()
	local arraySize = table.getn(GUIEditor.edit)
	for i = 1, arraySize do
		if (isElement(GUIEditor.edit[i])) then
			return true
		end
	end
	return false
end

function getMemoDisplayed()
	local arraySize = table.getn(GUIEditor.memo)
	for i = 1, arraySize do
		if (isElement(GUIEditor.memo[i])) then
			return true
		end
	end
	return false
end

function getTabDisplayed()
	local arraySize = table.getn(GUIEditor.tab)
	for i = 1, arraySize do
		if (isElement(GUIEditor.tab[i])) then
			return true
		end
	end
	return false
end

function getTabPanelDisplayed()
	local arraySize = table.getn(GUIEditor.tabpanel)
	for i = 1, arraySize do
		if (isElement(GUIEditor.tabpanel[i])) then
			return true
		end
	end
	return false
end

function getGridListDisplayed()
	local arraySize = table.getn(GUIEditor.gridlist)
	for i = 1, arraySize do
		if (isElement(GUIEditor.gridlist[i])) then
			return true
		end
	end
	return false
end

function getComboBoxDisplayed()
	local arraySize = table.getn(GUIEditor.combobox)
	for i = 1, arraySize do
		if (isElement(GUIEditor.combobox[i])) then
			return true
		end
	end
	return false
end

function getCheckBoxDisplayed()
	local arraySize = table.getn(GUIEditor.checkbox)
	for i = 1, arraySize do
		if (isElement(GUIEditor.checkbox[i])) then
			return true
		end
	end
	return false
end

function destroyAll()
	resetDimension()
	resetWindow()
	resetButton()
	resetEdit()
	resetMemo()
	resetTab()
	resetTabPanel()
	resetGridList()
	resetCheckBox()
	resetComboBox()
	resetLabel()
	setCameraTarget ( localPlayer )
	setElementFrozen(localPlayer, false)
	bindAllKeys()
end

function drawNotificationMessageClient(par_message)
	if not (getWindowDisplayed()) then
		message = par_message
		GUIEditor.window[1] = guiCreateWindow(0.30, 0.33, 0.40, 0.13, "Error message", true)
		guiWindowSetSizable(GUIEditor.window[1], false)

		GUIEditor.button[1] = guiCreateButton(0.39, 0.71, 0.23, 0.21, "OK", true, GUIEditor.window[1])
		
		addEventHandler("onClientRender", root, drawDXNotificationMessage)
		
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleNotificationOkBtn, false)
		guiSetInputEnabled(true)
		showCursor(true)
	end
end

function drawNotificationMessage(_, par_message)
	if not (getWindowDisplayed()) then
		if (source == localPlayer) then
			message = par_message
			GUIEditor.window[1] = guiCreateWindow(0.30, 0.33, 0.40, 0.13, "Error message", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.39, 0.71, 0.23, 0.21, "OK", true, GUIEditor.window[1])
			
			addEventHandler("onClientRender", root, drawDXNotificationMessage)
			
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleNotificationOkBtn, false)
			guiSetInputEnabled(true)
			showCursor(true)
		end
	end
end
function drawDXNotificationMessage()
	dxDrawText(message, 657/1600*screenWidth, 341/900*screenHeight, 928/1600*screenWidth, 377/900*screenHeight, tocolor(255, 0, 0, 255), 0.45/900*screenHeight, "bankgothic", "center", "top", false, false, true, false, false)
end

function handleNotificationOkBtn()
	if (getWindowDisplayed()) then
		removeEventHandler("onClientRender", root, drawDXNotificationMessage)
		destroyAll()
		guiSetInputEnabled(false)
		showCursor(false)
	end
end

addEvent("notificationMessage", true)
addEventHandler("notificationMessage", localPlayer, drawNotificationMessage)


local message, message2, message3, r, g, b, alpha, time_left = nil
local stillRendering = false

local function onRender()
	if (r == nil) then r = 250 end
	if (g == nil) then g = 236 end
	if (b == nil) then b = 4 end
	if (alpha == nil) then alpha = 255 end
	if (time_left == nil) then time_left = 2 end
	if (message2 == nil) then message2 = "" end
	if (message3 == nil) then message3 = "" end
	if (alpha > 0) then
		alpha = alpha - time_left
		dxDrawText(message.."\n"..message2.."\n"..message3, 427/1600*screenWidth, 308/900*screenHeight, 1243/1600*screenWidth, 466/900*screenHeight, tocolor(0, 0, 0, alpha), 1.50/900*screenHeight, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText(message.."\n"..message2.."\n"..message3, 427/1600*screenWidth, 306/900*screenHeight, 1243/1600*screenWidth, 464/900*screenHeight, tocolor(0, 0, 0, alpha), 1.50/900*screenHeight, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText(message.."\n"..message2.."\n"..message3, 425/1600*screenWidth, 308/900*screenHeight, 1241/1600*screenWidth, 466/900*screenHeight, tocolor(0, 0, 0, alpha), 1.50/900*screenHeight, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText(message.."\n"..message2.."\n"..message3, 425/1600*screenWidth, 306/900*screenHeight, 1241/1600*screenWidth, 464/900*screenHeight, tocolor(0, 0, 0, alpha), 1.50/900*screenHeight, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText(message.."\n"..message2.."\n"..message3, 426/1600*screenWidth, 307/900*screenHeight, 1242/1600*screenWidth, 465/900*screenHeight, tocolor(r, g, b, alpha), 1.50/900*screenHeight, "pricedown", "center", "center", false, false, true, false, false)
	else	
		
		hideOnRender()
	end
end


function outputInterfaceBox(par_message, par_r, par_g, par_b, par_alpha, par_time_left, par_message2, par_message3)
	if (isLoggedIn()) then
		message = par_message
		r = par_r
		g = par_g
		b = par_b
		alpha = par_alpha
		time_left = par_time_left
		message2 = par_message2
		message3 = par_message3
		showOnRender()
	end
end

function showOnRender()
	if (stillRendering == false) then
		stillRendering = true
		addEventHandler("onClientRender", root,  onRender)
	end
end

function hideOnRender()
	if (stillRendering) then
		stillRendering = false
		removeEventHandler("onClientRender", root, onRender)
	end
end



addCommandHandler("karth", function()
	outputInterfaceBox("You need atleast 50 materials to make this!")
end)