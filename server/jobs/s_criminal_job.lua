local start_criminal_marker = createMarker(1010, -1366, 12.5, "cylinder", 2, 255, 0, 0, 150)

local pizzaman  = createPed(155, 369, -4.3, 1002)
setElementInterior(pizzaman, 9)
setElementRotation(pizzaman, 0, 0, 180)

-- 1212, 1550

local cooldown = {}


function initializeCriminalData(p)
	if (isElement(p) and isLoggedIn(p)) then
		initCooldownTimer(p)
	end
end

function initCooldownTimer(p)
	if (isElement(p) and isLoggedIn(p)) then
		local cooldown = getCriminalCooldown(p)
		if (cooldown ~= nil) then
			if (cooldown > 0) then
				setTimer(function()
					if (cooldown > 0) then
						cooldown = cooldown - 1
						setCriminalCooldown(p, cooldown)
					end
				end, 60000, cooldown)
			end
		end
	end
end

function finalizeCriminalData(p)
	if (isElement(p) and isLoggedIn(p)) then
		cooldown[p] = nil
	end
end



function onPlayerTarget ( targetElem )
	if (targetElem ~= nil and isElement(targetElem)) then
		if (getElementType ( targetElem ) == "ped" and getElementModel ( targetElem ) == 155) then --pizza man cross
			if (isElement(source) and isLoggedIn(source)) then
				if (getCurrentJob(source) == "criminal") then
					if (getCriminalCooldown(source) == 0) then
						startRobbery(source)
						setPedAnimation ( targetElem, "PED", "DUCK_cower", -1, false, false, false, true)
					else
						outputChatBox("The cash pile of this store will refill in aprox: " ..getCriminalCooldown(source).." minutes.", source, 255, 0, 0)
					end
				else
					outputChatBox("You need to be a criminal to rob a store.", source, 255, 0, 0)
				end
			end
		end
	end
end

function startRobbery(p)
	if (isElement(p) and isLoggedIn(p) and getElementInterior(p) == 9) then
		startCashSpawn(p)
		setCashBag(p)
		setPlayerWantedLevel(p, 1)
	end
end



function setCashBag(p)
	if (isElement(p) and isLoggedIn(p) and getElementInterior(p) == 9) then
		local x, y , z = getElementPosition(p)
		local cash_bag = createObject(1550, 0, 0, 0)
		setElementInterior(cash_bag, 9)
		setElementDoubleSided ( cash_bag, true )
		exports.bone_attach:attachElementToBone(cash_bag,p,2,0,-0.27,-0.2,0, 0, 0)
	end
end

function startCashSpawn(p)
	if (isElement(p) and isLoggedIn(p) and getElementInterior(p) == 9) then
		local loop_times = 6
		local cash_loot = 0
		local theTimer = nil
		local criminal_point = getJobAttribute(p, "criminal", getJobExperienceIndex()) + 1
		setElementPosition(p, 368.95, -6.8, 1001.8)
		setPedAnimation(p, "ROB_BANK", "CAT_Safe_Rob", -1, true, false, false, false)
		triggerClientEvent(p, "initializePlayerRob", p, handleInitializePlayerRobbing, cash_loot, loop_times)
		theTimer = setTimer(function()
			if (loop_times > 0) then
				cash_loot = cash_loot + getCriminalSalary()
				triggerClientEvent(p, "rob_process", p, handleRobProcess, cash_loot, loop_times)
				loop_times = loop_times - 1
			else
				triggerClientEvent(p, "notificationMessage", p, drawDXNotificationMessage, "You managed to steal $" ..cash_loot.."!")
				givePlayerMoney(p, cash_loot)
				setJobAttribute(p, "criminal", getJobExperienceIndex(), criminal_point)
				startCoolDownTimer(p)
				setPedAnimation(p, false)
				setPedAnimation ( pizzaman, false)
				killTimer(theTimer)
			end
		end, 1000, 0)
	end
end

function startCoolDownTimer(p)
	if (isElement(p) and isLoggedIn(p)) then
		cooldown[p] = 3
		if (cooldown[p] > 59) then
			cooldown[p] = cooldown[p] - 60
		end
		initCooldownTimer(p)
	end
end

function getCriminalCooldown(p)
	if (isElement(p) and isLoggedIn(p)) then
		return cooldown[p]
	end
end

function setCriminalCooldown(p, par_value)
	if (isElement(p) and isLoggedIn(p)) then
		if (par_value ~= nil) then
			cooldown[p] = par_value
		end
	end
end

function handleStartCriminalJob(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement) and getElementType(hitElement) == "player") then
		triggerClientEvent(hitElement, "showCriminalJob", hitElement, drawCriminalJobInterface)
	end
end


--CUSTOM EVENTS--

addEvent("completeRob", true)

addEventHandler("onMarkerHit", start_criminal_marker, handleStartCriminalJob)