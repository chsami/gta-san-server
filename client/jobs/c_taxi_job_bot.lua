
local destinations = {"LS-Airport", "Countryside"}
local price = {"$200", "$200"}


function drawTaxiDestinationInterface()
	if not (getWindowDisplayed()) then
		if (isLoggedIn()) then
			GUIEditor.window[1] = guiCreateWindow(0.39, 0.25, 0.21, 0.43, "Destination", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.10, 0.83, 0.37, 0.10, "Travel", true, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(0.54, 0.83, 0.37, 0.10, "Exit", true, GUIEditor.window[1])
			GUIEditor.gridlist[1] = guiCreateGridList(0.10, 0.11, 0.80, 0.68, true, GUIEditor.window[1])
			guiGridListAddColumn(GUIEditor.gridlist[1], "Destination", 0.5)
			guiGridListAddColumn(GUIEditor.gridlist[1], "Price", 0.5)
			for i = 1, table.getn(price) do
				guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1], (i - 1), 1, destinations[i], false, false)
				guiGridListSetItemText(GUIEditor.gridlist[1], (i-1), 2, price[i], false, false)  
				
			end
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleTravelTaxiBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], handleExitTaxiBtn, false)
			showCursor(true)
		end
	end
end

addEvent("showTaxiDestInterface", true)
addEventHandler("showTaxiDestInterface", localPlayer, drawTaxiDestinationInterface)



function handleTravelTaxiBtn()
	if (getWindowDisplayed()) then
		local destination = getListItem(1)
		local price = getListItem(2)
		if (destination ~= nil and price ~= nil) then
			local colPrice = string.gsub(tostring(price), "[$]", "")
			triggerServerEvent("playerTravelTaxi", localPlayer, destination, tonumber(colPrice))
			handleExitTaxiBtn()
		else
			outputChatBox("Select a destination first...")
		end
	end
end



function handleExitTaxiBtn()
	destroyAll()
	showCursor(false)
end

