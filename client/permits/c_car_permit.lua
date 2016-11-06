local car_permit_marker = createMarker(987, -925, 41, "cylinder", 3, 0, 150, 150, 150)

local checkPoint = 1

local pointsX = {797, 622, 628, 812, 1278, 1295, 1691, 1525, 1459, 1378, 994}
local pointsY = {-1044, -1210, -1711, -1723, -1572, -1833, -1605, -1591, -1241, -952, -964}
local pointsZ = {24, 17, 13, 12, 12, 12, 12, 12, 13, 33, 40}

local m = nil
local b = nil

local exam_timer = 180
local theTimer = nil

local startedExam = false

function getStartedExam()
	return startedExam
end

function getCheckPoint()
	return checkPoint
end

function setCheckPoint(par_checkPoint)
	checkPoint = par_checkPoint
end

function increaseCheckPoint(add)
	checkPoint = checkPoint + add
end

function showCarPermitInterface()
	if not (getWindowDisplayed()) then
		if not (isPedInVehicle(localPlayer)) then
			if (getElementData(localPlayer, "permit_car") == 0) then
				if not (exam_timer ~= 180) then
					GUIEditor.window[1] = guiCreateWindow(0.39, 0.28, 0.29, 0.30, "Car permit", true)
					guiWindowSetSizable(GUIEditor.window[1], false)
					
					GUIEditor.button[1] = guiCreateButton(0.33, 0.69, 0.35, 0.22, "Start Exam", true,GUIEditor.window[1])
					GUIEditor.button[2] = guiCreateButton(0.95, 0.12, 0.03, 0.05, "X", true, GUIEditor.window[1])
					guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFF0000")
					GUIEditor.label[1] = guiCreateLabel(0.29, 0.23, 0.48, 0.24, "The exam costs 20.000$\nIf you fail you'll have to do it over again.", true, GUIEditor.window[1])
					guiSetFont(GUIEditor.label[1], "default-bold-small")
					guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
					guiLabelSetVerticalAlign(GUIEditor.label[1], "center")    
					showCursor(true)
					addEventHandler("onClientGUIClick", GUIEditor.button[1], handleStartExamBtn, false)
					addEventHandler("onClientGUIClick", GUIEditor.button[2], closeExamBtn, false)
				else
					outputChatBox("You already started your exam...", 255, 0, 0)
				end
			else
				outputChatBox("You already have a car permit!", 255, 0, 0)
			end
		end
	end
end

function handleStartExamBtn(button, state)
	if (button == "left" and state == "up") then
		if (getWindowDisplayed()) then
			if (isElement(localPlayer)) then
				startExam()
			end
		end
	end
end

function startExam()
	triggerServerEvent("spawnTempVehicle", localPlayer, "Tahoma")
	createCheckPoints()
	startExamTimer()
	closeExamBtn()
	showExamTimer()
end

function createCheckPoints()
	local size = 4
	deleteCheckPoint()
	m = createMarker(pointsX[getCheckPoint()], pointsY[getCheckPoint()], pointsZ[getCheckPoint()], "checkpoint", size)
	b = createBlipAttachedTo ( m, 0, 2)
	createArrowPos(m)
	--setMarkerIcon ( m, "arrow" )
	addEventHandler("onClientMarkerHit", m, handleNextCheckpoint)
	outputChatBox("Checkpoint : " ..tostring(getCheckPoint()).."/11")
end

function deleteCheckPoint()
	if (isElement(m) and isElement(b)) then
		destroyElement(m)
		destroyElement(b)
	end
end

function calculateVehicleDamage()
	if (isElement(localPlayer)) then
		local vehicle = getPedOccupiedVehicle ( localPlayer )
		local vehicleHealth = getElementHealth(vehicle)
		if (vehicleHealth > 700) then
			return true
		end
	end
	return false
end

function succesExam()
	setNormalAchievement(_, "You passed your car exam!", 1000)
	setCheckPoint(1)
	outputChatBox("You passed your car exam!", 255, 0, 0)
	outputChatBox("[INFO] You can now buy your own car!", 255, 0, 0)
	setElementData(localPlayer, "permit_car", 1)
	deleteCheckPoint()
	if (isTimer(theTimer)) then
		killTimer(theTimer)
	end
end

function failExam()
	setCheckPoint(1)
	outputChatBox("You failed your exam!", 255, 0, 0)
	hideExamTimer()
	deleteCheckPoint()
	destroyArrow()
	triggerServerEvent("destroyTempVehicle", localPlayer)
	exam_timer = 180
	if (isTimer(theTimer)) then
		killTimer(theTimer)
	end
end

function handleNextCheckpoint()
	if (isElement(localPlayer)) then
		if (getCheckPoint() == 11) then
			destroyArrow()
			triggerServerEvent("destroyTempVehicle", localPlayer)
			if (calculateVehicleDamage()) then
				succesExam()
				return
			else
				failExam()
				return
			end
		end
		increaseCheckPoint(1)
		createCheckPoints()
	end
end

function startExamTimer()
	theTimer = setTimer(function()
		if (exam_timer > 0 and isLoggedIn()) then
			exam_timer = exam_timer - 1
		else
			failExam()
		end
	end, 1000, 0)
end

function closeExamBtn()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
	end
end

function drawDXExamTimer()
	 dxDrawText("Exam timer : " ..exam_timer.." S", 1281/1600*screenWidth, 500/900*screenHeight, 1570/1600*screenWidth, 580/900*screenHeight, tocolor(255, 255, 255, 255), 0.80/900*screenHeight, "bankgothic", "left", "center", false, false, true, false, false)
end

function showExamTimer()
	addEventHandler("onClientRender", root, drawDXExamTimer)
end

function hideExamTimer()
	removeEventHandler("onClientRender", root, drawDXExamTimer)
end

addEventHandler("onClientMarkerHit", car_permit_marker, showCarPermitInterface)