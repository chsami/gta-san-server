function loadBlips()
	local sqlTable = executeSQLQuery("CREATE TABLE IF NOT EXISTS servername_blips (x INTEGER, y INTEGER, z INTEGER, icon INTEGER, alpha INTEGER, visibleDistance INTEGER)" )
	if (sqlTable) then
		outputChatBox("Blip table initialized!")
	else
		outputChatBox("Error initializing blip table")
	end
	local blipData = executeSQLQuery("SELECT * FROM servername_blips")
	for i, value in ipairs(blipData) do
		if (value ~= nil) then
			createBlip ( value.x, value.y, value.z , value.icon, 2, 255, 0, 0, value.alpha, 0, value.visibleDistance)
		end
	end
end

function createNewBlip(icon, alpha, visibleDistance)
	if (client == source) then
		local x, y , z = getElementPosition(source)
		local sqlInsert = executeSQLQuery("INSERT INTO servername_blips(x, y, z, icon, alpha, visibleDistance) VALUES(?,?,?,?,?,?)", x, y, z, icon, alpha, visibleDistance) --our insert sql for the blipdata
		if (sqlInsert) then
			outputChatBox("Blip succesfully created!", source)
		else
			outputChatBox("Error creating blip :(", source)
		end
	end --security
end

--CUSTOM EVENTS--

addEvent("newBlip", true)
addEventHandler("newBlip", getRootElement(), createNewBlip)


--RESOURCE EVENTS--

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadBlips)