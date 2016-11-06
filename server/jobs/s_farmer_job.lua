local SEED_TIMER = 15000 --15 seconds


local start_farmer_marker = createMarker(-1168, -1136, 128, "cylinder", 2, 0, 255, 0, 150)

function handleShowFarmerJobInterface(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement) and getElementType(hitElement) == "player") then
		triggerClientEvent(hitElement, "showFarmerJob", hitElement, drawFarmerJobInterface)
	end
end

addEventHandler("onMarkerHit", start_farmer_marker, handleShowFarmerJobInterface)


function addCocaine(thePlayer, add)
	local old = tonumber(getElementData(thePlayer,"cocaine"))
	if (old == nil) then old = 0 end
	local new = old + add
	setElementData(thePlayer,"cocaine",new)
	if (add > 0) then
		outputChatBox(" You managed to harvest : " ..add.. " plants of cocaine. You now have a total of : " ..new.." plants.", thePlayer)
	end
end

function getCocaine(thePlayer)
	if (getElementData(thePlayer, "cocaine")) then
		local cocaine = tonumber(getElementData(thePlayer,"cocaine"))
		return cocaine
	end
	return 0
end

function addPotaSalt(thePlayer, add)
	local old = tonumber(getElementData(thePlayer,"pota_salt"))
	if (old == nil) then old = 0 end
	local new = old + add
	setElementData(thePlayer,"pota_salt",new)
end

function getPotaSalt(thePlayer)
	if (getElementData(thePlayer, "pota_salt")) then
		local pota_salt = tonumber(getElementData(thePlayer,"pota_salt"))
		if (pota_salt == nil) then pota_salt = 0 end
		return pota_salt
	end
	return 0
end

function addHydroAcid(thePlayer, add)
	local old = tonumber(getElementData(thePlayer,"hydro_acid"))
	if (old == nil) then old = 0 end
	local new = old + add
	setElementData(thePlayer,"hydro_acid",new)
end

function getHydroAcid(thePlayer)
	if (getElementData(thePlayer, "pota_salt")) then
		local hydro_acid = tonumber(getElementData(thePlayer,"hydro_acid"))
		if (hydro_acid == nil) then hydro_acid = 0 end
		return hydro_acid
	end
	return 0
end

function addCrackProduced(thePlayer, add)
	local old = tonumber(getElementData(thePlayer,"crack_produced"))
	if (old == nil) then old = 0 end
	local new = old + add
	setElementData(thePlayer,"crack_produced",new)
	if (add > 0) then
		outputChatBox("Congratulations you produced "..add.."g crack cocaine. You now have a total of "..round(new, 2).."g crack cocaine.", thePlayer)
	end
end

function getCrackProduced(thePlayer)
	if (getElementData(thePlayer, "pota_salt")) then
		local crack_produced = tonumber(getElementData(thePlayer,"crack_produced"))
		if (crack_produced == nil) then crack_produced = 0 end
		return crack_produced
	end
	return 0
end

function addWaterBottles(thePlayer, add)
	local old = tonumber(getElementData(thePlayer,"water_bottles"))
	if (old == nil) then old = 0 end
	local new = old + add
	setElementData(thePlayer,"water_bottles",new)
	if (add > 0) then
		outputChatBox("You filled "..add.." bottle with water. You now have a total of "..new.." bottle(s) filled with water.", thePlayer)
	end
end

function getWaterBottles(thePlayer)
	if (getElementData(thePlayer, "pota_salt")) then
		local water_bottles = tonumber(getElementData(thePlayer,"water_bottles"))
		if (water_bottles == nil) then water_bottles = 0 end
		return water_bottles
	end
	return 0
end

function addCrackCreated(thePlayer, add)
	local old = tonumber(getElementData(thePlayer,"cocaine_creation"))
	if (old == nil) then old = 0 end
	local new = old + add
	setElementData(thePlayer,"cocaine_creation",new)
end


function getCrackCreated(thePlayer)
	if (getElementData(thePlayer, "pota_salt")) then
		local crack_created = tonumber(getElementData(thePlayer,"cocaine_creation"))
		if (crack_created == nil) then crack_created = 0 end
		return crack_created
	end
	return 0
end


function buyMedicine(productName)
	if (client == source) then
		local hydro_acid_price = 35
		local pota_salt_price = 20
		if (productName == "Hydrochloric_Acid") then
			if (getPlayerMoney(source) >= hydro_acid_price) then
				takePlayerMoney ( source, hydro_acid_price )
				outputChatBox("Congratulations you bought a 1L bottle of Hydrochloric_Acid for " ..hydro_acid_price.."$", source)
				addHydroAcid(source, 1)
			else
				outputChatBox("You do not have enough money!", source)
			end
		elseif (productName == "Potassium_Salt") then
			if (getPlayerMoney(source) >=  pota_salt_price) then
				takePlayerMoney ( source,  pota_salt_price )
				outputChatBox("Congratulations you bought a bottle containing 100 tablets of Potassium_Salt for " ..pota_salt_price.. "$", source)
				addPotaSalt(source, 100)
			else
				outputChatBox("You do not have enough money!", source)
			end
		end
	end
