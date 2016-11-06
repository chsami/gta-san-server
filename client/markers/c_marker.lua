
local GUIEditor = {
    button = {},
    window = {},
    label = {},
    edit = {}
}

function buildMarkerCreation()
	if (GUIEditor.window[1] == nil) then
		GUIEditor.window[1] = guiCreateWindow(0.30, 0.17, 0.41, 0.63, "Marker creation", true)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.edit[1] = guiCreateEdit(0.20, 0.12, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(0.03, 0.13, 0.14, 0.04, "markerType :", true, GUIEditor.window[1])
        GUIEditor.edit[2] = guiCreateEdit(0.20, 0.18, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.label[2] = guiCreateLabel(0.03, 0.19, 0.14, 0.04, "size :", true, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(0.03, 0.24, 0.14, 0.04, "red :", true, GUIEditor.window[1])
        GUIEditor.edit[3] = guiCreateEdit(0.20, 0.24, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.label[4] = guiCreateLabel(0.03, 0.29, 0.14, 0.04, "blue :", true, GUIEditor.window[1])
        GUIEditor.label[5] = guiCreateLabel(0.03, 0.35, 0.14, 0.04, "green :", true, GUIEditor.window[1])
        GUIEditor.edit[4] = guiCreateEdit(0.20, 0.29, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.edit[5] = guiCreateEdit(0.20, 0.34, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.edit[6] = guiCreateEdit(0.20, 0.40, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.edit[7] = guiCreateEdit(0.20, 0.46, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.edit[8] = guiCreateEdit(0.20, 0.52, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.edit[10] = guiCreateEdit(0.20, 0.58, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.edit[11] = guiCreateEdit(0.20, 0.64, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.label[6] = guiCreateLabel(0.03, 0.41, 0.14, 0.04, "alpha :", true, GUIEditor.window[1])
        GUIEditor.label[7] = guiCreateLabel(0.03, 0.46, 0.14, 0.04, "visibleTo :", true, GUIEditor.window[1])
        GUIEditor.label[8] = guiCreateLabel(0.03, 0.52, 0.14, 0.04, "destinationX :", true, GUIEditor.window[1])
        GUIEditor.label[9] = guiCreateLabel(0.03, 0.58, 0.14, 0.04, "destinationY :", true, GUIEditor.window[1])
        GUIEditor.label[10] = guiCreateLabel(0.03, 0.64, 0.14, 0.04, "destinationZ :", true, GUIEditor.window[1])
        GUIEditor.edit[12] = guiCreateEdit(0.20, 0.70, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.edit[13] = guiCreateEdit(0.20, 0.76, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.edit[14] = guiCreateEdit(0.20, 0.82, 0.22, 0.04, "", true, GUIEditor.window[1])
        GUIEditor.label[11] = guiCreateLabel(0.03, 0.70, 0.14, 0.04, "destinationD :", true, GUIEditor.window[1])
        GUIEditor.label[12] = guiCreateLabel(0.03, 0.76, 0.14, 0.04, "destinationI :", true, GUIEditor.window[1])
        GUIEditor.label[13] = guiCreateLabel(0.03, 0.83, 0.14, 0.04, "message :", true, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(0.21, 0.92, 0.22, 0.05, "Create marker", true, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(618, 32, 15, 15, "X", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.button[2], "default-bold-small")
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")   
		
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleMarkerButton, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], closeMarkerCreation, false)
		
		guiSetInputEnabled(true)
		showCursor(true)
	end
end

function handleMarkerButton(button, state)
	local markerType = guiGetText ( GUIEditor.edit[1] )
	local size = guiGetText ( GUIEditor.edit[2] )
	local red = guiGetText ( GUIEditor.edit[3] )
	local blue =guiGetText ( GUIEditor.edit[4] )
	local green = guiGetText ( GUIEditor.edit[5] )
	local alpha = guiGetText ( GUIEditor.edit[6] )
	local visibleto = guiGetText ( GUIEditor.edit[7] )
	local destinationX = guiGetText ( GUIEditor.edit[8] )
	local destinationY = guiGetText ( GUIEditor.edit[10] )
	local destinationZ = guiGetText ( GUIEditor.edit[11] )
	local destinationD = guiGetText ( GUIEditor.edit[12] )
	local destinationI = guiGetText ( GUIEditor.edit[13] )
	local message = guiGetText ( GUIEditor.edit[14] )
	triggerServerEvent("initMarker", getLocalPlayer(), markerType, size, red, blue, green, alpha, visibleto, destinationX, destinationY, destinationZ, destinationD, destinationI, message)
	guiSetInputEnabled(false)
	showCursor(false)
	destroyElement(GUIEditor.window[1])
	GUIEditor.window[1] = nil
end

function closeMarkerCreation()
	if (GUIEditor.window[1]) then
		guiSetInputEnabled(false)
		showCursor(false)
		destroyElement(GUIEditor.window[1])
		GUIEditor.window[1] = nil
	end
end


addCommandHandler("marker", buildMarkerCreation)