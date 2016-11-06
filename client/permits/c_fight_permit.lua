local keyCombination = {}
local stage = 1
local completed = 0
local permit = false
local fight_permit_marker = createMarker(759, 5.8, 1000, "cylinder", 2, 0, 150, 150, 150)
setElementInterior(fight_permit_marker, 5)
local fighting_style = 0

function isInPermit()
	if (permit == true) then
		return true
	else
		return false
	end
end

function playerPressedKey(button, press)
	if (isElement(localPlayer)) then
		if (press) then -- Only output when they press it down
			if (stage == 1 and button == keyCombination[stage]) then
				stage = 2
			elseif(stage == 2 and button == keyCombination[stage]) then
				stage = 3
			elseif(stage == 3 and button == keyCombination[stage]) then
				stage = 1
				generateKeyCombination()
				completed = completed + 1
			end
		end
	end
end
addEventHandler("onClientKey", root, playerPressedKey)



function generateKeyCombination()
	keyCombination[1] = string.lower(string.char(math.random(65, 90)))
	keyCombination[2] = string.lower(string.char(math.random(65, 90)))
	keyCombination[3] = string.lower(string.char(math.random(65, 90)))
end



function drawKeyCombination()
	  dxDrawText(keyCombination[1].." + "..keyCombination[2].." + "..keyCombination[3], 539/1600*screenWidth, 263/900*screenHeight, 1105/1600*screenWidth, 443/900*screenHeight, tocolor(255, 255, 255, 255), 1.00, "bankgothic", "center", "center", false, false, true, false, false)
end

function showKeyCombination()
	local x = math.random(1380, 1394)
	local y = math.random(-35, -20)
	setElementPosition(localPlayer, x, y, 1001)
	setElementInterior(localPlayer, 1)
	generateKeyCombination()
	addEventHandler("onClientRender", root, drawKeyCombination)
	guiGetInputEnabled(true)
	permit = true
	showChat ( false )
	setElementFrozen(localPlayer, true)
	setTimer(function()
		hideKeyCombination()
		for i = 1, table.getn(keyCombination) do
			keyCombination[i] = nil
		end
	end, 10000, 1)
end

addEvent("startExam", true)
addEventHandler("startExam", localPlayer, showKeyCombination)

function hideKeyCombination()
	removeEventHandler("onClientRender", root, drawKeyCombination)
	guiGetInputEnabled(false)
	permit = false
	showChat ( true )
	setGameSpeed(1)
	local theTimer = nil
	outputChatBox("You started executing your moves!")
	theTimer = setTimer(function()
		if (completed > 0) then
			completed = completed - 1
			local rnd = math.random(1, 5)
			if (rnd == 1) then
				setPedAnimation ( localPlayer, "FIGHT_C", "FightC_Spar", -1, true, false, false)
			elseif ( rnd == 2) then
				setPedAnimation ( localPlayer, "FIGHT_C", "FightC_1", -1, false, false, false)
			elseif (rnd == 3) then
				setPedAnimation ( localPlayer, "FIGHT_C", "FightC_3", -1, false, false, false)
			elseif (rnd == 4) then
				setPedAnimation ( localPlayer, "GYMNASIUM", "GYMshadowbox", -1, true, false, false)
			elseif (rnd == 5) then
				setPedAnimation ( localPlayer, "FIGHT_C", "FightC_2", -1, true, false, false)
			end
		else
			setElementFrozen(localPlayer, false)
			setElementPosition(localPlayer, 766, 5.8, 1001)
			setElementInterior(localPlayer, 5)
			calculateSuccesRate()
			setGameSpeed(4)
			setPedAnimation(localPlayer, false)
			killTimer(theTimer)
		end
	end, 3000, 0)
end

function greetingHandler ( message )
    outputChatBox ( "The server says: " .. message )
end
addEvent( "onGreeting", true )
addEventHandler( "onGreeting", localPlayer, greetingHandler )

function passedExam()
	outputChatBox("Congratulations, you passed the exam!")
	outputChatBox("[INFO] Use Aim and Enter key to use your special attack.")
	setElementData(localPlayer, "permit_fight", 1)
	triggerServerEvent("setFightingStyle", localPlayer, fighting_style)
end

function failedExam()
	outputChatBox("Unfortunately you didn't pass the exam, better luck next time!")
end

