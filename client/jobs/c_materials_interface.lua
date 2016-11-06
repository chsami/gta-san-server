function showMaterialsInterface()
	if not (getWindowDisplayed()) then
		if (isLoggedIn() and source == localPlayer) then
			GUIEditor.window[1] = guiCreateWindow(0.44, 0.40, 0.25, 0.17, "Materials", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.22, 0.56, 0.47, 0.36, "Buy materials", true, GUIEditor.window[1])
			guiSetFont(GUIEditor.button[1], "default-bold-small")
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF30FE00")
			GUIEditor.button[2] = guiCreateButton(0.92, 0.15, 0.05, 0.13, "X", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFD0000")
			GUIEditor.edit[1] = guiCreateEdit(0.25, 0.33, 0.37, 0.17, "", true, GUIEditor.window[1])
			GUIEditor.label[1] = guiCreateLabel(0.00, 0.32, 0.34, 0.18, "Materials :", true, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
			GUIEditor.label[2] = guiCreateLabel(0.63, 0.32, 0.34, 0.18, "Total : $0", true, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[2], "center")    
			showCursor(true)
			guiSetInputEnabled(true)
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleBuyMaterialsBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], handleCloseMaterialsInterfaceBtn, false)
			addEventHandler("onClientGUIChanged", GUIEditor.edit[1], calculatePrice, false)
		end
	end
end

addEvent("materialsInterface", true)
addEventHandler("materialsInterface", localPlayer, showMaterialsInterface)


function showCraftMaterialsInterface(_, par_materials)
	if not (getWindowDisplayed()) then
		if (isLoggedIn() and source == localPlayer) then
			GUIEditor.window[1] = guiCreateWindow(0.26, 0.16, 0.15, 0.31, "Crafting materials", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.28, 0.75, 0.42, 0.21, "Craft materials", true, GUIEditor.window[1])
			guiSetFont(GUIEditor.button[1], "default-bold-small")
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF35FD00")
			GUIEditor.label[1] = guiCreateLabel(0.28, 0.27, 0.42, 0.22, "Materials: " ..par_materials, true, GUIEditor.window[1])
			guiSetFont(GUIEditor.label[1], "default-bold-small")
			guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
			GUIEditor.button[2] = guiCreateButton(0.85, 0.10, 0.09, 0.08, "X", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFC0500")    
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleCraftMaterialsBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], handleCloseMaterialsInterfaceBtn, false)
			showCursor(true)
			guiSetInputEnabled(true)
		end
    end
end

addEvent("craftMaterialsInterface", true)
addEventHandler("craftMaterialsInterface", localPlayer, showCraftMaterialsInterface)

function dxDrawHint()
	if (isLoggedIn()) then
		if (getPedAnimation ( localPlayer ) ~= false) then
			dxDrawText("/stopmaterials to stop", 473/1600*screenWidth, 328/900*screenHeight, 1139/1600*screenWidth, 459/900*screenHeight, tocolor(254, 215, 0, 155), 1.50/900*screenHeight, "pricedown", "center", "center", false, false, true, false, false)
		end
	end
end

function showDXHint()
	addEventHandler("onClientRender", root, dxDrawHint)
end

function hideDXHint()
	removeEventHandler("onClientRender", root, dxDrawHint)
end

function handleCraftMaterialsBtn()
	if (getWindowDisplayed()) then
		triggerServerEvent("craftMaterials", localPlayer)
		handleCloseMaterialsInterfaceBtn()
		showDXHint()
	end
end

addEvent("hideHint", true)
addEventHandler("hideHint", localPlayer, hideDXHint)


function calculatePrice()
	if (getWindowDisplayed()) then
		local pattern = "[0123456789]"
		local amount = guiGetText(GUIEditor.edit[1])
		if (amount ~= nil and amount ~= "") then
			if (string.match(amount, pattern)) then
				local total_price = tonumber(amount) * 50
				guiSetText(GUIEditor.label[2], "$"..tostring(total_price))
			end
		end
	end
end

function handleBuyMaterialsBtn()
	if (getWindowDisplayed()) then
		local pattern = "[0123456789]"
		local amount = guiGetText(GUIEditor.edit[1])
		if (amount ~= nil and amount ~= "") then
			if (string.match(amount, pattern)) then
				triggerServerEvent("buyMaterials", localPlayer, amount)
				handleCloseMaterialsInterfaceBtn()
			end
		end
	end
end

function handleCloseMaterialsInterfaceBtn()
	destroyAll()
	showCursor(false)
	guiSetInputEnabled(false)
end


