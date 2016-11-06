

local JAIL_X = 246
local JAIL_Y = 112
local JAIL_Z = 1003.5
local MONEY_REWARD = 1000

local start_police_marker = createMarker(1553, -1675, 15, "cylinder", 2, 0, 0, 250, 150)

function handleShowPoliceJobInterface(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement) and getElementType(hitElement) == "player") then
		if (getPlayerWantedLevel (hitElement) == 0) then
			triggerClientEvent(hitElement, "showPoliceJob", hitElement, drawPoliceJobInterface)
		else
			outputChatBox("You're a wanted criminal!", hitElement, 255, 0, 0)
		end
	end
end

addEventHandler("onMarkerHit", start_police_marker, handleShowPoliceJobInterface)


--[[

INFORMATION BOARD :

The reason why i'm making this information board is because we have alot of different elementdata's, which is hard to keep track off, so we make a little table that explains what elementData does.

setElementData(thePlayer, "arrested", "true" or "false") -- We use this data type to see if the player has been arrested or not.

setElementData(thePlayer, "player_arrest", 0 or theArrestedPlayer) -- We use this data type to see if a cop has made an arrest, if the cop did make an arrest we store theArrestedPlayer value into the elementData.

setElementData(thePlayer, "times_hit", INTEGER) -- We use this data type to see how many times the CRIMINAL has been hit, if the criminal gets more then 3 hits with the police bat he gets arrested.

setElementData(thePlayer, "cop_arrested_me", 0 or theCop) -- We use this data type to see what cop has arrested the criminal, store Cop value into the element data, default = 0

setElementData(thePlayer, "policeTimer", theTimer) -- store the police timer that makes the criminal follow the police officer in "policeTimer" data type, we use this data type later on to kill the police timer when a player has been to jail

setElementData(thePlayer, "jail_timer", INTEGER) -- we use this data type to see how much time the player got left in jail (note : This also saves into the player sql database) (Reason: when player logs out we can retrieve the amount of jail-time)

setElementData(thePlayer, "jailTimerId", theTimer) --we use this data type to store the jailTimer process into "jailTimerId" (Reason: to ues killTimer(theTimer) when a player is either out of jail or logged out)

]]

function restockPoliceGear()
	if (client == source) then
		giveWeapon ( client, 23, 100 ) --gives the silence pistol (taser gun) with 100 bullets
		giveWeapon ( client, 3, 1 ) --gives the night club
		setWeaponAmmo ( client, 23, 100)
		triggerClientEvent("notificationMessage", client, drawDXNotificationMessage, "You restocked succesfully!")
	end
end

function tasePlayer ( attacker, weapon, bodypart, loss ) --when a player is damaged
	if (source and attacker) then
		local thePlayer = source
		local tempHealth = getElementHealth(thePlayer)
		tempHealth = tempHealth + loss
		if (getElementData(thePlayer, "jail_timer")) then
			if (type((getElementData(thePlayer, "arrested"))) ~= "number") then
				if ((getElementData(thePlayer, "arrested") == "true" or getElementData(thePlayer, "jail_timer") > 0) or getElementData(attacker, "arrested") == "true" or getElementData(attacker, "jail_timer") > 0) then --people in jail or arrested can't take damage and deal out damage
					setElementHealth(thePlayer, tempHealth)
					return
				end
			end
		end
		if (weapon == 23) then
			setElementHealth(thePlayer, tempHealth)
			if (getCurrentJob(thePlayer) ~= "Police") then
				loss = 0
				outputChatBox("You're not allowed to use this weapon!", attacker)
				return
			end
			if (getPlayerWantedLevel ( source ) > 0) then
				loss = 0
				setElementFrozen(source, true)
				outputChatBox("You have been tazed!", source)
				triggerClientEvent("playTaserSound", getRootElement(), playTaserSound, thePlayer)
				setTimer(function()
					setElementFrozen(thePlayer, false)
				end, 2000, 1)
			end
		elseif (weapon == 3) then
			setElementHealth(thePlayer, tempHealth)
			if (getCurrentJob(thePlayer) ~= "Police") then
				loss = 0
				outputChatBox("You're not allowed to use this weapon!", attacker)
				return
			end
			if (getPlayerWantedLevel ( thePlayer ) > 0 and getElementData(thePlayer, "times_hit") < 3) then
					local temp_timesHit = getElementData(thePlayer, "times_hit")
					temp_timesHit = temp_timesHit + 1
					setElementData(thePlayer, "times_hit", temp_timesHit)
			elseif (getPlayerWantedLevel ( thePlayer ) >= 0 and getElementData(thePlayer, "times_hit") >= 3) then
				if (getElementData(attacker, "player_arrest") == 0) then
					if (getElementData(thePlayer, "arrested") == "false") then
						arrestPlayer(attacker, thePlayer)
					else
						outputChatBox("This player is already arrested!", attacker)
					end
				else
					outputChatBox("You already arrested a man!", attacker)
				end
			end
		end
	end
