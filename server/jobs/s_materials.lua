local material_marker = createMarker(1422, -1319, 13.5, "cylinder", 2, 255, 0, 0, 150)

local crafting_marker = createMarker(1084, -1245, 14.5, "cylinder", 2, 255, 0, 0, 150)

local crafting_weapons_marker = createMarker(1089, -1225, 14.5, "cylinder", 2, 255, 0, 0, 150)

local MATERIAL_PRICE = 50

local playerMaterials = {}
local playerCraftedMaterials = {}

function finalizePlayerMaterials(p)
	if (isElement(p) and isLoggedIn(p)) then
		playerMaterials[p] = nil
		playerCraftedMaterials[p] = nil
	end
end

function getMaterials(p)
	if (isElement(p) and isLoggedIn(p)) then
		return playerMaterials[p]
	end
end

function setMaterials(p, par_value)
	if (isElement(p) and isLoggedIn(p)) then
		if (par_value ~= nil and type(par_value) == "number") then
			
			playerMaterials[p] = par_value
			outputDebugString(tostring(playerMaterials[p]).. " : " ..tostring(p))
		end
	end
end

function getCraftedMaterials(p)
	if (isElement(p) and isLoggedIn(p)) then
		return playerCraftedMaterials[p]
	end
end

function setCraftedMaterials(p, par_value)
	if (isElement(p) and isLoggedIn(p)) then
		if (par_value ~= nil and type(par_value) == "number") then
			playerCraftedMaterials[p] = par_value
		end
	end
end

function handleBuyMaterials(par_amount)
	if (client == source) then
		local total_price = tonumber(par_amount) * MATERIAL_PRICE
		if (getPlayerMoney(client) >= total_price) then
			takePlayerMoney(client, total_price)
			playerMaterials[client] = tonumber(par_amount)
			outputChatBox("You bought " .. par_amount .." materials for the price of : $" ..total_price, client, 255, 0, 0)
		else
			outputChatBox("You need atleast $" ..total_price.." to buy " ..par_amount.." materials", client, 255, 0, 0)
		end
	end
end

addEvent("buyMaterials", true)


function handleCraftMaterials()
	if (client == source) then
		local theTimer = nil
		local p = client
		setPedAnimation (p, "MISC", "Plunger_01", -1, true, false, false, false)
		outputChatBox("You started crafting the materials...", p)
		theTimer = setTimer(function()
			if (playerMaterials[p] ~= nil and playerMaterials[p] > 5) then
				playerMaterials[p] = playerMaterials[p] - 5
				playerCraftedMaterials[p] = playerCraftedMaterials[p] + 10
				outputChatBox("Materials crafted: " ..playerCraftedMaterials[p], p)
			else
				triggerClientEvent(p, "hideHint", p, hideDXHint)
				removeCommandHandler("stopmaterials")
				setPedAnimation (p, false)
				outputChatBox("You don't have enough materials left.", p, 255, 0, 0)
				if (isTimer(theTimer)) then
					killTimer(theTimer)
					outputChatBox("timer killed!")
				end
			end
		end, 3000, 0)
		addCommandHandler("stopmaterials", function()
			if (isTimer(theTimer)) then
				setPedAnimation (p, false)
				killTimer(theTimer)
				outputChatBox("You've now got: " ..playerCraftedMaterials[p].." crafted materials.", p, 255, 0, 0)
				triggerClientEvent(p, "hideHint", p, hideDXHint)
				outputChatBox("timer killed!")
			end
		end)
	end
end

addEvent("craftMaterials", true)

function handleCraftWeapons(weaponName, materials)
	if (client == source) then
		if (weaponName ~= nil and materials ~= nil) then
			if (playerCraftedMaterials[client] >= materials) then
				if (weaponName == "ak47") then
					giveWeapon ( client, 30 , 90, true )
				elseif (weaponName == "mp5") then
					giveWeapon ( client, 29 , 90, true )
				elseif( weaponName == "deserteagle") then
					giveWeapon ( client, 24 , 30, true )
				elseif (weaponName == "sniper") then
					giveWeapon ( client, 34 , 20, true )
				elseif (weaponName == "tec9") then
					giveWeapon ( client, 32 , 120, true )
				end
				playerCraftedMaterials[client] = playerCraftedMaterials[client] - materials
				outputChatBox("You made a " ..weaponName.. " and got: " ..playerCraftedMaterials[client].. " crafted materials left.", client, 0, 255, 0)
			else
				outputChatBox("You need atleast: " ..materials.." materials to make a: " ..weaponName, client, 255, 0, 0)
			end
		end
	end
end

addEvent("craftWeapon", true)


function handleMaterialMarkerHit(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement)) then
		triggerClientEvent(hitElement, "materialsInterface", hitElement, showMaterialsInterface)
	end
end	

function handleCraftingMarkerHit(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement)) then
		if (getMaterials(hitElement) ~= nil) then
			if (getMaterials(hitElement) > 0) then
				triggerClientEvent(hitElement, "craftMaterialsInterface", hitElement, showCraftMaterialsInterface, getMaterials(hitElement))
			else
				outputChatBox("You need atleast 1 material to start making crafted materials.", hitElement, 255, 0, 0)
			end
		end
	end
end

function handleCraftingWeaponMarkerHit(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement)) then
		triggerClientEvent(hitElement, "craftWeapon", hitElement, drawCreateWeaponInterface)
	end
end

addEventHandler("onMarkerHit", material_marker, handleMaterialMarkerHit)
addEventHandler("onMarkerHit", crafting_marker, handleCraftingMarkerHit)
addEventHandler("onMarkerHit", crafting_weapons_marker, handleCraftingWeaponMarkerHit)