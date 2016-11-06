local run_marker = createMarker(770, -0.2, 1000, "cylinder", 1, 255, 0, 0, 150)
local spinning_marker = createMarker(772, 12, 1000, "cylinder", 1, 255, 0, 0, 150)
local dumbell_marker = createMarker(773, 5.4, 1000, "cylinder", 1, 255, 0, 0, 150)
local boxing_marker = createMarker(765, -4.5, 1000, "cylinder", 1, 255, 0, 0, 150)
local leaving_marker = createMarker(772.5, -4.2, 1001.5, "arrow", 1, 255, 0, 0, 150)
setElementInterior(run_marker, 5)
setElementInterior(spinning_marker, 5)
setElementInterior(dumbell_marker, 5)
setElementInterior(boxing_marker, 5)
setElementInterior(leaving_marker, 5)

local left_dumbell_example = createObject(3071, 772, 5.04, 1000)
local right_dumbell_example = createObject(3072, 772, 5.5, 1000)
setElementInterior(left_dumbell_example, 5)
setElementInterior(right_dumbell_example, 5)

local performing_task = {}
local myTextItem = {}
local myTextDisplay = {}
local oxygen = "oxygen"
local workoutTimer = "workout_timer"
local MAX_SPEED_RUNNING = 25
local sportSetup = {}
local dimensions = 1

local real_dumbell = {}

--CONCLUSION : Multiple players cannot execute an action at the same position, use different dimension when players enter the sports equipment
--Dumbells need to be client sided so every player has their own objects :) - yey working

function initSportData()
	sportSetup["run"] = {}
	sportSetup["spinning"] = {}
	sportSetup["dumbell"] = {}
	sportSetup["boxing"] = {}
	local lookX = 1
	local lookY = 2
	local startX = 3
	local startY = 4
	local animation_getOn = 5
	local animation_getOff = 6
	local animation_slow = 7
	local animation_medium = 8
	local animation_fast = 9
	local animation_celeb = 10
	local animation_idle = 11
	local animation_down = 12
	local anim_block = 13
	sportSetup["run"][lookX] = 770
	sportSetup["run"][lookY] = -11
	sportSetup["run"][startX] = 773.5
	sportSetup["run"][startY] = -0.5
	sportSetup["run"][animation_getOn] = "gym_tread_geton"
	sportSetup["run"][animation_getOff] = "gym_walk_falloff"
	sportSetup["run"][animation_slow] = "gym_tread_walk"
	sportSetup["run"][animation_medium] = "gym_tread_jog"
	sportSetup["run"][animation_fast] = "gym_tread_sprint"
	sportSetup["run"][animation_celeb] = ""
	sportSetup["run"][anim_block] = "GYMNASIUM"
	--Spinning data
	sportSetup["spinning"][lookX] = 600
	sportSetup["spinning"][lookY] = -9
	sportSetup["spinning"][startX] = 772.7
	sportSetup["spinning"][startY] = 8.9
	sportSetup["spinning"][animation_getOn] = "gym_bike_geton"
	sportSetup["spinning"][animation_getOff] = "gym_bike_getoff"
	sportSetup["spinning"][animation_slow] = "gym_bike_pedal"
	sportSetup["spinning"][animation_medium] = "gym_bike_slow"
	sportSetup["spinning"][animation_fast] = "gym_bike_faster"
	sportSetup["spinning"][animation_celeb] = "gym_bike_celebrate"
	sportSetup["spinning"][anim_block] = "GYMNASIUM"
	--freeWeight data
	sportSetup["dumbell"][lookX] = 600
	sportSetup["dumbell"][lookY] = -9
	sportSetup["dumbell"][startX] = 772.9
	sportSetup["dumbell"][startY] = 5.36
	sportSetup["dumbell"][animation_getOn] = "gym_free_pickup"
	sportSetup["dumbell"][animation_getOff] = "gym_free_putdown"
	sportSetup["dumbell"][animation_slow] = "gym_free_B"
	sportSetup["dumbell"][animation_medium] = "gym_free_A"
	sportSetup["dumbell"][animation_fast] = "gym_free_up_smooth"
	sportSetup["dumbell"][animation_idle] = "IDLE_tired"
	sportSetup["dumbell"][animation_down] = "gym_free_down"
	sportSetup["dumbell"][anim_block] = "FREEWEIGHTS"
	--boxing
	sportSetup["boxing"][lookX] = 767
	sportSetup["boxing"][lookY] = -5.2
	sportSetup["boxing"][startX] = 765.7
	sportSetup["boxing"][startY] = -3
	sportSetup["boxing"][animation_getOn] = "GYMshadowbox"
	sportSetup["boxing"][animation_getOff] = "GYMshadowbox"
	sportSetup["boxing"][animation_slow] = "GYMshadowbox"
	sportSetup["boxing"][animation_medium] = "GYMshadowbox"
	sportSetup["boxing"][animation_fast] = "GYMshadowbox"
	sportSetup["boxing"][anim_block] = "GYMNASIUM"