function calculateSuccesRate()
	local succesRate = (tonumber(getElementData(localPlayer, "stamina")) + tonumber(getElementData(localPlayer, "muscles"))) / 100
	local rnd = math.random(1, 100)
	if (succesRate > (1 + rnd)) then
		passedExam()
	else
		failedExam()
	end
end



function testAnimation()
	setElementFrozen(localPlayer, false)
	setElementPosition(localPlayer, 766, 5.8, 1001)
	setElementInterior(localPlayer, 5)
end

addCommandHandler("fight", testAnimation)


function triggerPermitInterface(hitElement, matchingDimension)
	if not (getWindowDisplayed()) then
		if (isElement(localPlayer) and localPlayer == hitElement) then
			local succesRate = (tonumber(getElementData(localPlayer, "stamina")) + tonumber(getElementData(localPlayer, "muscles"))) / 100
			 GUIEditor.window[1] = guiCreateWindow(0.34, 0.28, 0.32, 0.36, "Fight permit", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.32, 0.14, 0.36, 0.14, "Boxing", true, GUIEditor.window[1])
			GUIEditor.button[2] = guiCreateButton(0.32, 0.31, 0.36, 0.14, "Kung Fu", true, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(0.32, 0.49, 0.36, 0.14, "Muay Thai", true, GUIEditor.window[1])
			GUIEditor.button[4] = guiCreateButton(0.94, 0.10, 0.03, 0.05, "X", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFFF0000")
			GUIEditor.button[5] = guiCreateButton(0.32, 0.66, 0.36, 0.14, "Remove permit", true, GUIEditor.window[1])
			GUIEditor.label[1] = guiCreateLabel(0.74, 0.15, 0.19, 0.10, "5000$", true, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
			GUIEditor.label[2] = guiCreateLabel(0.74, 0.32, 0.19, 0.10, "5000$", true, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
			GUIEditor.label[3] = guiCreateLabel(0.74, 0.52, 0.19, 0.10, "5000$", true, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
			GUIEditor.label[4] = guiCreateLabel(0.74, 0.69, 0.19, 0.10, "0$", true, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
			guiLabelSetVerticalAlign(GUIEditor.label[4], "center")
			GUIEditor.label[5] = guiCreateLabel(0.02, 0.16, 0.29, 0.11, "Succes rate : " ..succesRate.."%", true, GUIEditor.window[1])
			guiLabelSetColor(GUIEditor.label[5], 6, 254, 0)
			guiLabelSetVerticalAlign(GUIEditor.label[5], "center")    
			addEventHandler("onClientGUIClick", GUIEditor.button[1], handleBoxingBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[2], handleKungFuBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[3], handleMuayThaiBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[4], closeFightingPermitInterface, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[5], removeFightingPermitBtn, false)
			showCursor(true)
		end
	end
end

function checkPlayerMoney()
	if (getPlayerMoney() >= 5000) then
		return true
	end
	outputChatBox("You need atleast 5000$ to start your exam!")
	closeFightingPermitInterface()
	return false
end


function handleBoxingBtn(button, state)
	if (button == "left" and state == "up") then
		if (isElement(localPlayer)) then
			if (checkPlayerMoney()) then
				closeFightingPermitInterface()
				triggerServerEvent("payPermit", localPlayer, 5000)
				fighting_style = 5
			end
		end
	end
end

function handleKungFuBtn(button , state)
	if (button == "left" and state == "up") then
		if (isElement(localPlayer)) then
			if (checkPlayerMoney()) then
				closeFightingPermitInterface()
				triggerServerEvent("payPermit", localPlayer, 5000)
				fighting_style = 6
			end
		end
	end
end

function handleMuayThaiBtn(button, state)
	if (button == "left" and state == "up") then
		if (isElement(localPlayer)) then
			if (checkPlayerMoney()) then
				closeFightingPermitInterface()
				triggerServerEvent("payPermit", localPlayer, 5000)
				fighting_style = 7
			end
		end
	end
end

function removeFightingPermitBtn()
	if (button == "left" and state == "up") then
		if (isElement(localPlayer)) then
			closeFightingPermitInterface()
			setElementData(localPlayer, "permit_fight", 0)
			outputChatBox("You left your gym permit in the gym locker...")
			outputChatBox("[INFO] Fighting style is back to default.")
		end
	end
end

function closeFightingPermitInterface()
	if (getWindowDisplayed()) then
		destroyAll()
		showCursor(false)
	end
end

addEventHandler ( "onClientMarkerHit", fight_permit_marker, triggerPermitInterface )