end

function arrestPlayer(thePlayer, arrestedPlayer)
	if (thePlayer and arrestedPlayer) then
		setElementData(arrestedPlayer, "times_hit", 0)
		setElementData(arrestedPlayer, "arrested", "true")
		setElementData(thePlayer, "player_arrest", arrestedPlayer)
		outputChatBox("You've been arrested!", arrestedPlayer)
		outputChatBox("You arrested " ..getPlayerName(arrestedPlayer).. ". You have aprox 2 minutes to get him to jail!", thePlayer)
		followOfficer(thePlayer, arrestedPlayer)
		triggerClientEvent("disablePlayerInput", getRootElement(), disablePlayerInput, arrestedPlayer)
	end
end


function followOfficer(thePlayer, arrestedPlayer)
	local jail_timer = 400
	local tick = 401
	timer[thePlayer] = setTimer(function()
		if (isElement(thePlayer)) then
			if (isElement(arrestedPlayer)) then
				if (getElementHealth(arrestedPlayer) <= 0 or getElementData(arrestedPlayer, "arrested") == "false") then
					return
				end
				if (getElementHealth(thePlayer) > 0) then --if the officer dies let the arrestedplayer escape :)
					if (jail_timer > 0) then
						jail_timer = jail_timer - 1
						local x, y , z = getElementPosition(thePlayer)
						local x2, y2, z2 = getElementPosition(arrestedPlayer)
						local interior = nil
						if (getDistanceBetweenPoints3D ( x, y , z , x2, y2, z2) > 3 and getDistanceBetweenPoints3D ( x, y , z , x2, y2, z2) < 11) then
							local rot = math.atan2(y - y2, x - x2) * 180 / math.pi
							rot = rot-90
							setPedRotation(arrestedPlayer, rot)
							setPedAnimation ( arrestedPlayer, "ped", "jog_maleA", -1, true, true, false)
						elseif (getDistanceBetweenPoints3D ( x, y , z , x2, y2, z2) > 10) then
							x, y , z = getElementPosition(thePlayer)
							interior = getElementInterior(thePlayer)
							setElementPosition(arrestedPlayer, x, y , z)
							setElementInterior(arrestedPlayer, interior)
						else
							setPedAnimation(arrestedPlayer, false)
						end
					else
						escapeCriminal(thePlayer, arrestedPlayer)
					end
				else
					escapeCriminal(thePlayer, arrestedPlayer)
				end
			else
				giveOfficerReward(thePlayer)
			end
		else
			--escapeCriminalPoliceLogged(arrestedPlayer)
		end
	end, 300, tick)
		setElementData(arrestedPlayer, "cop_arrested_me", thePlayer)
		setElementData(thePlayer, "policeTimer", timer[thePlayer])
end

function escapeCriminalPoliceLogged(arrestedPlayer)
	if (isElement(arrestedPlayer)) then
		setElementData(arrestedPlayer, "arrested", "false")
		setElementData(arrestedPlayer, "player_arrest", 0)
		outputChatBox("You managed to escape because the police officer is not in this world anymore!", arrestedPlayerr)
		triggerClientEvent("enablePlayerInput", arrestedPlayer, enablePlayerInput, arrestedPlayer)
	end
end

function givePolicePoints(thePlayer)
	local police_points = getJobAttribute(thePlayer, "police", getJobExperienceIndex())
	police_points = police_points + 1
	return police_points
end

function setJailTime(thePlayer, jailTime)
	if (isElement(thePlayer)) then
		setElementData(thePlayer, "jail_timer", jailTime)
	end
end

function sendPlayerToJail(thePlayer)
	if (isElement(thePlayer)) then
		setElementData(thePlayer, "arrested", "false")
		setElementPosition(thePlayer, JAIL_X, JAIL_Y, JAIL_Z)
		setElementInterior(thePlayer, 10)
		setPedAnimation(thePlayer, false)
		outputChatBox("You have been jailed!", thePlayer)
	end
end

function handlePlayerArrest(thePlayer, playerToJail) --when a cop arrested a player and sends him to jail we execute this function
	if (isElement(thePlayer) and isElement(playerToJail)) then
		setElementData(thePlayer, "player_arrest", 0)
		outputChatBox("You jailed " ..getPlayerName(playerToJail), thePlayer)
		setJobAttribute(thePlayer, "police", getJobExperienceIndex(), givePolicePoints(thePlayer))
		givePlayerMoney(thePlayer, MONEY_REWARD)
		outputChatBox(getPlayerName(thePlayer).. " is not in this world anymore, but you got 1000$ for your arrest!", thePlayer)
		outputChatBox("You earned 1 police point and you have a total of : " ..tostring(getJobAttribute(thePlayer, "police", getJobExperienceIndex())).. " police points.", thePlayer)
		kill(p)
	end