function drawCreateWeaponInterface()
	GUIEditor.window[1] = guiCreateWindow(0.26, 0.16, 0.50, 0.70, "Create Weapons", true)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(0.09, 0.22, 0.17, 0.07, "AK47x90\n50x crafted materials", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
	GUIEditor.button[1] = guiCreateButton(0.09, 0.31, 0.12, 0.07, "Craft Ak47", true, GUIEditor.window[1])
	GUIEditor.button[2] = guiCreateButton(0.09, 0.68, 0.12, 0.07, "Craft Desert eagle", true, GUIEditor.window[1])
	GUIEditor.label[2] = guiCreateLabel(0.09, 0.60, 0.17, 0.07, "Desert eaglex30\n40x crafted materials", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[2], "default-bold-small")
	guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
	GUIEditor.label[3] = guiCreateLabel(0.40, 0.22, 0.17, 0.07, "MP5x90\n30x crafted materials", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[3], "default-bold-small")
	guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
	GUIEditor.button[3] = guiCreateButton(0.40, 0.31, 0.12, 0.07, "Craft MP5", true, GUIEditor.window[1])
	GUIEditor.button[4] = guiCreateButton(0.40, 0.68, 0.12, 0.07, "Craft Sniper", true, GUIEditor.window[1])
	GUIEditor.label[4] = guiCreateLabel(0.40, 0.60, 0.17, 0.07, "Sniperx20\n60x crafted materials", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[4], "default-bold-small")
	guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
	GUIEditor.label[5] = guiCreateLabel(0.73, 0.22, 0.17, 0.07, "Tec9x120\n15x crafted materials", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[5], "default-bold-small")
	guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
	GUIEditor.button[5] = guiCreateButton(0.73, 0.31, 0.12, 0.07, "Craft tec9", true, GUIEditor.window[1])
	GUIEditor.button[6] = guiCreateButton(0.92, 0.04, 0.05, 0.06, "", true, GUIEditor.window[1])
	guiSetAlpha(GUIEditor.button[6], 0.00)  
	showCursor(true)
	guiSetInputEnabled(true)
	showDXCreateWeaponInterface()
	addEventHandler("onClientGUIClick", GUIEditor.button[1], handleCraftAK47Btn, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[2], handleCraftDesertEagleBtn, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[3], handleCraftMP5Btn, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[4], handleCraftSniperBtn, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[5], handleCraftTec9Btn, false)
	addEventHandler("onClientGUIClick", GUIEditor.button[6], handleCloseCreateWeaponInterface, false)
end

addEvent("craftWeapon", true)
addEventHandler("craftWeapon", localPlayer, drawCreateWeaponInterface)

function handleCraftAK47Btn()
	if (getWindowDisplayed()) then
		triggerServerEvent("craftWeapon", localPlayer, "ak47", 50)
	end
end

function handleCraftDesertEagleBtn()
	if (getWindowDisplayed()) then
		triggerServerEvent("craftWeapon", localPlayer, "deserteagle", 40)
	end
end

function handleCraftMP5Btn()
	if (getWindowDisplayed()) then
		triggerServerEvent("craftWeapon", localPlayer, "mp5", 30)
	end
end

function handleCraftSniperBtn()
	if (getWindowDisplayed()) then
		triggerServerEvent("craftWeapon", localPlayer, "sniper", 60)
	end
end

function handleCraftTec9Btn()
	if (getWindowDisplayed()) then
		triggerServerEvent("craftWeapon", localPlayer, "tec9", 15)
	end
end

function handleCloseCreateWeaponInterface()
	destroyAll()
	showCursor(false)
	guiSetInputEnabled(false)
	hideDXCreateWeaponInterface()
end

function drawDXCreateWeaponInterface()
	dxDrawImage(482, 194, 81, 71, ":ghetto/conf/images/weapons/ak47icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawImage(491, 427, 72, 81, ":ghetto/conf/images/weapons/desert_eagleicon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawImage(736, 194, 81, 71, ":ghetto/conf/images/weapons/tec9icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawImage(730, 426, 81, 82, ":ghetto/conf/images/weapons/SNIPERicon.png", 0, 71, 0, tocolor(255, 255, 255, 255), true)
	dxDrawImage(997, 194, 81, 71, ":ghetto/conf/images/weapons/tec9icon.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
	dxDrawImage(1155, 174, 20, 20, ":ghetto/conf/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
end

function showDXCreateWeaponInterface()
	addEventHandler("onClientRender", root, drawDXCreateWeaponInterface)
end

function hideDXCreateWeaponInterface()
	removeEventHandler("onClientRender", root, drawDXCreateWeaponInterface)
end