
local clothes_marker_1 = createMarker ( 207, -101, 1003.5, "cylinder", 2, 0, 200, 50, 150, default)
setElementInterior(clothes_marker_1, 15)
setElementDimension(clothes_marker_1, 0)

function initPlayerClothes(hitElement, matchinDimension)
	if (hitElement) then
		local  sourceAccount = getPlayerAccount ( hitElement )
		if (sourceAccount) then
			-- if they're not a guest
			if not isGuestAccount ( sourceAccount ) then
				if (getElementData(hitElement, "arrested")) then
					if (getElementData(hitElement, "arrested") == "true") then
						return
					end
				end
				local x, y , z = getElementPosition(hitElement)
				local lookX = x + 10
				local lookY = y + 5
				local lookZ = z + 1
				if (source == clothes_marker_1) then
					setCameraMatrix ( hitElement, x, y, z, lookX, lookY, lookZ, 0, 100)
					local camX, camY, camZ = getCameraMatrix (hitElement)
					setElementPosition(hitElement, 210, -101, 1005.3)
					setElementRotation ( hitElement, 0, 0, 116 )
					setElementFrozen(hitElement, true)
					outputChatBox("Select your skin!", hitElement)
					triggerClientEvent("skinGui", hitElement, createSkinPickGui)
				end
			end
		end
	end
end

function initPlayerNewSkin(newSkin)
	if (client == source) then
		setElementModel(source, tonumber(newSkin))
		setElementFrozen(source, false)
		fadeCamera (source, true)
		setCameraTarget (source, source)
		outputChatBox("Congratulations you bought some new clothes!", source)
	end --security
end





--CUSTOM EVENTS--

addEvent("newSkin", true)
addEventHandler("newSkin", getRootElement(), initPlayerNewSkin)

--SERVER EVENTS--

addEventHandler( "onMarkerHit", getRootElement(), initPlayerClothes ) -- attach onMarkerHit event to MarkerHit function