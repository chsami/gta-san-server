function buildMarkerTable()
	local theMarker  = nil
	local createQuery = "CREATE TABLE IF NOT EXISTS servername_markers (marker_id INTEGER PRIMARY KEY AUTOINCREMENT, x INTEGER, y INTEGER, z INTEGER, dimension INTEGER, interior INTEGER, type TEXT, size INTEGER, red INTEGER, blue INTEGER, green INTEGER, alpha INTEGER, visibleTo TEXT, destinationX INTEGER, destinationY INTEGER, destinationZ INTEGER, destinationD INTEGER, destinationI INTEGER, message TEXT)"
	executeSQLQuery(createQuery)
	local selectQuery = "SELECT * FROM servername_markers"
	local markerData = executeSQLQuery(selectQuery)
	if (markerData) then
		outputChatBox("Marker system succesfully initialized!")
	else
		outputChatBox("Error loading marker system!")
	end
	for i, value in ipairs(markerData) do
		if (value ~= nil) then	
			theMarker = createMarker ( value.x, value.y, value.z, value.type, value.size, value.red, value.green, value.blue, value.alpha)
			if (theMarker ~= nil and isElement(theMarker)) then
				setElementInterior(theMarker, value.interior)
				setElementDimension(theMarker, value.dimension)
			end
		end
	end
end


function initMarker(markerType, size, red, blue, green, alpha, visibleTo, destinationX, destinationY, destinationZ, destinationD, destinationI, message)
	if (client == source) then
		local x, y , z = getElementPosition(source)
		local dimension = getElementDimension(source)
		local interior = getElementInterior(source)
		z = z - 1
		executeSQLQuery("INSERT INTO servername_markers (x, y, z, dimension, interior, type, size, red, blue, green, alpha, visibleTo, destinationX, destinationY, destinationZ, destinationD, destinationI, message) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", x, y , z, dimension, interior, markerType, size, red, blue, green, alpha, visibleTo, destinationX, destinationY, destinationZ, destinationD, destinationI, message)
	end
end


function MarkerHit( hitElement, matchingDimension ) -- define MarkerHit function for the handler
	if (isElement(hitElement)) then
		local  sourceAccount = getPlayerAccount ( hitElement )
		if (sourceAccount) then
			-- if they're not a guest
			if not isGuestAccount ( sourceAccount ) then
				local elementType = getElementType( hitElement ) -- get the hit element's type
				if (getPedOccupiedVehicle(hitElement)) then
					return
				end
				local x, y , z = getElementPosition(source) --marker position
				if (elementType == "player") then
					local selectQuery = "SELECT * FROM servername_markers"
					local markerData = executeSQLQuery(selectQuery)
					for i, value in ipairs(markerData) do
						if (value ~= nil) then	
							if (x == value.x and y == value.y and z == value.z) then
								setElementFrozen(hitElement, true)
								triggerClientEvent(hitElement, "startLoading", hitElement, startLoading)
									setTimer( function()
									setElementPosition ( hitElement, value.destinationX, value.destinationY, value.destinationZ )
									setElementDimension(hitElement, value.destinationD)
									setElementInterior(hitElement, value.destinationI)
									outputChatBox(value.message, hitElement)
									triggerClientEvent(hitElement, "stopLoading", hitElement, stopLoading)
									setElementFrozen(hitElement, false)
									if (value.destinationI ~= 0) then
										triggerClientEvent("loadPeds", hitElement, loadPeds)
									else
										triggerClientEvent("destroyPeds", hitElement, destroyPeds)
									end
									
								end, 1000, 1)
								
							end
						end
					end
				end
			end
		end
	end
end



--custom events

addEvent("initMarker", true)
addEventHandler("initMarker", getRootElement(), initMarker)

--server events

addEventHandler( "onMarkerHit", getRootElement(), MarkerHit ) -- attach onMarkerHit event to MarkerHit function

--resource events

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), buildMarkerTable)