end


function testAnimation(p, commandName)
	if (isElement(p)) then
			setPedAnimation ( p, "ped", "getup", -1, false, false, false)
	end
end

addCommandHandler("testanimation", testAnimation)


-- TODO :  Cleanup double code

function increaseStaminaOrStrength(p, averageSpeed, timeSported, reps, sportType) --increase either stamina or strength
	if (isElement(p)) then
		local stamina = getElementData(p, "stamina") or 0--saving data
		local muscles = getElementData(p, "muscles") or 0--saving data
		local addStamina = (averageSpeed + timeSported)
		local addMuscles = (reps + timeSported)
		if (sportType == "run") then
			if (getElementData(p, "stamina") < 5000) then
				if (stamina + addStamina < 5000) then
					stamina = stamina + addStamina
					outputChatBox("Your stamina has been increased to : " ..tostring(getElementData(p, "stamina")), p)
					triggerClientEvent("specialAchievement", p, setSpecialAchievement, getElementData(p, "stamina"), stamina, 1000, "Marathon", 1000)
					setElementData(p, "stamina", stamina)
					setElementData(p, "level_up_text", "Stamina +"..addStamina)
				else
					setElementData(p, "stamina", 5000)
					outputChatBox("Congratulations you have reached the maximum stamina!", p)
					setElementData(p, "level_up_text", "MAXIMUM STAMINA")
					triggerClientEvent("normalAchievement", p, setNormalAchievement, "8 Lungs", 5000)
				end
			else
				setElementData(p, "level_up_text", "MAXIMUM STAMINA")
				outputChatBox("You can't get any stronger!", p)
			end
		elseif (sportType == "spinning") then
			if (getElementData(p, "stamina") < 5000) then
				if (stamina + addStamina < 5000) then
					stamina = stamina + addStamina
					outputChatBox("Your stamina has been increased to : " ..tostring(getElementData(p, "stamina")), p)
					triggerClientEvent("specialAchievement", p, setSpecialAchievement, getElementData(p, "stamina"), stamina, 1000, "Marathon", 1000)
					setElementData(p, "stamina", stamina)
					setElementData(p, "level_up_text", "MAXIMUM STAMINA")
					setElementData(p, "level_up_text", "Stamina +"..addStamina)
				else
					setElementData(p, "stamina", 5000)
					outputChatBox("Congratulations you have reached the maximum stamina!", p)
					setElementData(p, "level_up_text", "MAXIMUM STAMINA")
					triggerClientEvent("normalAchievement", p, setNormalAchievement, "8 Lungs", 5000)
				end
			else
				setElementData(p, "level_up_text", "MAXIMUM STAMINA")
				outputChatBox("You can't get any stronger!", p)
			end
		elseif (sportType == "dumbell") then	
			if (getElementData(p, "muscles") < 5000) then
				if (muscles + addMuscles < 5000) then
					muscles = muscles + addMuscles
					outputChatBox("Your strenght has been increased to : " ..tostring(getElementData(p, "muscles")), p)
					triggerClientEvent("specialAchievement", p, setSpecialAchievement, getElementData(p, "muscles"), muscles, 1000, "Strongman", 1000)
					setElementData(p, "muscles", muscles)
					setElementData(p, "level_up_text", "Strength +"..addMuscles)
				else
					setElementData(p, "muscles", 5000)
					outputChatBox("Congratulations you have reached the maximum strength level!", p)
					setElementData(p, "level_up_text", "MAXIMUM STRENGTH")
					triggerClientEvent("normalAchievement", p, setNormalAchievement, "The Hulk", 5000)
				end
			else
				setElementData(p, "level_up_text", "MAXIMUM STRENGTH")
				outputChatBox("You can't get any stronger!", p)
			end
		elseif (sportType == "boxing") then
			if (getElementData(p, "muscles") < 5000) then
				if (muscles + addMuscles < 5000) then
					muscles = muscles + addMuscles
					outputChatBox("Your strenght has been increased to : " ..tostring(getElementData(p, "muscles")), p)
					triggerClientEvent("specialAchievement", p, setSpecialAchievement, getElementData(p, "muscles"), muscles, 500, "Strongman", 1000)
					setElementData(p, "muscles", muscles)
					setElementData(p, "level_up_text", "Strength +"..addMuscles)
				else
					setElementData(p, "muscles", 5000)
					outputChatBox("Congratulations you have reached the maximum strength level!", p)
					setElementData(p, "level_up_text", "MAXIMUM STRENGTH")
					triggerClientEvent("normalAchievement", p, setNormalAchievement, "The Hulk", 5000)
				end
			else
				setElementData(p, "level_up_text", "MAXIMUM STRENGTH")
				outputChatBox("You can't get any stronger!", p)
			end
		end
		triggerClientEvent("fadingText", p, fadingText)
	end
