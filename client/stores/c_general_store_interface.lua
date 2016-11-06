local general_store_marker = createMarker(-21, -138, 1003, "cylinder", 1, 255, 0, 0, 150)
setElementInterior(general_store_marker, 16)

outputChatBox("Client general store loaded!")

function drawGeneralStoreInterface()
	if not (getWindowDisplayed()) then
		GUIEditor.window[1] = guiCreateWindow(0.35, 0.21, 0.28, 0.42, "General store", true)
		guiWindowSetSizable(GUIEditor.window[1], false)

		GUIEditor.button[1] = guiCreateButton(410, 30, 15, 15, "X", false, GUIEditor.window[1])
		guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")
		GUIEditor.gridlist[1] = guiCreateGridList(0.08, 0.13, 0.47, 0.83, true, GUIEditor.window[1])
		guiGridListAddColumn(GUIEditor.gridlist[1], "Item", 0.5)
		guiGridListAddColumn(GUIEditor.gridlist[1], "Price", 0.5)
		guiGridListAddRow(GUIEditor.gridlist[1])
		guiGridListSetItemText(GUIEditor.gridlist[1], 0, 1, "Samsung Galaxy", false, false)
		guiGridListSetItemText(GUIEditor.gridlist[1], 0, 2, "$600", false, false)
		guiGridListAddRow(GUIEditor.gridlist[1])
		guiGridListSetItemText(GUIEditor.gridlist[1], 1, 1, "Iphone", false, false)
		guiGridListSetItemText(GUIEditor.gridlist[1], 1, 2, "$800", false, false)
		GUIEditor.button[2] = guiCreateButton(0.64, 0.84, 0.31, 0.12, "Buy", true, GUIEditor.window[1])   
		showCursor(true)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleBuyGeneralStoreBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[1], closeGeneralStoreBtn, false)
	end
end

function handleBuyGeneralStoreBtn()
	if (getWindowDisplayed()) then
		local item = getListItem(1)
		local price = getListItem(2)
		if (item ~= nil) then
			if (price ~= nil) then
				local colPrice = string.gsub(tostring(price), "[$]", "")
				triggerServerEvent("buyGeneralStore", localPlayer, item, tonumber(colPrice))
			end
		end
	end
end

function closeGeneralStoreBtn()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
	end
end


addEventHandler("onClientMarkerHit", general_store_marker, drawGeneralStoreInterface)