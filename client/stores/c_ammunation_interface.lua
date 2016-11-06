

local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)

local weaponInformation = {}

function showAmmunationInterface(_, thePlayer)
	if (thePlayer == getLocalPlayer()) then
		if not (getWindowDisplayed()) then
			weaponInformation[getLocalPlayer] = {}
			weaponInformation[getLocalPlayer][1] = "ak-47"
			weaponInformation[getLocalPlayer][2] = "30"
			weaponInformation[getLocalPlayer][3] = "1000"
			weaponInformation[getLocalPlayer][4] = "100"
			GUIEditor.window[1] = guiCreateWindow(0.29, 0.09, 0.47, 0.63, "Ammunation store", true)
			guiWindowSetSizable(GUIEditor.window[1], false)
			GUIEditor.button[1] = guiCreateButton(0.30, 0.86, 0.15, 0.08, "Buy", true, GUIEditor.window[1])
			GUIEditor.label[1] = guiCreateLabel(0.04, 0.13, 0.41, 0.54, "Weapon information:\nWeapon name:" ..tostring(weaponInformation[getLocalPlayer][1]).."\nWeapon damage:" ..tostring(weaponInformation[getLocalPlayer][2]).."\nWeapon Price:"..tostring(weaponInformation[getLocalPlayer][3]).."$\nWeapon bullets:"..tostring(weaponInformation[getLocalPlayer][4]), true, GUIEditor.window[1])
			guiSetFont(GUIEditor.label[1], "clear-normal")
			guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
			GUIEditor.button[2] = guiCreateButton(0.80, 0.86, 0.15, 0.08, "Next", true, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(0.96, 0.05, 0.03, 0.04, "X", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFC70000")  
			addEventHandler("onClientRender", getRootElement(), drawDXWeaponName) 
			addEventHandler ( "onClientGUIClick", GUIEditor.button[1], buyWeaponFromStore, false)	
			addEventHandler ( "onClientGUIClick", GUIEditor.button[2], handleWeaponInterfaceNextBtn, false)	
			addEventHandler ( "onClientGUIClick", GUIEditor.button[3], closeWeaponInterface, false)	
			guiGetInputEnabled(true)
			showCursor(true)			
		end
	end--security
end


function drawDXWeaponName()
	local scale = 0.70/900*screenHeight
	dxDrawText(tostring(weaponInformation[getLocalPlayer][1]), 480/1600*screenWidth, 566/900*screenHeight, 658/1600*screenWidth, 604/900*screenHeight, tocolor(255, 255, 255, 255), scale, "bankgothic", "center", "center", false, false, true, false, false)
	dxDrawLine(829/1600*screenWidth, 95/900*screenHeight, 829/1600*screenWidth, 644/900*screenHeight, tocolor(255, 255, 255, 255), 1, true)
end

function handleWeaponInterfaceNextBtn()
	if (GUIEditor.window[1]) then
		if (weaponInformation[getLocalPlayer][1] == "ak-47") then
			weaponInformation[getLocalPlayer][1] = "M4"
			weaponInformation[getLocalPlayer][2] = "30"
			weaponInformation[getLocalPlayer][3] = "1200"
			weaponInformation[getLocalPlayer][4] = "100"
		elseif (weaponInformation[getLocalPlayer][1] == "M4") then
			weaponInformation[getLocalPlayer][1] = "Shotgun"
			weaponInformation[getLocalPlayer][2] = "10 (per pellet)"
			weaponInformation[getLocalPlayer][3] = "500"
			weaponInformation[getLocalPlayer][4] = "100"
		elseif (weaponInformation[getLocalPlayer][1] == "Shotgun") then
			weaponInformation[getLocalPlayer][1] = "sawed-off"
			weaponInformation[getLocalPlayer][2] = "10 (per pellet)"
			weaponInformation[getLocalPlayer][3] = "700"
			weaponInformation[getLocalPlayer][4] = "100"
		elseif (weaponInformation[getLocalPlayer][1] == "sawed-off") then
			weaponInformation[getLocalPlayer][1] = "Combat Shotgun"
			weaponInformation[getLocalPlayer][2] = "15 (per pellet)"
			weaponInformation[getLocalPlayer][3] = "1100"
			weaponInformation[getLocalPlayer][4] = "100"
		elseif (weaponInformation[getLocalPlayer][1] == "Combat Shotgun") then
			weaponInformation[getLocalPlayer][1] = "tec-9"
			weaponInformation[getLocalPlayer][2] = "20"
			weaponInformation[getLocalPlayer][3] = "400"
			weaponInformation[getLocalPlayer][4] = "100"
		elseif (weaponInformation[getLocalPlayer][1] == "tec-9") then
			weaponInformation[getLocalPlayer][1] = "uzi"
			weaponInformation[getLocalPlayer][2] = "20"
			weaponInformation[getLocalPlayer][3] = "500"
			weaponInformation[getLocalPlayer][4] = "100"
		elseif(weaponInformation[getLocalPlayer][1] == "uzi") then
			weaponInformation[getLocalPlayer][1] = "mp5"
			weaponInformation[getLocalPlayer][2] = "25"
			weaponInformation[getLocalPlayer][3] = "800"
			weaponInformation[getLocalPlayer][4] = "100"
		elseif (weaponInformation[getLocalPlayer][1] == "mp5") then
			weaponInformation[getLocalPlayer][1] = "deagle"
			weaponInformation[getLocalPlayer][2] = "70"
			weaponInformation[getLocalPlayer][3] = "1000"
			weaponInformation[getLocalPlayer][4] = "100"
		elseif (weaponInformation[getLocalPlayer][1] == "deagle") then
			weaponInformation[getLocalPlayer][1] = "ak-47"
			weaponInformation[getLocalPlayer][2] = "30"
			weaponInformation[getLocalPlayer][3] = "1000"
			weaponInformation[getLocalPlayer][4] = "100"
		end
	end
	guiSetText(GUIEditor.label[1], "Weapon information:\nWeapon name:" ..tostring(weaponInformation[getLocalPlayer][1]).."\nWeapon damage:" ..tostring(weaponInformation[getLocalPlayer][2]).."\nWeapon Price:"..tostring(weaponInformation[getLocalPlayer][3]).."$\nWeapon bullets:"..tostring(weaponInformation[getLocalPlayer][4]))
end

function buyWeaponFromStore()
	if (isElement(getLocalPlayer())) then
		triggerServerEvent("handleBuyWeapon", getLocalPlayer(), weaponInformation[getLocalPlayer][1], weaponInformation[getLocalPlayer][3], weaponInformation[getLocalPlayer][4])
	end
end


function closeWeaponInterface()
	if (getWindowDisplayed()) then
		destroyAll()--destroy everything in the interface
		guiGetInputEnabled(false)
		showCursor(false)
		removeEventHandler("onClientRender", getRootElement(), drawDXWeaponName)
		weaponInformation[getLocalPlayer] = nil
	end
end



--CUSTOM EVENTS

addEvent("showAmmunationInterface", true)
addEventHandler("showAmmunationInterface", getRootElement(), showAmmunationInterface)