end

function calcAverageIntensityWorkout(p)
	if (isElement(p)) then
		local total_speed = 0
		for i=1, getElementData(p, workoutTimer) , 1 do
				total_speed = (getElementData(p, "total_speed") + speed)
		end
		setElementData(p, "total_speed", total_speed)
		local averageSpeed = round(getElementData(p, "total_speed") / getElementData(p, workoutTimer), 0)
		setElementData(p, "average_speed", averageSpeed)
	end
end


function increaseWorkoutTime(p)
	if (isElement(p)) then
		local counter = getElementData(p, workoutTimer) 
		local speed = getElementData(p, "speed_running")
		counter = counter + 1
		setElementData(p, workoutTimer, counter)
	end
end

function canSport(p)
	if (isElement(p)) then
		local oxygen_level = getElementData(p, oxygen) or 100
		if (oxygen_level > 0) then
			return true
		else
			outputChatBox("You are to exhausted to workout!", p)
			return false
		end
	end
end

function onRunMarkerHit(hitElement)
	if (isElement(hitElement)) then
		local sourceAccount = getPlayerAccount ( hitElement )
		if (sourceAccount) then
			if not (isGuestAccount ( sourceAccount )) then
				rotatePlayerRightWay(hitElement, "run")
				setPedAnimation ( hitElement, "GYMNASIUM", sportSetup["run"][5], -1, false, false, false)
				setTimer(function()
					startGymProcess(hitElement, "run")
				end, 2000, 1)
			end
		end
	end
end

function onSpinningMarkerHit(hitElement)
	if (isElement(hitElement)) then
		local sourceAccount = getPlayerAccount ( hitElement )
		if (sourceAccount) then
			if not (isGuestAccount ( sourceAccount )) then
				rotatePlayerRightWay(hitElement, "spinning")
				setPedAnimation ( hitElement, "GYMNASIUM", sportSetup["spinning"][5], -1, false, false, false)
				setTimer(function()
					startGymProcess(hitElement, "spinning")
				end, 2000, 1)
			end
		end
	end
end

