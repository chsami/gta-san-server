addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()
	bindAllKeys()
end)

function bindAllKeys()
	bindKey("i", "up", buildInventory)
	bindKey("o", "up", showStats)
	bindKey("u", "up", getOwnedVehicles)
	bindKey("m", "up", function()
		if (isCursorShowing()) then
			showCursor(false)
		else
			showCursor(true)
		end
	end)
end

function unbindAllKeys()
	unbindKey("i", "up", buildInventory)
	unbindKey("o", "up", showStats)
	unbindKey("u", "up", getOwnedVehicles)
	unbindKey("m", "up", function()
		if (isCursorShowing()) then
			showCursor(false)
		else
			showCursor(true)
		end
	end)
end