end

function getDrugsInv(creation)
	if (client == source) then
		local cocaine = tonumber(getCocaine(source))
			local pota_salt = tonumber(getPotaSalt(source))
			local hydro_acid = tonumber(getHydroAcid(source))
			local water_bottles = tonumber(getWaterBottles(source))
		if (creation) then
			triggerClientEvent("buildGrindCocaineInterface", getRootElement(), buildGrindCocaineInterface, source, cocaine, pota_salt, hydro_acid, water_bottles)
		else
			local crack_produced = tonumber(getCrackProduced(source))
			triggerClientEvent("displayDrugsInventory", getRootElement(), displayDrugsInventory, source, cocaine, pota_salt, hydro_acid, crack_produced, water_bottles)
		end
	end
end

function fillWaterBottle()
	if (client == source) then
		local thePlayer = source
		setPedAnimation( thePlayer, "FOOD", "FF_Sit_Eat3")
		setTimer(function() 
			addWaterBottles( thePlayer, 1)
			setPedAnimation( thePlayer, false)
		end, 3000, 1)
	end
end

function createCrackCocaine(par_hydro_acid, par_pota_salt, par_cocaine, par_water_bottles)
	if (client == source) then
		local cocaine = tonumber(getCocaine(source))
		local pota_salt = tonumber(getPotaSalt(source))
		local hydro_acid = tonumber(getHydroAcid(source))
		local water_bottles = tonumber(getWaterBottles(source))
		if (cocaine >= 5 and pota_salt >= 50 and hydro_acid >= 1 and water_bottles >= 1) then
			local farmerPoints = getJobAttribute(client, "farmer", getJobExperienceIndex())
			local formula = ((round(par_cocaine, 0)*4) + round(par_pota_salt,0) + (round(par_hydro_acid,0)*10) + (round(par_water_bottles,0)*10)) / 9
			addHydroAcid(source, -(round(par_hydro_acid,0)))
			addPotaSalt(source, -(round(par_pota_salt,0)))
			addWaterBottles(source, -(round(par_water_bottles,0)))
			addCocaine(source, -(round(par_cocaine,0)))
			addCrackCreated(source, round(formula, 2))
			serverOwnsPlayerPackage(source)
			--addCrackProduced(source, round(formula, 2))
			getDrugsInv(true)
			outputChatBox("You succesfully mixed the substances, your package has spawned.",source)
			farmerPoints = farmerPoints + 1
			setJobAttribute(client, "farmer", getJobExperienceIndex(), farmerPoints)
			outputChatBox("You earned +1 farming point, total of : " ..getJobAttribute(client, "farmer", getJobExperienceIndex()).." farming points", client)
			
		else
			outputChatBox("You do not have enough ingredients! Type 'i' to check your inventory", source)
		end
	end
end



function lootCocaine()
	if (client == source) then
		local amtCocaine = getElementData(client, "cocaine_creation")
		addCrackProduced(client, amtCocaine)
		setElementData(client, "cocaine_creation", 0)
		setElementData(client, "received_package", 0)
		
		
	end
end

function serverOwnsPlayerPackage(player)
	local account = getPlayerAccount ( player ) -- Get every player's account
	if ( not isGuestAccount ( account ) ) then -- For every player that's logged in....
		local checkCocaine = getElementData(player, "cocaine_creation")
		local checkPackage = getElementData(player, "received_package")
		if (checkCocaine ~= nil and checkCocaine > 0 and checkPackage == 0) then
			setElementData(player, "received_package", 1)
			triggerClientEvent("createCocainePickup", getRootElement(), createCocainePickup, player)
		end
	end
end

function harvestCocaine(amount)
	if (client == source) then
		addCocaine(source, amount)
	end--security
end

--CUSTOM EVENTS

addEvent("addCocaine", true)
addEventHandler("addCocaine", getRootElement(), harvestCocaine)

addEvent("lootCocaine", true)
addEventHandler("lootCocaine", getRootElement(), lootCocaine)

addEvent("createCrackCocaine", true)
addEventHandler("createCrackCocaine", getRootElement(), createCrackCocaine)

addEvent("fillWaterBottle", true)
addEventHandler("fillWaterBottle", getRootElement(), fillWaterBottle)

addEvent("getDrugsInv", true)
addEventHandler("getDrugsInv", getRootElement(), getDrugsInv)

addEvent("buyMedicine", true)
addEventHandler("buyMedicine", getRootElement(), buyMedicine)




--[[
				if etype == 'vehicle' then --if it's a vehicle, get it's controller.
				thePlayer = getVehicleController(hitElement)	
				return
				end
				]]