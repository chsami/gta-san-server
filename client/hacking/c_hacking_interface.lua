local HACKING_TIMER = 20 --20 seconds
local WAIT_FOR_NEW_HACK_TIMER = 60 -- 60 seconds

function createHackingGui()
	if (source == localPlayer) then
		if not (getWindowDisplayed()) then
			if (getElementData(getLocalPlayer(), "tempHackingTimer") <= 0) then
			GUIEditor.window[1] = guiCreateWindow(0.38, 0.10, 0.22, 0.43, "ATM HACKING", true)
			guiWindowSetSizable(GUIEditor.window[1], false)

			GUIEditor.button[1] = guiCreateButton(0.16, 0.24, 0.05, 0.04, "+", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF00FD11")
			GUIEditor.button[2] = guiCreateButton(0.16, 0.38, 0.05, 0.04, "-", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FFFE0000")
			GUIEditor.edit[1] = guiCreateEdit(0.13, 0.31, 0.09, 0.05, "1", true, GUIEditor.window[1])
			GUIEditor.button[3] = guiCreateButton(0.27, 0.24, 0.05, 0.04, "+", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FF00FD11")
			GUIEditor.edit[2] = guiCreateEdit(0.25, 0.31, 0.09, 0.05, "2", true, GUIEditor.window[1])
			GUIEditor.button[4] = guiCreateButton(0.27, 0.38, 0.05, 0.04, "-", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFFE0000")
			GUIEditor.button[5] = guiCreateButton(0.37, 0.24, 0.05, 0.04, "+", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FF00FD11")
			GUIEditor.edit[3] = guiCreateEdit(0.36, 0.31, 0.09, 0.05, "3", true, GUIEditor.window[1])
			GUIEditor.button[6] = guiCreateButton(0.37, 0.38, 0.05, 0.04, "-", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFFE0000")
			GUIEditor.edit[4] = guiCreateEdit(0.48, 0.31, 0.09, 0.05, "4", true, GUIEditor.window[1])
			GUIEditor.edit[5] = guiCreateEdit(0.60, 0.31, 0.09, 0.05, "5", true, GUIEditor.window[1])
			GUIEditor.edit[6] = guiCreateEdit(0.71, 0.31, 0.09, 0.05, "6", true, GUIEditor.window[1])
			GUIEditor.edit[7] = guiCreateEdit(0.82, 0.31, 0.09, 0.05, "7", true, GUIEditor.window[1])
			GUIEditor.button[7] = guiCreateButton(0.49, 0.24, 0.05, 0.04, "+", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[7], "NormalTextColour", "FF00FD11")
			GUIEditor.button[8] = guiCreateButton(0.49, 0.38, 0.05, 0.04, "-", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[8], "NormalTextColour", "FFFE0000")
			GUIEditor.button[9] = guiCreateButton(0.61, 0.24, 0.05, 0.04, "+", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[9], "NormalTextColour", "FF00FD11")
			GUIEditor.button[10] = guiCreateButton(0.61, 0.38, 0.05, 0.04, "-", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[10], "NormalTextColour", "FFFE0000")
			GUIEditor.button[11] = guiCreateButton(0.73, 0.24, 0.05, 0.04, "+", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[11], "NormalTextColour", "FF00FD11")
			GUIEditor.button[12] = guiCreateButton(0.73, 0.38, 0.05, 0.04, "-", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[12], "NormalTextColour", "FFFE0000")
			GUIEditor.button[13] = guiCreateButton(0.83, 0.24, 0.05, 0.04, "+", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[13], "NormalTextColour", "FF00FE35")
			GUIEditor.button[14] = guiCreateButton(0.83, 0.38, 0.05, 0.04, "-", true, GUIEditor.window[1])
			guiSetProperty(GUIEditor.button[14], "NormalTextColour", "FFFE0000")
			GUIEditor.button[15] = guiCreateButton(0.13, 0.78, 0.25, 0.09, "HACK", true, GUIEditor.window[1])
			GUIEditor.button[16] = guiCreateButton(0.57, 0.78, 0.25, 0.09, "CLOSE", true, GUIEditor.window[1])
			
			for i = 1, 7, 1 do
				guiEditSetReadOnly ( GUIEditor.edit[i], true )
			end
			
			addEventHandler ( "onClientGUIClick", GUIEditor.button[1], increaseSlot_1 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[3], increaseSlot_2 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[5], increaseSlot_3 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[7], increaseSlot_4 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[9], increaseSlot_5 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[11], increaseSlot_6 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[13], increaseSlot_7 )
			
			addEventHandler ( "onClientGUIClick", GUIEditor.button[2], decreaseSlot_1 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[4], decreaseSlot_2 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[6], decreaseSlot_3 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[8], decreaseSlot_4 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[10], decreaseSlot_5 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[12], decreaseSlot_6 )
			addEventHandler ( "onClientGUIClick", GUIEditor.button[14], decreaseSlot_7 )
			
			addEventHandler("onClientGUIClick", GUIEditor.button[15], handleHackBtn, false)
			addEventHandler("onClientGUIClick", GUIEditor.button[16], handleHackCloseBtn, false)
			
			guiSetInputEnabled(true)
			showCursor(true)
			
			startTimer(getLocalPlayer())
			
			setElementFrozen(getLocalPlayer(), true)
			
			else
				outputChatBox("The ATM is rebooting...you must wait another " .. getElementData(getLocalPlayer(), "tempHackingTimer") .. " seconds before you can hack again", getLocalPlayer(), 255, 0, 0)
			end
		end
	end --security
end



function handleHackCloseBtn()
	if (getWindowDisplayed()) then
		destroyAll()--destroy everything in the interface
		guiSetInputEnabled(false)
		showCursor(false)
		removeEventHandler("onClientRender", root, createDXHackingGui)
		setElementFrozen(getLocalPlayer(), false)
	end
end

function handleHackBtn()
	local pin_1 = tonumber(guiGetText(GUIEditor.edit[1]))
	local pin_2 = tonumber(guiGetText(GUIEditor.edit[2]))
	local pin_3 = tonumber(guiGetText(GUIEditor.edit[3]))
	local pin_4 = tonumber(guiGetText(GUIEditor.edit[4]))
	local pin_5 = tonumber(guiGetText(GUIEditor.edit[5]))
	local pin_6 = tonumber(guiGetText(GUIEditor.edit[6]))
	local pin_7 = tonumber(guiGetText(GUIEditor.edit[7]))
	if (getElementData(getLocalPlayer(), "tempPin")) then
		local tempTable = getElementData(getLocalPlayer(), "tempPin")
		if (pin_1 == tempTable[1] and pin_2 == tempTable[2] and pin_3 == tempTable[3] and pin_4 == tempTable[4] and pin_5 == tempTable[5] and pin_6 == tempTable[6] and pin_7 == tempTable[7]) then
			local timeLeft = getElementData(getLocalPlayer(), "tempHackingTimer")
			outputChatBox("Congratulations you succesfully hacked the ATM with " .. timeLeft .. " seconds time left!")
			stopHacking()
			triggerServerEvent("succesHack", getLocalPlayer(), timeLeft)
			playSFX("script", 145, 0, false)
		else
			outputChatBox("You failed to hack the ATM!")
			stopHacking()
			playSFX("script", 146, 2, false)
		end
	end
end


function increaseSlot_1(button, state)
	local guiElement = GUIEditor.edit[1]
	local text = guiGetText(guiElement)
	text = tonumber(text) + 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function increaseSlot_2(button, state)
	local guiElement = GUIEditor.edit[2]
	local text = guiGetText(guiElement)
	text = tonumber(text) + 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function increaseSlot_3(button, state)
	local guiElement = GUIEditor.edit[3]
	local text = guiGetText(guiElement)
	text = tonumber(text) + 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function increaseSlot_4(button, state)
	local guiElement = GUIEditor.edit[4]
	local text = guiGetText(guiElement)
	text = tonumber(text) + 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end


function increaseSlot_5(button, state)
	local guiElement = GUIEditor.edit[5]
	local text = guiGetText(guiElement)
	text = tonumber(text) + 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function increaseSlot_6(button, state)
	local guiElement = GUIEditor.edit[6]
	local text = guiGetText(guiElement)
	text = tonumber(text) + 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function increaseSlot_7(button, state)
	local guiElement = GUIEditor.edit[7]
	local text = guiGetText(guiElement)
	text = tonumber(text) + 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function decreaseSlot_1(button, state)
	local guiElement = GUIEditor.edit[1]
	local text = guiGetText(guiElement)
	text = tonumber(text) - 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function decreaseSlot_2(button, state)
	local guiElement = GUIEditor.edit[2]
	local text = guiGetText(guiElement)
	text = tonumber(text) - 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function decreaseSlot_3(button, state)
	local guiElement = GUIEditor.edit[3]
	local text = guiGetText(guiElement)
	text = tonumber(text) - 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function decreaseSlot_4(button, state)
	local guiElement = GUIEditor.edit[4]
	local text = guiGetText(guiElement)
	text = tonumber(text) - 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function decreaseSlot_5(button, state)
	local guiElement = GUIEditor.edit[5]
	local text = guiGetText(guiElement)
	text = tonumber(text) - 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function decreaseSlot_6(button, state)
	local guiElement = GUIEditor.edit[6]
	local text = guiGetText(guiElement)
	text = tonumber(text) - 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end


function decreaseSlot_7(button, state)
	local guiElement = GUIEditor.edit[7]
	local text = guiGetText(guiElement)
	text = tonumber(text) - 1
	if (tonumber(text) < 0) then
		text = 0
	elseif (tonumber(text) > 9) then
		text = 9
	end
	guiSetText(guiElement, tostring(text))
end

function generatePin() --will generate the correct pincode to hack the bank OR NVM
	local pins = {1, 2, 3, 4, 5, 6, 7}
	for i, value in ipairs(pins) do
		pins[i] = math.random(1, 9)
	end
	return pins
end

function stopHacking() --when the timer is over this method will be used
	handleHackCloseBtn()
	setElementData(getLocalPlayer(), "tempHackingTimer", 0)
end

function startTimer(thePlayer)
	handleMainTick(HACKING_TIMER, thePlayer)
	generatePin()
	addEventHandler("onClientRender", getRootElement(), createDXHackingGui)
end

function handleMainTick(tick, thePlayer)
	if (thePlayer == getLocalPlayer()) then
		local timerStarted = false
		local timer = tick
		local pinTable = generatePin()
		local tickTimer = HACKING_TIMER + 1
		setElementData(getLocalPlayer(), "tempPin", pinTable)
		if (timerStarted == false) then
			local ticker = setTimer(function()
					if (timer > 0) then
						timer = timer - 1
						setElementData(getLocalPlayer(), "tempHackingTimer", timer)
					elseif (timer <= 0) then
						stopHacking()
					end
			end, 1000, tickTimer)
		end
	end --security (just to be sure)
end


function createDXHackingGui()
	local confusing = math.random(580, 630)
	if (getElementData(getLocalPlayer(), "tempHackingTimer")) then
		dxDrawText("TIMER : " ..getElementData(getLocalPlayer(), "tempHackingTimer").." seconds", 612/1600*screenWidth, 287/900*screenHeight, 942/1600*screenWidth, 309/900*screenHeight, tocolor(255, 255, 255, 255), 0.70/900*screenHeight, "bankgothic", "center", "center", false, false, true, false, false)
		if (getElementData(getLocalPlayer(), "tempPin")) then
			local tempTable = getElementData(getLocalPlayer(), "tempPin")
			local drawPincode = " " .. tempTable[1] .. "-" ..tempTable[2].. "-" ..tempTable[3].. "-" ..tempTable[4].. "-" ..tempTable[5].. "-" ..tempTable[6].. "-" ..tempTable[7]
			dxDrawText(drawPincode, confusing/1600*screenWidth, 126/900*screenHeight, 947/1600*screenWidth, 164/900*screenHeight, tocolor(0, 0, 0, math.random(1, 255)), 1.00, "sans", "center", "center", false, false, true, false, false)
			dxDrawText(drawPincode, confusing/1600*screenWidth, 124/900*screenHeight, 947/1600*screenWidth, 162/900*screenHeight, tocolor(0, 0, 0, math.random(1, 255)), 1.00, "sans", "center", "center", false, false, true, false, false)
			dxDrawText(drawPincode, confusing/1600*screenWidth, 126/900*screenHeight, 945/1600*screenWidth, 164/900*screenHeight, tocolor(0, 0, 0, math.random(1, 255)), 1.00, "sans", "center", "center", false, false, true, false, false)
			dxDrawText(drawPincode, confusing/1600*screenWidth, 124/900*screenHeight, 945/1600*screenWidth, 162/900*screenHeight, tocolor(0, 0, 0, math.random(1, 255)), 1.00, "sans", "center", "center", false, false, true, false, false)
			dxDrawText(drawPincode, confusing/1600*screenWidth, 125/900*screenHeight, 946/1600*screenWidth, 163/900*screenHeight, tocolor(255, 255, 255, math.random(1, 255)), 1.00, "sans", "center", "center", false, false, true, false, false)
		end
	end
end


--CUSTOM EVENTS--

addEvent("drawHackingInterface", true)
addEventHandler("drawHackingInterface", localPlayer, createHackingGui)
