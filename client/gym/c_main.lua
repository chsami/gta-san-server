
local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)

local moveScreen = {}


--Basicly only used for sound atm

function playSportSound(_, thePlayer, sportType)
	if (thePlayer == getLocalPlayer()) then
		if (sportType == "run") then
			local sound = playSound("conf/sounds/treadmill.mp3", true)
			setSoundVolume(sound, 0.4)
			setSoundSpeed ( sound, 0.7)
			updateSound(thePlayer, sportType, sound)
		end
	end--security
end

--Update the sound depending on how fast the player runs on the treadmill

function updateSound(p, sportType, sound)
	local theTimer = nil
	theTimer = setTimer(function()
		if (isElement(p) and p == getLocalPlayer()) then
			if (getElementData(p, "workout_timer") > 0) then
				local speed = getElementData(p, "speed_running")
				if (speed < 10) then --think about algorithm later...
					setSoundSpeed ( sound, 0.7 )
				elseif (speed >= 10 and speed < 20) then
					setSoundSpeed ( sound, 0.8 )
				elseif (speed >= 20) then
					setSoundSpeed ( sound, 1 )
				end
			else
				killTimer(theTimer)
				stopSportSound(p, sportType, sound)
			end
		end--security
	end, 1000, 0)
end

--Stop the sport sound when player stops exercising


function stopSportSound(p, sportType, sound)
	if (isElement(p) and p == getLocalPlayer()) then
		local counter = 0.4
		setTimer(function() --sound fading
			if (counter > 0) then
				counter = counter - 0.1
				setSoundVolume(sound, counter)
			else
				stopSound ( sound )
			end
		end, 600, 4)
		
	end
end


function fadingText()
	if (source == localPlayer) then
		moveScreen[localPlayer] = {}
		moveScreen[localPlayer][1] = 0
		addEventHandler("onClientRender", root, drawDXLevelup)
		setTimer(function()
			removeEventHandler("onClientRender", root, drawDXLevelup) 
			moveScreen[localPlayer] = nil
		end, 2000, 1)
	end--security
end

function drawDXLevelup()
		local scale = 1.0 /900*screenHeight
		moveScreen[getLocalPlayer()][1] = moveScreen[getLocalPlayer()][1] + 3
		local alpha = 255
		local height = 900*screenHeight
		dxDrawText(getElementData(getLocalPlayer(), "level_up_text"), 633/1600*screenWidth, 258/height+moveScreen[getLocalPlayer()][1], 994/1600*screenWidth, 304/900*screenHeight, tocolor(0, 0, 0, alpha- moveScreen[getLocalPlayer()][1]), scale, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawText(getElementData(getLocalPlayer(), "level_up_text"), 633/1600*screenWidth, 256/height+moveScreen[getLocalPlayer()][1], 994/1600*screenWidth, 302/900*screenHeight, tocolor(0, 0, 0, alpha- moveScreen[getLocalPlayer()][1]), scale, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawText(getElementData(getLocalPlayer(), "level_up_text"), 631/1600*screenWidth, 258/height+moveScreen[getLocalPlayer()][1], 992/1600*screenWidth, 304/900*screenHeight, tocolor(0, 0, 0, alpha- moveScreen[getLocalPlayer()][1]), scale, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawText(getElementData(getLocalPlayer(), "level_up_text"), 631/1600*screenWidth, 256/height+moveScreen[getLocalPlayer()][1], 992/1600*screenWidth, 302/900*screenHeight, tocolor(0, 0, 0, alpha- moveScreen[getLocalPlayer()][1]), scale, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawText(getElementData(getLocalPlayer(), "level_up_text"), 632/1600*screenWidth, 257/height+moveScreen[getLocalPlayer()][1], 993/1600*screenWidth, 303/900*screenHeight, tocolor(0, 252, 0, alpha- moveScreen[getLocalPlayer()][1]), scale, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawText(getElementData(getLocalPlayer(), "level_up_text"), 632/1600*screenWidth, 257/height+moveScreen[getLocalPlayer()][1], 993/1600*screenWidth, 303/900*screenHeight, tocolor(0, 252, 0, alpha- moveScreen[getLocalPlayer()][1]), scale, "bankgothic", "center", "center", false, false, true, false, false)
end

addEvent("fadingText", true)
addEventHandler("fadingText", localPlayer, fadingText)

addEvent("playSportSound", true)
addEventHandler("playSportSound", localPlayer, playSportSound)