function onDumbellMarkerHit(hitElement)
	if (isElement(hitElement)) then
		local sourceAccount = getPlayerAccount ( hitElement )
		if (sourceAccount) then
			if not (isGuestAccount ( sourceAccount )) then
				rotatePlayerRightWay(hitElement, "dumbell")
				setPedAnimation ( hitElement, "FREEWEIGHTS", sportSetup["dumbell"][5], -1, false, false, false)
				setTimer(function()
					startGymProcess(hitElement, "dumbell")
				end, 2000, 1)
			end
		end
	end
end

function onBoxingMarkerHit(hitElement)
	if (isElement(hitElement)) then
		local sourceAccount = getPlayerAccount ( hitElement )
		if (sourceAccount) then
			if not (isGuestAccount ( sourceAccount )) then
				rotatePlayerRightWay(hitElement, "boxing")
				setPedAnimation ( hitElement, "FREEWEIGHTS", sportSetup["dumbell"][5], -1, false, false, false)
				setTimer(function()
					startGymProcess(hitElement, "boxing")
				end, 2000, 1)
			end
		end
	end
end

function onLeavingMarkerHit(hitElement)
	if (isElement(hitElement)) then
		local sourceAccount = getPlayerAccount ( hitElement )
		if (sourceAccount) then
			if not (isGuestAccount ( sourceAccount )) then
				setElementPosition(hitElement, 2228, -1726, 13.5)
				setElementInterior(hitElement, 0)
				setElementDimension(hitElement, 0)
				deleteTextItem(hitElement)
			end
		end
	end
end

function setCinemaView(p, sportType)
	if (isElement(p)) then
		local x, y, z = getElementPosition(p)
		y = y +3
		z = z + 1
		setCameraMatrix ( p, x, y, z, sportSetup["run"][1], sportSetup["run"][2],z, 0, 100, 0 , 70)
	end
end

function startLiftingProcess(p, sportType)
	if (isElement(p)) then
		performing_task[p] = {}
		performing_task[p][1] = "true"
		setCinemaView(p, sportType)
		
	end
end

function startGymProcess(p, sportType)-- start the gym process for the player
	if (isElement(p)) then
		local dimension = getElementDimension(p)
		real_dumbell[p] = {}
		real_dumbell[p][1] = createObject(3071, 772, 5.04, 1000)
		real_dumbell[p][2] = createObject(3072, 772, 5.5, 1000)
		setElementInterior(real_dumbell[p][1], 5)
		setElementInterior(real_dumbell[p][2], 5)
		setElementDimension(real_dumbell[p][1], dimension)
		setElementDimension(real_dumbell[p][2], dimension)
		if (sportType == "dumbell") then
			exports.bone_attach:attachElementToBone(real_dumbell[p][1],p,11,0,0,0,100,10,10)
			exports.bone_attach:attachElementToBone(real_dumbell[p][2],p,12,0,0,0,100,10,10)
		end
		setElementFrozen(p, true)
		local oxygen_level = getElementData(p, oxygen) or 100
		performing_task[p] = {}
		performing_task[p][1] = "true"
		setCinemaView(p, sportType)
		calcTired(p, sportType)
		handleAnimation(p, sportType)
		bindKey(p, "m", "up", stopGymProcess) 
		bindKey(p, "r", "up", accelerate)
		addTextItem(p, "Oxygen level : " ..tostring(oxygen_level).."%\nPress 'm' to stop exercising")
		triggerClientEvent("playSportSound", getRootElement(), playSportSound, p, sportType)
	end
end

function accelerate(p) --when player press "r" he accelerate
	if (isElement(p) and performing_task[p][1] == "true") then
		if (getElementData(p, "speed_running") <= MAX_SPEED_RUNNING) then
			local speed = getElementData(p, "speed_running") or 0
			local rnd = 100 - tonumber(getElementData(p, oxygen))
			if (rnd < 2) then
				speed = speed + 1
				setElementData(p, "speed_running", speed)
			elseif (math.random(1, rnd)  < 30) then
				speed = speed + 1
				setElementData(p, "speed_running", speed)
			end
		end
	end
