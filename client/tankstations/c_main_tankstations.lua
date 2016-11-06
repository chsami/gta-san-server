local gas_marker_1 = createMarker(1944, -1769, 12.6, "cylinder", 2, 255, 0, 0, 150)
local gas_marker_2 = createMarker(1945, -1776, 13, "cylinder", 2, 255, 0, 0, 150)

local total_fuel_litres = 1
local total_fuel_price = 0
local GAS_PRICE = 3
local vehicleName = nil

function getFuelLitres()
	return total_fuel_litres
end

function getFuelPrice()
	return total_fuel_price
end

addEventHandler("onClientMarkerHit", gas_marker_1, function(hitElement)
	if (isPedInVehicle(hitElement) ~= nil) then
		local theVehicle = getPedOccupiedVehicle(hitElement)
		if (theVehicle) then
			elementType = getElementType(theVehicle)
			if (isElement(theVehicle) and isLoggedIn() and elementType == "vehicle") then
				outputChatBox("hit marker")
				showTankstationInterface()
			end
		end
	end
end)

addEventHandler("onClientMarkerHit", gas_marker_2, function(hitElement)
	if (isPedInVehicle(hitElement) ~= nil) then
		local theVehicle = getPedOccupiedVehicle(hitElement)
		if (theVehicle) then
			local elementType = getElementType(theVehicle)
			if (isElement(theVehicle) and isLoggedIn() and elementType == "vehicle") then
				showTankstationInterface()
			end
		end
	end
end)

function showTankstationInterface()
	if not (getWindowDisplayed()) then
		local theVehicle = getPedOccupiedVehicle(localPlayer)
		vehicleName = getVehicleName(theVehicle)
		if (theVehicle) then
			outputChatBox("show interface")
			local vehicleFuel = getVehicleFuel(theVehicle)
			total_fuel_litres = calculateFuelTankDifference(theVehicle)
			total_fuel_price = calculateFuelPrice()
			GUIEditor.window[1] = guiCreateWindow(0.37, 0.24, 0.25, 0.40, "Gas station", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.12, 0.81, 0.33, 0.13, "Pay", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF4DFD00")
			GUIEditor.button[2] = guiCreateButton(0.92, 0.08, 0.04, 0.04, "X", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")
			GUIEditor.button[3] = guiCreateButton(0.60, 0.81, 0.28, 0.12, "Fill gas can", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FF4DFD00")
			GUIEditor.label[1] = guiCreateLabel(0.12, 0.11, 0.75, 0.06, "Vehicle current fuel : " ..vehicleFuel.."L", true, GUIEditor.window[1])
			guiSetFont(GUIEditor.label[1], "clear-normal")
			GUIEditor.label[2] = guiCreateLabel(0.12, 0.20, 0.75, 0.06, "Fuel price : $3", true, GUIEditor.window[1])
			guiSetFont(GUIEditor.label[2], "clear-normal")
			GUIEditor.label[3] = guiCreateLabel(0.12, 0.28, 0.75, 0.06, "Full tank costs : $" ..total_fuel_price, true, GUIEditor.window[1])
			guiSetFont(GUIEditor.label[3], "clear-normal")
			GUIEditor.label[4] = guiCreateLabel(0.12, 0.45, 0.75, 0.06, ""..total_fuel_litres.."L", true, GUIEditor.window[1])
			guiSetFont(GUIEditor.label[4], "clear-normal")
			guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
			GUIEditor.button[4] = guiCreateButton(0.48, 0.38, 0.04, 0.04, "+", true, GUIEditor.window[1])
			GUIEditor.button[5] = guiCreateButton(0.48, 0.54, 0.04, 0.04, "-", true, GUIEditor.window[1])
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handlePayBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], closeTankStationInterface, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[3], handleFillGasCanBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[4], addLitresBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[5], removeLitresBtn, false)
			showCursor(true)
		end
	end
end

function addFuel()
	if (calculateFuelTankDifference(vehicleName) > total_fuel_litres) then
		total_fuel_litres = total_fuel_litres + 1
	else
		outputChatBox("Your fuel tank is full.", 255, 0, 0)
	end
end

function removeFuel()
	if (total_fuel_litres > 1) then
		total_fuel_litres = total_fuel_litres - 1
	end
end

function calculateFuelTankDifference()
	return (getVehicleTank(vehicleName) - getVehicleFuel())
end

function calculateFuelPrice()
	return total_fuel_litres * GAS_PRICE
end

function closeTankStationInterface()
	destroyAll()
	showCursor(false)
end

function addLitresBtn()
	if (getWindowDisplayed()) then
		if (isLoggedIn()) then
			addFuel()
			total_fuel_price = calculateFuelPrice()
			guiSetText(GUIEditor.label[3], "Full tank costs : $" ..tostring(getFuelPrice()))
			guiSetText(GUIEditor.label[4], tostring(getFuelLitres()).."L")
		end
	end
end

function removeLitresBtn()
	if (getWindowDisplayed()) then
		if (isLoggedIn()) then
			removeFuel()
			total_fuel_price = calculateFuelPrice()
			guiSetText(GUIEditor.label[3], "Full tank costs : $" ..tostring(getFuelPrice()))
			guiSetText(GUIEditor.label[4], tostring(getFuelLitres()).."L")
		end
	end
end

function handlePayBtn()
	if (getWindowDisplayed()) then
		if (isLoggedIn()) then
			if (getPlayerMoney(localPlayer) >= getFuelPrice()) then
				if (isPedInVehicle(localPlayer)) then
					local local_vehicle = getPedOccupiedVehicle(localPlayer)
					if (local_vehicle) then
						local totalFuel = getVehicleFuel(local_vehicle) + getFuelLitres()
						triggerServerEvent("refillFuel", localPlayer, totalFuel, getFuelPrice(), local_vehicle)
						closeTankStationInterface()
						setVehicleFuel(totalFuel)
					end
				else
					outputChatBox("Your not in a vehicle!")
				end
			else
				outputChatBox("You don't have enough money to buy this amount of gas...", 255, 0, 0)
			end
		end
	end
end

function handleFillGasCanBtn()
	if (getWindowDisplayed()) then
		if (isLoggedIn()) then
			outputChatBox("You don't have a gass can!")
			--triggerServerEvent("refillFuel", localPlayer, theVehicle, getFuelLitres(), getFuelPrice())
		end
	end
end

