function drawSettingsInterface()
	if not (getWindowDisplayed()) then
		GUIEditor.window[1] = guiCreateWindow(0.34, 0.22, 0.31, 0.36, "Options", true)
		guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetAlpha(GUIEditor.window[1], 0.65)

		GUIEditor.combobox[1] = guiCreateComboBox(0.07, 0.21, 0.32, 0.75, "", true, GUIEditor.window[1])
		guiComboBoxAddItem(GUIEditor.combobox[1], "HUD")
		guiComboBoxAddItem(GUIEditor.combobox[1], "Job Progress")
		guiComboBoxAddItem(GUIEditor.combobox[1], "Time")
		GUIEditor.checkbox[1] = guiCreateCheckBox(0.53, 0.22, 0.05, 0.05, "", false, true, GUIEditor.window[1])
		GUIEditor.button[1] = guiCreateButton(0.92, 0.09, 0.03, 0.05, "X", true, GUIEditor.window[1])
		guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000") 
		addEventHandler("onClientGUIClick", GUIEditor.checkbox[1], handleCheckBoxSettingsBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[1], closeSettingsInterface, false)
		guiCheckBoxSetSelected ( GUIEditor.checkbox[1], true )
		guiComboBoxSetSelected ( GUIEditor.combobox[1], 0 )
		showCursor(true)
	end	
end

function closeSettingsInterface()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
	end
end

function handleCheckBoxSettingsBtn()
	local item = guiComboBoxGetSelected(GUIEditor.combobox[1])
	local text = guiComboBoxGetItemText ( GUIEditor.combobox[1], item)
	local selected = guiCheckBoxGetSelected ( GUIEditor.checkbox[1] )
	if (text == "HUD") then
		setPlayerHudComponentVisible ( "all", selected )
	elseif( text == "Job Progress") then
		handleProgressInterface(selected)
	elseif (text == "Time") then
		showTime(selected)
	end
end


addCommandHandler("settings", drawSettingsInterface)