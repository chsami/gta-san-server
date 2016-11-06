
local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)


function buildInventory()
	if not (getWindowDisplayed()) then
			GUIEditor.window[1] = guiCreateWindow(0.39, 0.29, 0.14, 0.35, "Inventory", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.25, 0.14, 0.53, 0.11, "Drug Inventory", true, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(0.86, 0.08, 0.07, 0.05, "X", true, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(0.25, 0.3, 0.53, 0.11, "Permits", true, GUIEditor.window[1]) 
			guiSetFont(GUIEditor.button[2], "default-bold-small")
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")    
			
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleDrugInvBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], closeInventory, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[3], handlePermitsBtn, false)
			showCursor(true)
	else
		closeInventory()
	end
end


function handleDrugInvBtn()
	if (getWindowDisplayed()) then
		destroyAll()
		triggerServerEvent("getDrugsInv", localPlayer, false)
	end
end

function handlePermitsBtn()
	if (getWindowDisplayed()) then
		destroyAll()
		showPermits()
	end
end

function closeInventory()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
	end
end