end

function rotatePlayerRightWay(p, sportType) --set player on the treadmill
	if (isElement(p)) then
		local x, y , z = getElementPosition(p)
		local rot = math.atan2(tonumber(sportSetup[sportType][2]) - y, tonumber(sportSetup[sportType][1]) - x) * 180 / math.pi
		rot = rot-90
		setElementDimension(p, dimensions)
		dimensions = dimensions + 1
		setPedRotation(p, rot)
		local rotX = tonumber(sportSetup[sportType][1]) - x
		local rotY = tonumber(sportSetup[sportType][2]) - y
		setElementPosition ( p, tonumber(sportSetup[sportType][3]), tonumber(sportSetup[sportType][4]), 1000.9 )
	end
end

function increaseReps(p)
	if (isElement(p)) then
		local counter = getElementData(p, "reps")
		counter =  counter + 1
		setElementData(p, "reps", counter)
	end
end

function handleAnimation(p, sportType) --appropriate animation
	if (isElement(p)) then
		local oxygen_level = getElementData(p, oxygen) or 100
		if (sportType == "dumbell") then
			if (getElementData(p, workoutTimer) % 6 == 0) then
				if (oxygen_level > 50) then
					increaseReps(p)
					setPedAnimation ( p, "FREEWEIGHTS", tostring(sportSetup[sportType][9]), -1, false, false, false)
					setTimer(function() setPedAnimation ( p, "freeWeights", tostring(sportSetup[sportType][12]), -1, false, false, false) end, 800, 1)
				elseif (oxygen_level <= 50) then
					increaseReps(p)
					setPedAnimation ( p, "FREEWEIGHTS", tostring(sportSetup[sportType][8]), -1, false, false, false)
					setTimer(function() setPedAnimation ( p, "ped", tostring(sportSetup[sportType][11]), -1, false, false, false) end, 1500, 1)
				else
					setPedAnimation ( p, "FREEWEIGHTS", tostring(sportSetup[sportType][6]), -1, false, false, false)
					setTimer(function()
						stopGymProcess(p, sportType)
					end, 3000, 1)
				end
			end
		else
			if (((oxygen_level > 30 and oxygen_level < 50) or (getElementData(p, "speed_running") > 10 and getElementData(p, "speed_running") < 15)) and getElementData(p, "doing_animation") ~= tostring(sportSetup[sportType][8])) then
				setPedAnimation ( p, "GYMNASIUM", tostring(sportSetup[sportType][8]), -1, true, false, false)
				setElementData(p, "doing_animation",  tostring(sportSetup[sportType][8]))
			elseif (((oxygen_level < 30 and oxygen_level > 0) or (getElementData(p, "speed_running") < 10)) and getElementData(p, "doing_animation") ~= tostring(sportSetup[sportType][7]) ) then
				setPedAnimation ( p, "GYMNASIUM", tostring(sportSetup[sportType][7]), -1, true, false, false)
				setElementData(p, "doing_animation",  tostring(sportSetup[sportType][7]))
			elseif (oxygen_level <= 0) then
				setPedAnimation ( p, "GYMNASIUM", tostring(sportSetup[sportType][6]), -1, false, false, false)
				setTimer(function()
					stopGymProcess(p, sportType)
				end, 3000, 1)
				outputChatBox("You are exhausted!", p)
			elseif (getElementData(p, "doing_animation") ~= tostring(sportSetup[sportType][9]) and getElementData(p, "speed_running") > 20) then
				setPedAnimation ( p, "GYMNASIUM", tostring(sportSetup[sportType][9]), -1, true, false, false)
				setElementData(p, "doing_animation",  tostring(sportSetup[sportType][9]))
			end
		end
	end
end

function decelerate(p) --slow down the speed
	if (isElement(p)) then
		speed = getElementData(p, "speed_running") or 0
		if (speed > 0) then
			speed = speed - 1
			setElementData(p, "speed_running", speed)
		end
	end
end

