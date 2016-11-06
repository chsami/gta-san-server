function createBlipInterface()
	if not (getWindowDisplayed()) then
		GUIEditor.window[1] = guiCreateWindow(0.35, 0.16, 0.28, 0.25, "Blip Configuration", true)
		guiWindowSetSizable(GUIEditor.window[1], false)

		GUIEditor.label[1] = guiCreateLabel(0.06, 0.26, 0.30, 0.10, "Blip icon", true, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[1], "default-bold-small")
		GUIEditor.label[2] = guiCreateLabel(0.06, 0.47, 0.30, 0.10, "Alpha", true, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[2], "default-bold-small")
		GUIEditor.label[3] = guiCreateLabel(0.06, 0.68, 0.30, 0.10, "Visible distance", true, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[3], "default-bold-small")
		GUIEditor.edit[1] = guiCreateEdit(0.43, 0.25, 0.30, 0.11, "", true, GUIEditor.window[1])
		GUIEditor.edit[2] = guiCreateEdit(0.43, 0.47, 0.30, 0.11, "", true, GUIEditor.window[1])
		GUIEditor.edit[3] = guiCreateEdit(0.43, 0.68, 0.30, 0.11, "", true, GUIEditor.window[1])
		GUIEditor.button[1] = guiCreateButton(0.85, 0.79, 0.13, 0.17, "Create", true, GUIEditor.window[1])
		GUIEditor.button[2] = guiCreateButton(0.93, 0.09, 0.03, 0.07, "X", true, GUIEditor.window[1])
		guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000") 
		
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleCreateBlipBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleCloseBlipInterface, false)
		
		guiSetInputEnabled(true)
		showCursor(true)
	end
end



function handleCreateBlipBtn()
	local icon = guiGetText(GUIEditor.edit[1])
	local alpha= guiGetText(GUIEditor.edit[2])
	local visibleDistance = guiGetText(GUIEditor.edit[3])
	triggerServerEvent("newBlip", getLocalPlayer(), icon, alpha, visibleDistance)
	handleCloseBlipInterface()
end

function handleCloseBlipInterface()
	if (getWindowDisplayed()) then
		destroyAll()
		guiSetInputEnabled(false)
		showCursor(false)
	end
end


--COMMANDS--

addCommandHandler("blip", createBlipInterface)