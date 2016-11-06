local ammunation_7
local general_store
local criminal
local basket = createObject(1885, 0, 0, 2000)
setElementInterior(basket, 16)

function loadPedsInterior()
	if (source == localPlayer) then
		ammunation_7 = createPed ( 179, 308, -143, 1000)
		setElementInterior(ammunation_7, 7)
		general_store = createPed (183, -22.5, -140.3, 1003.5)
		setElementInterior(general_store, 16)
		setElementRotation ( general_store, 369,-4.7, 1100)
		if (getElementInterior(localPlayer) == 16) then
			exports.bone_attach:attachElementToBone(basket,localPlayer,16,0.6,0,0,175,10,250)
		end
	end
end

function loadPedsWorldMap()
	criminal = createPed(271, 1009, -1370, 13.5)
end

function destroyPedsWorldMap()
	destroyElement(criminal)
end


function destroyPedsInterior()
	if (source == localPlayer) then
		if (isElement(ammunation_7) and isElement(pizzaMan) and isElement(general_store)) then
			destroyElement(ammunation_7)
			destroyElement(pizzaMan)
			destroyElement(general_store)
		end
		if (isElement(basket) and basket ~= nil) then
			if (exports.bone_attach:isElementAttachedToBone(basket)) then
				exports.bone_attach:detachElementFromBone(basket)
				outputChatBox("Destroy")
			end
		end
	end
end


addEvent("destroyPeds", true)
addEventHandler("destroyPeds", localPlayer, destroyPedsInterior)

addEvent("loadPeds", true)
addEventHandler("loadPeds", localPlayer, loadPedsInterior)

addEvent("loadPedsWorld", true)
addEventHandler("loadPedsWorld", localPlayer, loadPedsWorldMap)

addEvent("destroyPedsWorld", true)
addEventHandler("destroyPedsWorld", localPlayer, destroyPedsWorldMap)