end

function sendPlayerOutJail(thePlayer)
	if (isElement(thePlayer)) then
		setElementPosition(thePlayer, 1543, -1675, 14)
		setElementInterior(thePlayer, 0)
		outputChatBox("You left jail...", thePlayer)
		setElementData(thePlayer, "arrested", "false")
		setElementData(thePlayer, "player_arrest", 0)
		triggerClientEvent("hideDrawDXJailTimer", thePlayer, hideDrawDXJailTimer)
		setPlayerWantedLevel(thePlayer, 0)
	end
end

function jailPlayer()
	if (client == source) then
		local thePlayer = source
		if (getElementData(source, "player_arrest") ~= 0) then
			local playerToJail = getElementData(thePlayer, "player_arrest")
			if (isElement(playerToJail)) then
				local jail = 60
				local wanted = getPlayerWantedLevel ( playerToJail )
				local total_jail_time = jail*wanted
				local tick = jail + 1
				setJailTime(playerToJail, 60) --set jail time to 60 seconds
				sendPlayerToJail(playerToJail) --send player to the jail
				handlePlayerArrest(thePlayer, playerToJail) -- police send criminal to jail and gets the reward
				handleJailTimer(playerToJail, total_jail_time, tick) --start the jail timer for the criminal
				triggerClientEvent("enablePlayerInput", playerToJail, enablePlayerInput) --give the player input so he can walk around in jail
			end
		else
			outputChatBox("You have no arrest!", source)
		end
	end--security
end


function handleJailTimer(playerToJail, jail_timer, tick)
	if (isElement(playerToJail)) then
		local  sourceAccount = getPlayerAccount (  playerToJail )
		if (sourceAccount) then
		-- if they're not a guest
			if not isGuestAccount ( sourceAccount ) then
				if (getElementData(playerToJail, "jail_timer") > 0) then
					kill(playerToJail)
					outputChatBox("You are jailed!", playerToJail)
					triggerClientEvent("showDrawDXJailTimer", playerToJail, showDrawDXJailTimer)
					timer[playerToJail] = setTimer(function()
						if (isElement(playerToJail)) then
							if (jail_timer > 0) then
								jail_timer = jail_timer - 1
								setJailTime(playerToJail, jail_timer)
							else
								sendPlayerOutJail(playerToJail)
							end
						end
					end, 1000, tick)
					setElementData(playerToJail, "jailTimerId", timer[playerToJail])
				end
			end
		end
	end
end


function jailPlayerBeforeLogout(thePlayer) --people that try to dodge jail with logging out use this function
	if (thePlayer) then
		setJailTime(thePlayer, 60)
		setElementPosition(thePlayer, JAIL_X, JAIL_Y, JAIL_Z)
		setElementInterior(thePlayer, 10)
		setPedAnimation(thePlayer, false)
		outputChatBox("You have been jailed!", thePlayer)
		kill(thePlayer)
		giveOfficerReward(thePlayer)
	end
end

function giveOfficerReward(thePlayer)
	if (getCurrentJob(thePlayer) == "police") then
		if (isElement(thePlayer)) then
			if (isTicking(thePlayer)) then
				givePlayerMoney(thePlayer, 1000)
				setJobAttribute(thePlayer, "police", getJobExperienceIndex(), givePolicePoints(thePlayer))
				outputChatBox(getPlayerName(thePlayer).. " is not in this world anymore, but you got 1000$ for your arrest!", thePlayer)
				outputChatBox("You earned 1 police experience and you have a total of : " ..tostring(getJobAttribute(thePlayer, "police", getJobExperienceIndex())).. " police points.", thePlayer)
				setElementData(thePlayer, "player_arrest", 0)
				kill(thePlayer)
			end
		end
	end
end

function escapeCriminal(thePlayer, arrestedPlayer)
	setElementData(arrestedPlayer, "arrested", "false")
	setElementData(arrestedPlayer, "player_arrest", 0)
	outputChatBox("You managed to escape!", arrestedPlayer)
	outputChatBox("Your arrested player has escaped!", thePlayer)
	kill()
	triggerClientEvent("enablePlayerInput", arrestedPlayer, enablePlayerInput)
end


--CUSTOM EVENTS--

addEvent("jailPlayer", true)
addEventHandler("jailPlayer", getRootElement(), jailPlayer)

addEvent("restock", true)
addEventHandler("restock", getRootElement(), restockPoliceGear)

--SERVER EVENTS--

addEventHandler ( "onPlayerDamage", getRootElement (), tasePlayer )