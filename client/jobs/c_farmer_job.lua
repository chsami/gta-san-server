
--[[
--Currently disabled as we have a better way of farming cocaine
local coca_plant_1 = createPickup ( -1147, -1134, 129.2, 3, 325, 3000 )
local coca_plant_2 = createPickup ( -1129, -1095, 129.2, 3, 325, 3000 )
local coca_plant_3 = createPickup ( -1136, -1084, 129.2, 3, 325, 3000 )
local coca_plant_4 = createPickup ( -1178, -1095, 129.2, 3, 325, 3000 )
local coca_plant_5 = createPickup ( -1086, -1095, 129.2, 3, 325, 3000 )
local coca_plant_6 = createPickup ( -1085, -1084, 129.2, 3, 325, 3000 )
]]

local createBushRectangle = createColRectangle ( -1197, -1118, 100,20)

local seed_width = 4
local seed_length = 3



local medicine_shop = createMarker ( -1056, -1195, 128 , "cylinder", 2, 0, 155, 155, 155)
local water_fill = createMarker ( -1035, -1188, 128 , "cylinder", 2, 0, 155, 155, 155)
local grind_cocaine = createMarker(-1063, -1181, 128, "cylinder", 3, 0, 155, 155, 155)

local farming_vehicle_marker = createMarker ( -1210, -1118, 127.2, "cylinder", 6, 50, 200, 0, 80)


	local bush_1 = createObject(826, -1180, -1101, 128.5)
	local bush_2  = createObject(826, -1170, -1102, 128.5)
	local bush_3 = createObject(826, -1160, -1102, 128.5)
	local bush_4 = createObject(826, -1150, -1102, 128.5)
	local bush_5 = createObject(826, -1140, -1102, 128.5)
	local bush_6 = createObject(826, -1130, -1102, 128.5)
	local bush_7 = createObject(826, -1120, -1102, 128.5)
	local bush_8 = createObject(826, -1180, -1113, 128.5)
	local bush_9 = createObject(826, -1170, -1113, 128.5)
	local bush_10 = createObject(826, -1160, -1113, 128.5)
	local bush_11 = createObject(826, -1150, -1113, 128.5)
	local bush_12 = createObject(826, -1140, -1113, 128.5)
	local bush_13 = createObject(826, -1130, -1113, 128.5)
	local bush_14 = createObject(826, -1120, -1113, 128.5)
	
	local arrayBush = { bush_1, bush_2, bush_3, bush_4, bush_5, bush_6, bush_7, bush_8, bush_9, bush_10, bush_11, bush_12, bush_13, bush_14 }
	
		
	setObjectScale ( bush_1, 0.8)
	setObjectScale ( bush_2, 0.8)
	setObjectScale ( bush_3, 0.8)
	setObjectScale ( bush_4, 0.8)
	setObjectScale ( bush_5, 0.8)
	setObjectScale ( bush_6, 0.8)
	setObjectScale ( bush_7, 0.8)
	
	setObjectScale ( bush_8, 0.8)
	setObjectScale ( bush_9, 0.8)
	setObjectScale ( bush_10, 0.8)
	setObjectScale ( bush_11, 0.8)
	setObjectScale ( bush_12, 0.8)
	setObjectScale ( bush_13, 0.8)
	setObjectScale ( bush_14, 0.8)
	
	
	
	
	local SEED_TIMER = 15000 --client side :)
	
function handleFarmingWithVehicle(theMarker, theElement, seed, bush)
	if (theElement == getLocalPlayer() and isLoggedIn()) then 
		if (getElementType ( theElement ) == "player") then
			farm_thePlayer = theElement
		end
		if (farm_thePlayer) then
			if (getPedOccupiedVehicle(farm_thePlayer)) then
				if (getElementModel(getPedOccupiedVehicle ( farm_thePlayer )) == 532) then
					local x, y, z = getElementPosition(theMarker)
					destroyElement(theMarker)
					respawnBush(tostring(bush))
					triggerServerEvent("addCocaine", getLocalPlayer(), math.random(1, 4))
					setTimer(function()
						seed[bush] = createMarker ( x, y, z, "cylinder", 4, 0, 0, 0, 0, getLocalPlayer())
					end, SEED_TIMER, 1)
				end
			end
		end
	end
end

function shapeFarmHit(theShape)
	if (source == getLocalPlayer()) then
		if (theShape == createBushRectangle) then
			makeDXPlantsHarvestTextAppear()
		end
	end
end

