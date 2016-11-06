
local chatOptions = {}

function initalizeChatOptions(p)
	if (isElement(p) and isLoggedIn(p)) then
		chatOptions[p] = "ooc"
		outputChatBox("Your chat option has been set to [OOC] = Out of game character.", p, 255, 0, 0)
	end
end

function finalizeChatOptions(p)
	if (isElement(p) and isLoggedIn(p)) then
		chatOptions[p] = nil
	end
end


-- define a handler that will distribute the message to all nearby players
function sendMessageToNearbyPlayers(p, message, messageType, chatRadius, r, g, b )
	if (p ~= nil) then
		source = p
	end
    -- we will only send normal chat messages, action and team types will be ignored
    if messageType == 0 then
        -- get the chatting player's position
        local posX, posY, posZ = getElementPosition( source )
 
        -- create a sphere of the specified radius in that position
        local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
        -- get a table all player elements inside it
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        -- and destroy the sphere, since we're done with it
        destroyElement( chatSphere )
 
        -- deliver the message to each player in that table
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			outputChatBox( message, nearbyPlayer, r, g, b )
        end
    end
end





function handleChatMessage(message, messageType)
	if (isElement(source) and isLoggedIn(source)) then
		local p = source
		if (messageType ~= 1) then
			if (chatOptions[source] == "ooc") then
				cancelEvent()
				outputChatBox(getLoginName(source)..": " ..message)
			elseif (chatOptions[source] == "ic") then
				cancelEvent()
				sendMessageToNearbyPlayers(source, getPlayerName(source)..": " ..message, 0, 20, 0, 150, 150 )
			end
		end
	end
end

function handleChatMessageThroughCommand(p, cmdName, message, messageType)
	if (isElement(p) and isLoggedIn(p)) then
		if (messageType ~= 1) then
			if (cmdName == "ooc") then
				outputChatBox(getLoginName(p)..": " ..message, 150, 150, 0)
				return
			elseif (cmdName == "ic") then
				sendMessageToNearbyPlayers(p,  getPlayerName(p)..": " ..message, 0, 20, 0, 150, 150 )
				return
			end
		end
	end
end

addCommandHandler("ooc", function(p, cmdName, text)	
	if (text == nil) then
		chatOptions[p] = "ooc"
		outputChatBox("Your chat option has been set to [OOC] = Out of game character.", p, 255, 0, 0)
	else
		handleChatMessageThroughCommand(p, cmdName, text, 0)
	end
end)

addCommandHandler("ic", function(p, cmdName, text)
	if (text == nil) then
		chatOptions[p] = "ic"
		outputChatBox("Your chat options has been set to [IC] = Ingame character", p, 255, 0, 0)
	else
		handleChatMessageThroughCommand(p, cmdName, text, 0)
	end
end)