function increaseTired(p, tired, sportType)
	if (isElement(p)) then
		if (math.random(1, 5) == 2) then
			tired = tired - 1
			setElementData(p, oxygen, tired)
		end
	end
end

function updateTextItem(p, sportType)
	if (isElement(p)) then
		if (sportType == "dumbell") then
			textItemSetText(myTextItem[p][1], "Oxygen level: " ..tostring(getElementData(p, oxygen)).."%\nPress 'm' to stop exercising\nReps : "..tostring(getElementData(p, "reps")))
		elseif (sportType == "boxing") then
			textItemSetText(myTextItem[p][1], "Oxygen level: " ..tostring(getElementData(p, oxygen)).."%\nPress 'm' to stop exercising")
		else
			textItemSetText(myTextItem[p][1], "Oxygen level: " ..tostring(getElementData(p, oxygen)).."%\nPress 'm' to stop exercising\nSpeed : " ..tostring(getElementData(p, "speed_running")).." tap 'r' to accelerate\nAverage speed : " ..tostring(getElementData(p, "average_speed")).."kmh")
		end
	end
end

function calcTired(p, sportType)
	if (isElement(p)) then
		kill(p)
		timer[p] = setTimer(function()
			local tired = getElementData(p, oxygen) or 100
			handleAnimation(p, sportType)
			if (tired > 0 and performing_task[p][1] == "true") then
				decelerate(p)
				increaseTired(p, tired, sportType)
				updateTextItem(p, sportType)
				increaseWorkoutTime(p)
				calcAverageIntensityWorkout(p)
			else
				kill(p)
				celebrate(p, sportType)
				increaseStaminaOrStrength(p, getElementData(p, "average_speed"), getElementData(p, workoutTimer), getElementData(p, "reps"), sportType) --needs to be here for proper calculations
				resetWorkoutTimer(p) --we reset this a little bit earlier for the client sounds
				setTimer(function() walkOff(p, sportType) end, 1000, 1)
				setTimer(function() stopGymProcess(p, sportType) end, 3000, 1)
			end
		end, 500, 0)
	end
end

function celebrate(p, sportType)
	if (isElement(p)) then
		setPedAnimation ( p, "GYMNASIUM", tostring(sportSetup[sportType][10]), -1, false, false, false)
	end
end

function walkOff(p, sportType)
	if (isElement(p)) then
		if (sportSetup[sportType][6] ~= "") then
			setPedAnimation ( p, tostring(sportSetup[sportType][13]), tostring(sportSetup[sportType][6]), -1, false, false, false)
			if (sportType == "dumbell") then --remove dumbells
				exports.bone_attach:detachElementFromBone(real_dumbell[p][1])
				exports.bone_attach:detachElementFromBone(real_dumbell[p][2])
				setElementPosition(real_dumbell[p][1], 772, 5.04, 1000)
				setElementPosition(real_dumbell[p][2], 772, 5.5, 1000)
			end
		end
	end
end

function stopGymProcess(p, sportType)
	if (isElement(p)) then
		if (performing_task[p][1] == "true") then
			performing_task[p][1] = "false"
			setCameraTarget ( p , p)
			setTimer(function()
				resetGymProcess(p)
			end, 4000, 1)
		end
	end
end

function resetReps(p)
	if (isElement(p)) then
		setElementData(p, "reps", 0)
	end
end


function resetAverageSpeed(p)
	if (isElement(p)) then
		setElementData(p, "average_speed", 0)
	end
end

function resetSpeed(p)
	if (isElement(p)) then
		setElementData(p, "speed_running", 0)
	end
end

function resetWorkoutTimer(p)
	if (isElement(p)) then
		setElementData(p, workoutTimer, 0)
	end
end

function resetTotalSpeed(p)
	if (isElement(p)) then
		setElementData(p, "total_speed", 0)
	end
end