function shapeFarmLeave(theShape)
	if (source == getLocalPlayer()) then
		if (theShape == createBushRectangle) then
			makeDXPlantsHarvestTextDissapear()
		end
	end
end

--First we destroy the bush, and after 15 seconds or 15000 miliseconds we respawn the bush at the place where it got destroyed
function respawnBush(bush_number)
	for i = 1, 14, 1 do
		if (i == tonumber(bush_number)) then
			local x, y, z = getElementPosition(arrayBush[i])
			destroyElement(arrayBush[i])
			setTimer(function()
				arrayBush[i] = createObject(826, x, y, z)
			end, SEED_TIMER, 1)
		end
	end
end

function makeLineAppear()
	addEventHandler("onClientRender", getRootElement(), createLine)
end
function createLine ( )
	x2, y2, z2 = getElementPosition ( getLocalPlayer ())                  -- Get local players position.
	dxDrawLine3D ( -1197, -1118, 129, -1097, -1118, 129, tocolor ( 0, 255, 0, 230 ), 2) 
	dxDrawLine3D ( -1097, -1118, 129, -1097, -1097, 129, tocolor ( 0, 255, 0, 230 ), 2) 
	dxDrawLine3D ( -1097, -1097, 129, -1197, -1097, 129, tocolor ( 0, 255, 0, 230 ), 2) 
	dxDrawLine3D ( -1197, -1097, 129, -1197, -1118, 129, tocolor ( 0, 255, 0, 230 ), 2) 
end

function makeDXPlantsHarvestTextAppear()
		setElementData(getLocalPlayer(), "dxText", 1)
		if (getElementData(getLocalPlayer(), "dxText") == 1) then
			addEventHandler("onClientRender", getRootElement(), createDXPlantsHarvestText)
			setElementData(getLocalPlayer(), "dxText", 0)
		end
end


function makeDXPlantsHarvestTextDissapear()
	removeEventHandler("onClientRender", getRootElement(), createDXPlantsHarvestText)
end


function createDXPlantsHarvestText()
	local plant_amount = getElementData(localPlayer, "cocaine")
	if (plant_amount) then
		dxDrawText("Coca plants harvested :" ..plant_amount, 1049/1600*screenWidth, 713/900*screenHeight, 1572/1600*screenWidth, 774/900*screenHeight, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "left", "center", false, false, true, false, false)
		dxDrawText("Coca plants harvested :" ..plant_amount, 1049/1600*screenWidth, 711/900*screenHeight, 1572/1600*screenWidth, 772/900*screenHeight, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "left", "center", false, false, true, false, false)
		dxDrawText("Coca plants harvested :" ..plant_amount, 1047/1600*screenWidth, 713/900*screenHeight, 1570/1600*screenWidth, 774/900*screenHeight, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "left", "center", false, false, true, false, false)
		dxDrawText("Coca plants harvested :" ..plant_amount, 1047/1600*screenWidth, 711/900*screenHeight, 1570/1600*screenWidth, 772/900*screenHeight, tocolor(0, 0, 0, 255), 0.70, "bankgothic", "left", "center", false, false, true, false, false)
		dxDrawText("Coca plants harvested :" ..plant_amount, 1048/1600*screenWidth, 712/900*screenHeight, 1571/1600*screenWidth, 773/900*screenHeight, tocolor(34, 109, 1, 255), 0.70, "bankgothic", "left", "center", false, false, true, false, false)
	end
end

function MarkerFarmHit ( hitPlayer, matchingDimension )
	if (hitPlayer == getLocalPlayer() and getElementType(hitPlayer) == "player" and isLoggedIn()) then
		if (getElementData(hitPlayer, "arrested")) then
			if (getElementData(hitPlayer, "arrested") == "true") then
				return
			end
		end
		if (source == medicine_shop) then
			buildMedicineInterface()
		elseif (source == water_fill) then
			triggerServerEvent("fillWaterBottle", getLocalPlayer())
			guiSetInputEnabled(true)
			setTimer(function()
				guiSetInputEnabled(false)
			end, 3000, 1)
		elseif (source == grind_cocaine) then
			triggerServerEvent("getDrugsInv", hitPlayer, true)
		elseif (source == farming_vehicle_marker) then
			if not (isPedInVehicle(localPlayer)) then
				if (getCurrentJob() == "farmer") then
					createSpawnVehiclesGuiClient("Combine Harvester")
				else
					drawNotificationMessage(hitPlayer, "You have to be a farmer to work here!")
				end
			end
		end
	end
end



