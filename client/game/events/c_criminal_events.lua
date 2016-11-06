
local old_woman = nil
local blip = nil
local fade = 255

function startCriminalEvent()
	if (source == localPlayer) then
		outputChatBox("Kill old woman!")
		old_woman = createPed(10, 1214.65, -1292, 13.6)
		setElementRotation(old_woman, 0, 0, 180)
		local theTimer = nil
		local x, y , z = nil
		local turn = {}
		for i = 1, 4 do
			turn[i] = false
		end
		theTimer = setTimer(function()
			if (isElement(old_woman)) then
				if (isLoggedIn()) then
					x, y , z = getElementPosition(old_woman)
					if (y < -1385 and x < 1330 and turn[1] == false) then
						setElementPosition(old_woman, x, y , z)
						setElementRotation(old_woman, 0, 0, 0)
						setPedAnimation(old_woman, "PED", "WALK_old", -1, true, true, false, true)
						turn[1] = true
						turn[2] = false
					elseif (y > -1290 and turn[2] == false) then
						setElementPosition(old_woman, x, y , z)
						setElementRotation(old_woman, 0, 0, -90)
						setPedAnimation(old_woman, "PED", "WALK_old", -1, true, true, false, true)
						turn[2] = true
						turn[3] = false
					elseif (x > 1333 and turn[3] == false) then
						setElementPosition(old_woman, x, y , z)
						setElementRotation(old_woman, 0, 0, -180)
						setPedAnimation(old_woman, "PED", "WALK_old", -1, true, true, false, true)
						turn[3] = true
						turn[4] = false
					elseif ((y < -1385 and y < -1390) and x < 1330 and turn[4] == false) then
						setElementPosition(old_woman, x, y , z)
						setElementRotation(old_woman, 0, 0, -270)
						setPedAnimation(old_woman, "PED", "WALK_old", -1, true, true, false, true)
						turn[4] = true
						turn[1] = false
						setElementPosition(old_woman, 1214.65, -1292, 13.6)
					end
				elseif (isTimer(theTimer)) then 
					killTimer(theTimer)
					destroyCriminalEvent()
				end
			else
				if (isTimer(theTimer)) then killTimer(theTimer) end
			end
		end, 500, 0)
		setPedAnimation(old_woman, "PED", "WALK_old", -1, true, true, false, true)
		blip = createBlipAttachedTo ( old_woman, 23, 2, 255, 0, 0)
		addEventHandler("onClientPedWasted", old_woman, handleEventCompleted) --Add the Event when ped1 dies
	end
end

addEvent("criminalEvent", true)
addEventHandler("criminalEvent", localPlayer, startCriminalEvent)


function handleEventCompleted(killer, killerWeapon)
	if (isElement(killer) and isLoggedIn()) then
		outputChatBox("woman died!")
		setPedAnimation(old_woman, false)
		setTimer(function()
			destroyCriminalEvent()
		end, 2000, 1)
		showDXEventCompleted()
		triggerServerEvent("criminalEventCompleted", localPlayer)
	end
end


function destroyCriminalEvent()
	if (isElement(old_woman) and isElement(blip) ) then
		removeEventHandler("onClientPedWasted", old_woman, handleEventCompleted)
		destroyElement(old_woman)
		destroyElement(blip)
	end
end

function drawDXEventCompleted()
	if (isLoggedIn()) then
		if (fade > 0) then
			fade = fade - 2
			dxDrawText("Task Completed : $300", 473/1600*screenWidth, 328/900*screenHeight, 1139/1600*screenWidth, 459/900*screenHeight, tocolor(254, 215, 0, fade), 1.50/900*screenHeight, "pricedown", "center", "center", false, false, true, false, false)
		else
			hideDXEventCompleted()
		end
	else
		hideDXEventCompleted()
	end
end
	
	
function showDXEventCompleted()
	fade = 255
	addEventHandler("onClientRender", root, drawDXEventCompleted)
end

function hideDXEventCompleted()
	removeEventHandler("onClientRender", root, drawDXEventCompleted)
end