function resetGymProcess(p)
	if (isElement(p)) then
		resetAnimation(p)
		resetBind(p)
		restoreOxygen(p)
		resetAverageSpeed(p)
		resetSpeed(p)
		resetTotalSpeed(p)
		resetReps(p)
		setElementFrozen(p, false)
		setElementDimension(p, 0)
		destroyElement(real_dumbell[p][1])
		destroyElement(real_dumbell[p][2])
		real_dumbell[p][1] = nil --it's real_dumbell -.-' so stupid from me lel
		real_dumbell[p][2] = nil --if you do not nill it your server will start lagging with alot of players, so keep in mind to do that when creating global variables for multiple players
		setElementData(p, "doing_animation", "false")
	end
end

function resetAnimation(p)
	if (isElement(p)) then
		setPedAnimation ( p, false)
	end
end

function resetBind(p)
	if (isElement(p)) then
		unbindKey ( p, "m", "up", stopGymProcess )
	end
end

function deleteTextItem(p)
	if (isElement(p)) then
		if (myTextDisplay[p][1] ~= nil and myTextItem[p][1] ~= nil) then
			textDisplayRemoveObserver ( myTextDisplay[p][1], p )
			textDisplayRemoveText ( myTextDisplay[p][1], myTextItem[p][1] )
			myTextItem[p][1] = nil
			myTextDisplay[p][1] = nil
			performing_task[p][1] = "false"
		end
	end
end

function addTextItem(p, text)
	if (isElement(p)) then
		if not (myTextDisplay[p]) then
			-- Create a text display.
			myTextDisplay[p] = {}
			myTextDisplay[p][1] = textCreateDisplay ()
			-- Add a player as an observer, i.e. this player will see all text items that are on this display
			textDisplayAddObserver ( myTextDisplay[p][1], p )
			-- Create a new text item with the text 'Hello World' and a priority of 'low' and colored red.
			myTextItem[p] = {}
			myTextItem[p][1] = textCreateTextItem ( text, 0.7, 0.7, "medium", 255, 255, 255, 200, 2, "left", "top", 255)
			-- Add the newly created text item to the display
			textDisplayAddText ( myTextDisplay[p][1], myTextItem[p][1] )
		end
	end
end

function restoreOxygen(p)
	if (isElement(p)) then
		local theTimer = nil
		local oxygen_level = getElementData(p, oxygen)
		if (myTextItem[p][1] ~= nil) then
			textItemSetText(myTextItem[p][1], "Oxygen level: " ..tostring(getElementData(p, oxygen)).."%")
		end
		local ticks = 100 - oxygen_level
		theTimer = setTimer(function()
			if (oxygen_level < 100 and performing_task[p][1] == "false") then
				oxygen_level = oxygen_level + 1
				setElementData(p, oxygen, oxygen_level)
				if (myTextItem[p][1] ~= nil) then
					textItemSetText(myTextItem[p][1], "Oxygen level: " ..tostring(getElementData(p, oxygen)).."%")
				end
			end
		end, 1000, ticks)
	end
end

--MATH FUNCTIONS--

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function setProperDimension(p)
	if (isElement(p)) then
		if (getElementDimension(p) ~= 0) then
			setElementDimension(p, 0)
		end
	end
end

addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()), initSportData)


addEventHandler("onPlayerLogin", root,
  function()
	local p = source
	setTimer(function() setProperDimension(p) end, 1000, 1)
	setElementData(p, "total_speed", 0)
	setElementData(p, "average_speed", 0)
	setElementData(p, workoutTimer, 0)
	setElementData(p, "speed_running", 0)
    setElementData(p, oxygen, 100)
	setElementData(p, "doing_animation", "false")
	setElementData(p, "reps", 0)
  end
)

addEventHandler("onMarkerHit", run_marker, onRunMarkerHit)
addEventHandler("onMarkerHit", spinning_marker, onSpinningMarkerHit)
addEventHandler("onMarkerHit", dumbell_marker, onDumbellMarkerHit)
addEventHandler("onMarkerHit", boxing_marker, onBoxingMarkerHit)
addEventHandler("onMarkerHit", leaving_marker, onLeavingMarkerHit)