function mapLoad()
	local waterCooler = createObject ( 1808, -1035, -1188, 128, 0, 0, -90) 
	local cocaine_grinder = createObject(958, -1063, -1181, 129)
	makeLineAppear()
	if (waterCooler and cocaine_grinder) then
		local z = 128
		local markerType = "cylinder"
		local size = 4
		local red = 0
		local alpha = 0
		local createSeed_1 = createMarker ( -1180, -1103, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_2 = createMarker ( -1170, -1103, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_3 = createMarker ( -1160, -1103, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_4 = createMarker ( -1150, -1103, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_5 = createMarker ( -1140, -1103, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_6 = createMarker ( -1130, -1103, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_7 = createMarker ( -1120, -1103, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		z = 127
		local createSeed_8 = createMarker ( -1180, -1114, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_9 = createMarker ( -1170, -1114, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_10 = createMarker ( -1160, -1114, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_11 = createMarker ( -1150, -1114, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_12 = createMarker ( -1140, -1114, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_13 = createMarker ( -1130, -1114, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())
		local createSeed_14 = createMarker ( -1120, -1114, z, markerType, size, red, 0, 0, alpha, getLocalPlayer())

		local arraySeeds = {createSeed_1, createSeed_2, createSeed_3, createSeed_4, createSeed_5, createSeed_6, createSeed_7, createSeed_8, createSeed_9, createSeed_10, createSeed_11, createSeed_12, createSeed_13, createSeed_14 }
		addEventHandler ( "onClientMarkerHit", getRootElement(), function(hitPlayer, matchingDimension)
			for i = 1, 14, 1 do
				if (source == arraySeeds[i]) then
					handleFarmingWithVehicle(source, hitPlayer, arraySeeds, i)
				end
			end
		end
		)
		outputChatBox("Objects succesfully initialized!")
	else
		outputChatBox("Error loading objects", getLocalPlayer())
	end
end


function buildMedicineInterface()
	if not(getWindowDisplayed()) then
		GUIEditor.window[1] = guiCreateWindow(0.29, 0.16, 0.45, 0.30, "Medicine shop", true)
		guiWindowSetSizable(GUIEditor.window[1], false)

		GUIEditor.label[1] = guiCreateLabel(0.03, 0.18, 0.28, 0.17, "1L hydrochloric acid\nPrice: 35$", true, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[1], "default-bold-small")
		guiLabelSetColor(GUIEditor.label[1], 77, 255, 0)
		guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
		GUIEditor.button[1] = guiCreateButton(0.31, 0.21, 0.14, 0.11, "BUY", true, GUIEditor.window[1])
		GUIEditor.label[2] = guiCreateLabel(0.50, 0.18, 0.49, 0.17, "Information : Hydrochloric Acid is a strong mineral acid. \nIt is highly corrosive and is used in a wide range of industrial\nprocesses.", true, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[2], "default-bold-small")
		guiLabelSetColor(GUIEditor.label[2], 255, 0, 0)
		guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
		GUIEditor.label[3] = guiCreateLabel(0.03, 0.51, 0.28, 0.17, "100 tablets Potassium salt\nPrice: 20$", true, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[3], "default-bold-small")
		guiLabelSetColor(GUIEditor.label[3], 77, 255, 0)
		guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
		GUIEditor.button[2] = guiCreateButton(0.31, 0.53, 0.14, 0.11, "BUY", true, GUIEditor.window[1])
		GUIEditor.label[4] = guiCreateLabel(0.50, 0.49, 0.49, 0.24, "Information : Potassium is a chemical element with symbol K\nand atomic number 19. Elemental potassium is a soft\nsilvery-white alkali metal that oxidizes rapidly\nin air and is very reactive with water.", true, GUIEditor.window[1])
		guiSetFont(GUIEditor.label[4], "default-bold-small")
		guiLabelSetColor(GUIEditor.label[4], 255, 0, 0)
		guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
		GUIEditor.button[3] = guiCreateButton(0.95, 0.07, 0.03, 0.06, "X", true, GUIEditor.window[1])
		guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FFFF0000")   
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleMedicineBuyBtnAcid, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleMedicineBuyBtnSalt, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[3], closeMedicineInterface, false)
		setElementFrozen ( getLocalPlayer(), true )
		guiSetInputEnabled(true)
		showCursor(true)	
	end
end


function handleMedicineBuyBtnAcid()
	triggerServerEvent("buyMedicine", getLocalPlayer(), "Hydrochloric_Acid")
end

function handleMedicineBuyBtnSalt()
	triggerServerEvent("buyMedicine", getLocalPlayer(), "Potassium_Salt")
end

function closeMedicineInterface()
	if (GUIEditor.window[1]) then
		destroyElement(GUIEditor.window[1])
		GUIEditor.window[1] = nil
		guiSetInputEnabled(false)
		showCursor(false)
		setElementFrozen ( getLocalPlayer(), false )
	end
end



function displayDrugsInventory(_, thePlayer, cocaine, pota_salt, hydro_acid, crack_produced, water_bottles)
	if (getLocalPlayer() == thePlayer) then
		if not (getWindowDisplayed()) then
			GUIEditor.window[1] = guiCreateWindow(0.78, 0.31, 0.17, 0.50, "Drug Inventory", true)
			guiWindowSetSizable(GUIEditor.window[1], true)

			GUIEditor.label[1] = guiCreateLabel(0.04, 0.09, 0.92, 0.06, "Hydrochloric Acid bottles : "..hydro_acid.." bottle(s)", true, GUIEditor.window[1])
			GUIEditor.label[2] = guiCreateLabel(0.04, 0.17, 0.92, 0.06, "Potassium salt tablets :"..pota_salt.." tablets", true, GUIEditor.window[1])
			GUIEditor.label[3] = guiCreateLabel(0.04, 0.26, 0.92, 0.06, "Coca leaves : "..cocaine, true, GUIEditor.window[1])
			GUIEditor.label[4] = guiCreateLabel(0.04, 0.34, 0.92, 0.06, "Crack cocaine : "..crack_produced.."g", true, GUIEditor.window[1])
			GUIEditor.label[5] = guiCreateLabel(0.04, 0.42, 0.92, 0.06, "Water bottles : "..water_bottles.." bottle(s)", true, GUIEditor.window[1])
			GUIEditor.button[1] = guiCreateButton(0.88, 0.07, 0.06, 0.04, "X", true, GUIEditor.window[1])
			guiSetFont(GUIEditor.button[1], "default-bold-small")
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")    
			
			addEventHandler("onClientGUIClick", GUIEditor.button[1], closeDrugsInventory, false)
			setElementFrozen ( getLocalPlayer(), true )
			showCursor(true)	
		end
	end
end





function closeDrugsInventory()
	if (GUIEditor.window[1]) then
		destroyElement(GUIEditor.window[1])
		GUIEditor.window[1] = nil
		showCursor(false)	
		setElementFrozen ( getLocalPlayer(), false )
	end
end




function buildGrindCocaineInterface(_, thePlayer, cocaine, pota_salt, hydro_acid, water_bottles)
	if (getLocalPlayer() == thePlayer) then
		if not (getWindowDisplayed()) then
			GUIEditor.window[1] = guiCreateWindow(0.26, 0.17, 0.51, 0.65, "Manifacture Crack Cocaine", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.label[1] = guiCreateLabel(0.04, 0.09, 0.23, 0.04, "Hydrochloric Acid bottles amount: " , true, GUIEditor.window[1])
			GUIEditor.label[2] = guiCreateLabel(0.04, 0.17, 0.22, 0.05, "Potassium salt tablets amount:" , true, GUIEditor.window[1])
			GUIEditor.label[3] = guiCreateLabel(0.04, 0.25, 0.22, 0.05, "Coca leaves amount:" , true, GUIEditor.window[1])
			GUIEditor.label[4] = guiCreateLabel(0.04, 0.32, 0.22, 0.04, "Water bottles amount:", true, GUIEditor.window[1])
			GUIEditor.button[1] = guiCreateButton(781, 23, 16, 16, "X", false, GUIEditor.window[1])
			guiSetFont(GUIEditor.button[1], "default-bold-small")
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")
			GUIEditor.edit[1] = guiCreateEdit(0.31, 0.09, 0.15, 0.03, "1", true, GUIEditor.window[1])
			GUIEditor.edit[2] = guiCreateEdit(0.31, 0.17, 0.15, 0.03, "50", true, GUIEditor.window[1])
			GUIEditor.edit[3] = guiCreateEdit(0.31, 0.25, 0.15, 0.03, "5", true, GUIEditor.window[1])
			GUIEditor.edit[4] = guiCreateEdit(0.31, 0.33, 0.15, 0.03, "1", true, GUIEditor.window[1])
			GUIEditor.label[5] = guiCreateLabel(0.04, 0.43, 0.42, 0.04, "-----------------------------------------------------------------------------------------------", true, GUIEditor.window[1])
			GUIEditor.label[6] = guiCreateLabel(0.04, 0.54, 0.42, 0.04, "Possible crack cocaine produce :", true, GUIEditor.window[1])
			GUIEditor.label[7] = guiCreateLabel(0.54, 0.09, 0.23, 0.04, "You have : " ..hydro_acid, true, GUIEditor.window[1])
			GUIEditor.label[8] = guiCreateLabel(0.54, 0.16, 0.23, 0.04, "You have : " ..pota_salt, true, GUIEditor.window[1])
			GUIEditor.label[9] = guiCreateLabel(0.54, 0.25, 0.23, 0.04, "You have : " ..cocaine, true, GUIEditor.window[1])
			GUIEditor.label[10] = guiCreateLabel(0.54, 0.33, 0.23, 0.04, "You have : " ..water_bottles, true, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(0.27, 0.57, 0.19, 0.05, "Produce!", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF38FB03")   
			
			setElementFrozen ( getLocalPlayer(), true )
			guiSetInputEnabled(true)
			showCursor(true)	
			
			addEventHandler("onClientGUIClick", GUIEditor.button[1], closeGrindCocaineInterface, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], produceCocaineBtn, false)
		end
	end
end

function closeGrindCocaineInterface()
	if (GUIEditor.window[1]) then
		destroyElement(GUIEditor.window[1])
		GUIEditor.window[1] = nil
		guiSetInputEnabled(false)
		showCursor(false)	
		setElementFrozen ( getLocalPlayer(), false )
	end
end

function produceCocaineBtn()
	local hydro_acid = tonumber(guiGetText(GUIEditor.edit[1]))
	local pota_salt = tonumber(guiGetText(GUIEditor.edit[2]))
	local cocaine = tonumber(guiGetText(GUIEditor.edit[3]))
	local water_bottles = tonumber(guiGetText(GUIEditor.edit[4]))
	if (hydro_acid ~= nil and hydro_acid >= 1) then
		if (pota_salt ~= nil and pota_salt >= 50) then
			if (cocaine ~= nil and cocaine >= 5) then
				if (water_bottles ~= nil and water_bottles >= 1) then
					triggerServerEvent("createCrackCocaine", getLocalPlayer(), hydro_acid, pota_salt, cocaine, water_bottles)
					closeGrindCocaineInterface()
				else
					outputChatBox("You need to sacrifice atleast 1 bottle of water!")
				end
			else
				outputChatBox("You need to sacrifice atleast 5 coca leaves!")
			end
		else
			outputChatBox("You need to sacrifice atleast 50 potassium salt tablets!")
		end
	
	else
		outputChatBox("You need to sacrifice atleast 1 bottle of hydrochloric acid!")
	end
end

function createCocainePickup(_, thePlayer)
	if (thePlayer == getLocalPlayer()) then
		local cocaine_bag = createPickup ( -1061, -1174, 129.2, 3, 1279)
		outputChatBox("Your drugs are done and ready to be picked!")
	end
end
 
 
function drawFarmerJobInterface()
	if (source == localPlayer) then
		if not (getWindowDisplayed()) then
			if (isLoggedIn()) then
				GUIEditor.window[1] = guiCreateWindow(0.34, 0.21, 0.37, 0.54, "Countryside Farm", true)
				guiWindowSetSizable(GUIEditor.window[1], false)

				GUIEditor.button[1] = guiCreateButton(0.14, 0.77, 0.26, 0.11, "Become a Farmer", true, GUIEditor.window[1])
				guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF1DFE00")
				GUIEditor.button[2] = guiCreateButton(0.57, 0.77, 0.26, 0.11, "Sell drugs", true, GUIEditor.window[1])
				guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF1DFE00")
				GUIEditor.button[3] = guiCreateButton(0.91, 0.06, 0.07, 0.06, "", true, GUIEditor.window[1])
				guiSetAlpha(GUIEditor.button[3], 0.00)   
				guiSetAlpha(GUIEditor.button[2], 5)  
				addEventHandler("onClientGUIClick", GUIEditor.button[1], handleShowFarmerSkinInterface, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[2], handleChangeSkinBtn, false)
				addEventHandler("onClientGUIClick", GUIEditor.button[3], handleCloseFarmerJobInterface, false)
				showCursor(true)
				showDXFarmerInterface()
			end
		end
	end
end

addEvent("showFarmerJob", true)
addEventHandler("showFarmerJob", localPlayer, drawFarmerJobInterface)


function handleShowFarmerSkinInterface()
	if (getWindowDisplayed()) then
		handleCloseFarmerJobInterface()
		drawFarmerSkinInterface()
	end
end

function handleChangeSkinBtn()
	if (getWindowDisplayed()) then
		outputChatBox("Comming soon...")
	end
end

function handleCloseFarmerJobInterface()
	destroyAll()
	showCursor(false)
	hideDXFarmerInterface()
end


function drawDXFarmerInterface()
        dxDrawImage(1082/1600*screenWidth, 220/900*screenHeight, 18, 20, ":ghetto/conf/images/cross.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText("Welcome to the countryside", 595/1600*screenWidth, 291/900*screenHeight, 1061/1600*screenWidth, 459/900*screenHeight, tocolor(255, 255, 255, 255), 0.70/900*screenHeight, "bankgothic", "center", "center", false, true, true, false, false)
end

function showDXFarmerInterface()
	addEventHandler("onClientRender", root, drawDXFarmerInterface)
end

function hideDXFarmerInterface()
	removeEventHandler("onClientRender", root, drawDXFarmerInterface)
end


local skins = {128, 129, 130, 131, 132, 133, 157, 158, 159, 160, 196, 197, 198, 199, 161}
local temp_save_skin = nil

function drawFarmerSkinInterface()
	if not (getWindowDisplayed()) then
		temp_save_skin = getElementModel(localPlayer)
		local x, y, z = getElementPosition(localPlayer)
        GUIEditor.window[1] = guiCreateWindow(0.15, -0.00, 0.26, 0.65, "Farmer job", true)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetAlpha(GUIEditor.window[1], 1.00)

        GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.13, 0.95, 0.59, true, GUIEditor.window[1])
        buildFarmerSkinList()
		if (getCurrentJob() ~= "farmer") then
			GUIEditor.button[1] = guiCreateButton(0.33, 0.74, 0.34, 0.12, "Become a Farmer", true, GUIEditor.window[1])
		else
			GUIEditor.button[1] = guiCreateButton(0.33, 0.74, 0.34, 0.12, "Change skin", true, GUIEditor.window[1])
		end
        GUIEditor.button[2] = guiCreateButton(0.93, 0.04, 0.04, 0.04, "X", true, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")   
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleBecomeFarmerBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleCloseFarmerSkinInterfaceBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], handlePickFarmerSkinBtn, false)
		showCursor(true)
		setCameraMatrix(-1160.0521240234, -1143.1331787109, 132.6328125, -1224.10546875, -1076.4780273438, 94.497993469238, 0, 70)--farmz
	end
end

function handlePickFarmerSkinBtn()
	if (getWindowDisplayed()) then
		local skinId = getListItem(1)
		if (skinId ~= nil) then
			setElementModel(localPlayer, skinId)
		end
	end
end	

function buildFarmerSkinList()
	if (getWindowDisplayed()) then
		local counter = 0
		guiGridListAddColumn(GUIEditor.gridlist[1], "Skin", 0.5)
		for i = 1, #skins do
			guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1], counter, 1, skins[i], false, false)
			counter = counter + 1
		end
	end
end

function handleBecomeFarmerBtn()
	if (getWindowDisplayed()) then
		local skinId = getListItem(1)
		if (skinId ~= nil) then
			setCameraTarget(localPlayer)
			triggerServerEvent("setNewJob", localPlayer, "farmer", skinId)
			setCurrentJob("farmer")
			destroyAll()
			showCursor(false)
		end
	end
end

function handleCloseFarmerSkinInterfaceBtn()
	destroyAll()
	showCursor(false)
	if (temp_save_skin ~= nil) then setElementModel(localPlayer, temp_save_skin) end
end





--CUSTOM EVENTS

addEvent("createCocainePickup", true)
addEventHandler("createCocainePickup", localPlayer, createCocainePickup)

addEvent("buildGrindCocaineInterface", true)
addEventHandler("buildGrindCocaineInterface", localPlayer, buildGrindCocaineInterface)

addEvent("displayDrugsInventory", true)
addEventHandler("displayDrugsInventory", getRootElement(), displayDrugsInventory)


--CLIENT EVENTS

addEventHandler ( "onClientMarkerHit", root, MarkerFarmHit )


addEventHandler( "onClientElementColShapeHit", root, shapeFarmHit)
addEventHandler("onClientElementColShapeLeave",root,shapeFarmLeave)


addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), mapLoad )