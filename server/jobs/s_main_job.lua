local job_marker_1 = createMarker(1310, -1372, 12.5, "cylinder", 2, 0 , 0, 255, 155)


function job_marker_hit(hitElement, matchingDimension)
	local  sourceAccount = getPlayerAccount ( hitElement )
	if (sourceAccount) then
		-- if they're not a guest
		if not isGuestAccount ( sourceAccount ) then
			if (getElementData(hitElement, "arrested")) then
				if (getElementData(hitElement, "arrested") == "true") then
					return
				end
			end
			triggerClientEvent("displayJobScreen", hitElement, displayJobScreen)
		end
	end
end

function handlePickedUpClient( thePickup)
	if (client == source) then
		local  sourceAccount = getPlayerAccount ( source )
		if (sourceAccount) then
			-- if they're not a guest
			if not isGuestAccount ( sourceAccount ) then
				
				local jobType = getElementData(source, "jobType")
				local etype = getElementType(source)
				if (etype == 'player') then
					local thePlayer = etype == 'player' and source or false --If the element type is a player, then store the player in thePlayer var.
					if (getElementData(thePlayer, "arrested")) then
						if (getElementData(thePlayer, "arrested") == "true") then
							return
						end
					end
					if not (getPedOccupiedVehicle ( thePlayer )) then
						if thePlayer then
							if (thePickup == 325) then
								setPedAnimation( thePlayer, "FOOD", "FF_Sit_Eat1")
								setTimer(function() 
									addCocaine(thePlayer, math.random(1, 4)) 
									setPedAnimation(thePlayer, false)
								end, 3000, 1)
							elseif (thePickup == 1239 and jobType == "Farmer") then
								triggerClientEvent("crackInformation", getRootElement(), displayCrackInformation, thePlayer)
								cancelEvent()
							elseif (thePickup == 1239 and jobType == "Police") then
								triggerClientEvent("policeInformation", getRootElement(), displayPoliceInformation, thePlayer)
								cancelEvent()
							elseif (thePickup == 1279) then
								lootCocaine()
							end
						end
					end
				end
			end
		end
	end
end

function startPoliceJob()
	if (client == source) then
		setElementData(source, "jobType", "Police")
		outputChatBox("Congratulations, you're a police officer now!", source)
	end --security
end

function startGangsterJob()
	if (client == source) then
		setElementData(source, "jobType", "Gangster")
		outputChatBox("G up! You're a Gangster now!", source)
	end --security
end

function startFarmerJob()
	if (client == source) then
		setElementData(source, "jobType", "Farmer")
		outputChatBox("Congratulations, you're a farmer now!", source)
	end --security
end

function startPiloteJob()
	if (client == source) then
		setElementData(source, "jobType", "Pilot")
		outputChatBox("Congratulations, you're a Pilot now!", source)
	end --security
end

function quitJob()
	if (client == source) then
		if (getElementData(source, "jobType") == "None") then
			outputChatBox("You're already unemployed!", source)
		else
			setElementData(source, "jobType", "None")
			outputChatBox("You quit your job, you're now unemployed.", source)
		end
	end --security
end

addEvent("startFarmerJob", true)
addEventHandler("startFarmerJob", getRootElement(), startFarmerJob)

addEvent("startGangsterJob", true)
addEventHandler("startGangsterJob", getRootElement(), startGangsterJob)

addEvent("startPoliceJob", true)
addEventHandler("startPoliceJob", getRootElement(), startPoliceJob)

addEvent("startPiloteJob", true)
addEventHandler("startPiloteJob", getRootElement(), startPiloteJob)


addEvent("quitJob", true)
addEventHandler("quitJob", getRootElement(), quitJob)


--CUSTOM EVENTS--

addEvent("handlePickedUpClient", true)
addEventHandler("handlePickedUpClient", getRootElement(), handlePickedUpClient)

--server events

addEventHandler( "onMarkerHit", job_marker_1, job_marker_hit) -- attach onMarkerHit event to MarkerHit function
