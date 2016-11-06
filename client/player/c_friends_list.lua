
local names = {}

function drawFriendsListInterface()
	if not (getWindowDisplayed()) then
		local row = nil
		GUIEditor.window[1] = guiCreateWindow(0.79, 0.00, 0.21, 0.79, "Friends list", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetAlpha(GUIEditor.window[1], 0.70)

        GUIEditor.button[1] = guiCreateButton(0.92, 0.04, 0.05, 0.02, "X", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")
        drawGridList()
        GUIEditor.button[2] = guiCreateButton(0.03, 0.65, 0.35, 0.06, "Add friend", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF24FD00")
        GUIEditor.button[3] = guiCreateButton(0.62, 0.65, 0.35, 0.06, "Delete friend", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFFC0000")
        GUIEditor.button[4] = guiCreateButton(0.03, 0.73, 0.35, 0.06, "Message friend", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FF24FD00")
        GUIEditor.button[5] = guiCreateButton(0.62, 0.73, 0.35, 0.06, "Track friend", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFFC0000")
        GUIEditor.edit[1] = guiCreateEdit(0.05, 0.84, 0.90, 0.05, "", true, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(0.34, 0.81, 0.29, 0.02, "Message", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.edit[2] = guiCreateEdit(0.05, 0.94, 0.90, 0.05, "", true, GUIEditor.window[1])
        GUIEditor.label[2] = guiCreateLabel(0.35, 0.90, 0.29, 0.02, "Add friend", true, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[2], "center")   
        guiSetAlpha(GUIEditor.window[1], 0.70)   
		addEventHandler("onClientGUIClick", GUIEditor.button[1], closeFriendsListInterface, false)		
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleAddFriendsBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[3], handleDeleteFriendsBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[4], messageFriendBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[5], trackFriendBtn, false)
		showCursor(true)
		guiSetInputEnabled(true)
	end
end

function drawGridList()
	local thePlayer = nil
	local x, y, z = nil
	GUIEditor.gridlist[1] = guiCreateGridList(0.03, 0.07, 0.95, 0.57, true, GUIEditor.window[1])
	guiGridListAddColumn(GUIEditor.gridlist[1], "Name", 0.5)
	guiGridListAddColumn(GUIEditor.gridlist[1], "Location", 0.5)
	for i, v in pairs(names) do
		if (v ~= "") then
			thePlayer = getPlayerFromName ( v )
			row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], row, 1, v, false, false)
			if (isElement(thePlayer)) then
				x, y, z = getElementPosition(thePlayer)
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, getZoneName ( x, y, z, true), false, false)
			else
				guiGridListSetItemText(GUIEditor.gridlist[1], row, 2, "Offline", false, false)
			end
		end
	end
end

addCommandHandler("friends", drawFriendsListInterface)

function trackFriendBtn()
	if (getWindowDisplayed()) then
		local friend = getListItem(1)
		local status = getListItem(2)
		if (friend ~= nil and friend ~= "") then
			if (status ~= "Offline") then
				triggerServerEvent("trackFriend", localPlayer, friendName)
			else
				outputChatBox("Player : " ..friend.." is not online.", 255, 0, 0)
			end
		else
			outputChatBox("No player selected.", 255, 0, 0)
		end
	end
end

function messageFriendBtn()
	if (getWindowDisplayed()) then
		local message = guiGetText(GUIEditor.edit[1])
		local friend = getListItem(1)
		local status = getListItem(2)
		if (message ~= nil and message ~= "") then
			if (friend ~= nil and friend ~= "") then
				if (status ~= "Offline") then
					triggerServerEvent("messageFriend", localPlayer, friend, message)
				else
					outputChatBox("Player : " ..friend.." is not online.", 255, 0, 0)
				end
			else
				outputChatBox("No friend selected to message.", 255, 0, 0)
			end
		else
			outputChatBox("Type a message in the messagebox.", 255, 0, 0)
		end
	end
end

function emptyArray()
	for i= 1, 100 do
		names[i] = ""
	end
end

function handleGetNames(_, value)
	if (source == localPlayer) then
		emptyArray()
		local counter = 1
		if (value ~= "" and value ~= nil) then
			if (type(value) == "table") then
				for i, v in pairs(value) do
					for x in string.gmatch(v, "%S+") do
						names[counter] = x
						outputChatBox(tostring(names[counter]))
						counter = counter + 1
					end
				end
			else
				for x in string.gmatch(value, "%S+") do
					names[counter] = x
					outputChatBox(tostring(names[counter]))
					counter = counter + 1
				end
			end
		end
	end
end

addEvent("getNames", true)
addEventHandler("getNames", localPlayer, handleGetNames)

function closeAddFriendBoxInterfaceBtn()
	destroyAll()
	showCursor(false)
	guiSetInputEnabled(false)
end

function showAddFriendBtn()
	if (getWindowDisplayed()) then
		closeFriendsListInterface()
		drawAddFriendBox()
	end
end

function handleAddFriendsBtn()
	if (getWindowDisplayed()) then
		local friendName = guiGetText(GUIEditor.edit[2])
		if (friendName ~= nil and friendName ~= "") then
			triggerServerEvent("addFriend", localPlayer, friendName)
			addEventHandler("onClientRender", root, drawLoadingText)
			setTimer(function()
				closeAddFriendBoxInterfaceBtn()
				drawFriendsListInterface()
				removeEventHandler("onClientRender", root, drawLoadingText)
			end, 1000, 1)
		else
			outputChatBox("Edit box is still empty.")
		end
	end
end

function handleDeleteFriendsBtn()
	if (getWindowDisplayed()) then
		local friendName = getListItem(1)
		local row, column = guiGridListGetSelectedItem ( GUIEditor.gridlist[1] )
		if (friendName ~= nil and friendName ~= "") then
			guiGridListRemoveRow ( GUIEditor.gridlist[1], row )
			triggerServerEvent("deleteFriend", localPlayer, friendName)
		end
	end
end

function closeFriendsListInterface()
	destroyAll()
	guiSetInputEnabled(false)
	showCursor(false)
end