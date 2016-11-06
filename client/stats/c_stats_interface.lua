

function showStats()
	if not(getWindowDisplayed()) then
		GUIEditor.window[1] = guiCreateWindow(0.81, 0.44, 0.14, 0.50, "Player stats", true)
		guiWindowSetSizable(GUIEditor.window[1], true)

		GUIEditor.label[1] = guiCreateLabel(0.04, 0.08, 0.90, 0.05, "Farming experience : " ..getJobExperience().."/100", true, GUIEditor.window[1])
		GUIEditor.label[2] = guiCreateLabel(0.04, 0.16, 0.90, 0.05, "criminal experience : " ..getJobExperience().."/100", true, GUIEditor.window[1])
		GUIEditor.label[3] = guiCreateLabel(0.06, 0.23, 0.90, 0.05, "Police experience : " ..getJobExperience().."/100", true, GUIEditor.window[1])
		GUIEditor.label[4] = guiCreateLabel(0.06, 0.30, 0.90, 0.05, "Pilot experience : " ..getJobExperience().."/100", true, GUIEditor.window[1])
		GUIEditor.label[5] = guiCreateLabel(0.06, 0.38, 0.90, 0.05, "Stamina : " ..getElementData(getLocalPlayer(), "stamina").."/5000", true, GUIEditor.window[1])
		GUIEditor.label[6] = guiCreateLabel(0.06, 0.45, 0.90, 0.05, "Muscles : " ..getElementData(getLocalPlayer(), "muscles").. "/5000", true, GUIEditor.window[1])
		GUIEditor.label[7] = guiCreateLabel(0.06, 0.53, 0.90, 0.05, "N/A", true, GUIEditor.window[1])
		GUIEditor.label[8] = guiCreateLabel(0.06, 0.60, 0.90, 0.05, "N/A", true, GUIEditor.window[1])
		GUIEditor.label[9] = guiCreateLabel(0.06, 0.67, 0.90, 0.05, "N/A", true, GUIEditor.window[1])
		GUIEditor.label[10] = guiCreateLabel(0.06, 0.75, 0.90, 0.05, "N/A", true, GUIEditor.window[1])   
		GUIEditor.button[1] = guiCreateButton(0.89, 0.06, 0.07, 0.03, "X", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")   
		addEventHandler ( "onClientGUIClick", GUIEditor.button[1], closeStatInterface, false)
		showCursor(true)
	else
		closeStatInterface()
	end
end

function closeStatInterface()
	if (getWindowDisplayed()) then
		showCursor(false)
		destroyAll()
	end
end
