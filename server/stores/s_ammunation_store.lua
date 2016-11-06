local ammunation_7_marker = createMarker(308, -141, 999, "cylinder", 1, 255, 0, 0, 150)
setElementInterior(ammunation_7_marker, 7)

function hitAmmunationMarker(hitElement)
	if (isElement(hitElement)) then
		local account = getPlayerAccount ( hitElement )
		if (account) then
			if not(isGuestAccount ( account ) ) then 
				if (source == ammunation_7_marker) then
					triggerClientEvent("showAmmunationInterface", getRootElement(), showAmmunationInterface, hitElement)
				end
			end
		end
	end
end

function handleBuyWeapon(weaponName, weaponPrice, weaponAmmo)
	if (client == source) then
		if (getPlayerMoney(source) >= tonumber(weaponPrice)) then
			local weaponId = getWeaponIDFromName ( weaponName )
			giveWeapon ( source, weaponId , weaponAmmo)
			outputChatBox("You succesfully bought a " ..weaponName .. " for the price of " .. weaponPrice.."$", source)
			takePlayerMoney(source, tonumber(weaponPrice))
		else
			outputChatBox("You do not have enough money to buy this weapon.", source)
		end
	end
end

--CUSTOM EVENTS--

addEvent("handleBuyWeapon", true)
addEventHandler("handleBuyWeapon", getRootElement(), handleBuyWeapon)


--SERVER EVENT--

addEventHandler("onMarkerHit", getRootElement(), hitAmmunationMarker)