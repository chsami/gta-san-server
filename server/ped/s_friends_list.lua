
local friendsListArray = {}
local jsonFriendsList = {}
local names = {}

function initializeFriendsList(p)
	friendsListArray[p] = {}
	jsonFriendsList[p] = {}
end
	
	
function loadFriendsList(p)
	if (isElement(p) and isLoggedIn(p)) then
		local friends = executeSQLQuery("SELECT friends FROM servername_players WHERE username=?", getLoginName(p))
		for i, value in ipairs(friends) do
			if (value.friends ~= nil) then
				friendsListArray[p][1] = fromJSON ( value.friends )
				outputChatBox("friends succesfully loaded!", p)
			end
		end
		if (friendsListArray[p][1] ~= nil) then
			triggerClientEvent(client, "getNames", client, handleGetNames, friendsListArray[p][1])
		end
	end
end


--TODO : REWORK IT
function handleAddFriend(friendName)
	if (client == source) then
		if (friendsListArray[client]) then
			if (friendsListArray[client][1] ~= nil and type(friendsListArray[client][1]) == "table") then
				for i, value in pairs(friendsListArray[client][1]) do
					friendsListArray[client][1] = value
					--outputChatBox("names : " ..tostring(value))
				end
			else
				for i, value in pairs(friendsListArray[client]) do
					friendsListArray[client][1] = value
					--outputChatBox("names : " ..tostring(value))
				end
			end
			if (friendsListArray[client][1] ~= nil) then
				names[client] = tostring(friendsListArray[client][1]).." "..friendName
				friendsListArray[client][1] = tostring(friendsListArray[client][1]).." "..friendName
			else
				names[client] = friendName
				friendsListArray[client][1] = friendName
			end
				--outputChatBox("NO TABLE " ..names[client], client)
				--outputChatBox("Add friend : " ..tostring(friendsListArray[client][1]))
				triggerClientEvent(client, "getNames", client, handleGetNames, names[client])
			local json = toJSON ( { Friends = friendsListArray[client][1]} )
			jsonFriendsList[client][1] = json
			saveFriendsList(client)
		end
	end
end

addEvent("addFriend", true)
addEventHandler("addFriend", root, handleAddFriend)

function handleDeleteFriend(name)
	if (client == source) then
		if (type(friendsListArray[client][1]) == "table") then
			for i, v in pairs(friendsListArray[client][1]) do
				if (string.match(v, name)) then
					v = string.gsub(v, name, "")
					names[client] = v
					friendsListArray[client][1] = v
				end
			end
		else
			if (string.match(friendsListArray[client][1], name)) then
				local value = string.gsub(friendsListArray[client][1], name, "")
				names[client] = value
				friendsListArray[client][1] = value
			end
		end
		outputChatBox("Delete friend : " ..tostring(names[client]))
		triggerClientEvent(client, "getNames", client, handleGetNames, names[client])
		local json = toJSON ( { Friends = names[client]} )
		jsonFriendsList[client][1] = json
		saveFriendsList(client)
	end
end

addEvent("deleteFriend", true)
addEventHandler("deleteFriend", root, handleDeleteFriend)

function handleMessageFriend(friend, message)
	if (client == source) then
		if (message ~= nil) then
			if (friend ~= nil) then
				local players = getElementsByType("player")
				for i, v in ipairs(players) do
					outputChatBox("friend : " ..friend.. " name : " ..getPlayerName(v))
					if (friend == getPlayerName(v)) then
						outputChatBox(getPlayerName(client)..": "..message, v, 255, 0, 0)
						outputChatBox("message send succesfully : " ..message, client, 255, 0, 0)
						return
					end
				end
				outputChatBox("The player you selected is not online.", client)
			else
				outputChatBox("Invalid player name!", client)
			end
		else
			outputChatBox("Invalid message", client)
		end
	end
end

addEvent("messageFriend", true)
addEventHandler("messageFriend", root, handleMessageFriend)


function handleTrackFriend(friendName)
	if (client == source) then
		if (friendName ~= nil and friendName ~= "") then
			local players = getElementsByType("player")
			for i, v in ipairs(players) do
				if (friend == getPlayerName(v)) then
					local x, y , z = getElementPosition(v)
					triggerClientEvent(client, "showLine", client, handleShowLine, v)
				end
			end
		end
	end
end

addEvent("trackFriend", true)
addEventHandler("trackFriend", root, handleTrackFriend)

function saveFriendsList(p)
	if (isElement(p) and isLoggedIn(p)) then
		executeSQLQuery("UPDATE servername_players SET friends=? WHERE username=? ", jsonFriendsList[p][1], getLoginName(p))
	end
end