local hacking_marker_1 = createMarker(825, -1354, 12.5, "cylinder", 2, 255, 0, 0)

function hitHackMarker(hitElement, matchingDimension)
	local  sourceAccount = getPlayerAccount ( hitElement )
	if (sourceAccount) then
		-- if they're not a guest
		if not isGuestAccount ( sourceAccount ) then
			local elementType = getElementType(hitElement)
			if (elementType == "player") then
				if not (isPedInVehicle ( hitElement )) then
					if (getCurrentJob(hitElement) == "criminal") then
						triggerClientEvent("drawHackingInterface", hitElement, createHackingGui)
					else
						outputChatBox("You have to be a criminal to hack this mta.", hitElement)
					end
				end
			end
		end
	end
end

function succesHack(timeLeft)
	if (client == source) then
		local calculateMoney = 1000 * tonumber(timeLeft)
		local criminal_points = getJobAttribute(client, "criminal", getJobExperienceIndex())
		criminal_points = criminal_points + 1
		local wanted = 1 + getPlayerWantedLevel(client)
		if (calculateMoney == 0) then calculateMoney = 1000 end
		givePlayerMoney ( client, calculateMoney )
		outputChatBox("You received " ..calculateMoney .."$ from the ATM!")
		setPlayerWantedLevel ( client, wanted )
		setJobAttribute(client, "criminal", getJobExperienceIndex(), criminal_points)
	end
end



addEvent("succesHack", true)
addEventHandler("succesHack", root, succesHack)



--SERVER EVENTS

addEventHandler( "onMarkerHit", hacking_marker_1, hitHackMarker ) -- attach onMarkerHit event to MarkerHit function