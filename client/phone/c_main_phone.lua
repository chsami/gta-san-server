function handleIphoneInterface()
	if not (getButtonDisplayed()) then
	   GUIEditor.button[1] = guiCreateButton(0.77, 0.79, 0.04, 0.06, "", true)
        guiSetAlpha(GUIEditor.button[1], 0.10)


        GUIEditor.button[2] = guiCreateButton(0.81, 0.79, 0.04, 0.06, "", true)
        guiSetAlpha(GUIEditor.button[2], 0.10)


        GUIEditor.button[3] = guiCreateButton(0.85, 0.79, 0.04, 0.06, "", true)
        guiSetAlpha(GUIEditor.button[3], 0.10)


        GUIEditor.button[4] = guiCreateButton(0.88, 0.79, 0.04, 0.06, "", true)
        guiSetAlpha(GUIEditor.button[4], 0.10)    
		
		GUIEditor.button[5] = guiCreateButton(0.82, 0.88, 0.04, 0.06, "", true)
        guiSetAlpha(GUIEditor.button[5], 0.00)


        GUIEditor.label[1] = guiCreateLabel(1239, 802, 60, 30, "Close - >", false)    
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handlePhoneListBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleMailListBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[3], handleSafariBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[4], handleMusicBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[5], closeIphoneInterface, false)
		showCursor(true)
		guiSetInputEnabled(true)
	end
end

function handleSamsungInterface()
	if not (getButtonDisplayed()) then
		  GUIEditor.button[1] = guiCreateButton(0.78, 0.75, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[1], 0.00)


        GUIEditor.button[2] = guiCreateButton(0.80, 0.75, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[2], 0.00)


        GUIEditor.button[3] = guiCreateButton(0.83, 0.75, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[3], 0.00)


        GUIEditor.button[4] = guiCreateButton(0.86, 0.75, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[4], 0.00)


        GUIEditor.button[5] = guiCreateButton(0.88, 0.75, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[5], 0.00)


        GUIEditor.button[6] = guiCreateButton(0.78, 0.66, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[6], 0.00)


        GUIEditor.button[7] = guiCreateButton(0.81, 0.66, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[7], 0.00)


        GUIEditor.button[8] = guiCreateButton(0.84, 0.66, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[8], 0.00)


        GUIEditor.button[9] = guiCreateButton(0.88, 0.66, 0.03, 0.05, "", true)
        guiSetAlpha(GUIEditor.button[9], 0.00)
		  GUIEditor.button[10] = guiCreateButton(1261, 745, 184, 32, "", false)
        guiSetAlpha(GUIEditor.button[10], 0.07) 
		addEventHandler("onClientGUIClick", GUIEditor.button[1], handleSamsungPhoneListBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], handleSamsungPhoneListBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[3], handleSamsungPhoneListBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[4], handleSamsungPhoneListBtn, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[10], closeSamsungBtn, false)
		showCursor(true)
		guiSetInputEnabled(true)
	end
end

function closeSamsungBtn()
	destroyAll()
	showCursor(false)
	hideSamsung()
	guiSetInputEnabled(false)
end

function handleSamsungPhoneListBtn()
	if (getButtonDisplayed()) then
		closeSamsungBtn()
		drawFriendsListInterface()
	end
end

function closeIphoneInterface()
	destroyAll()
	showCursor(false)
	hideIphone()
	guiSetInputEnabled(false)
end

function handlePhoneListBtn()
	if (getButtonDisplayed()) then
		closeIphoneInterface()
		drawFriendsListInterface()
	end
end

function handleMailListBtn()
	if (getButtonDisplayed()) then
		closeIphoneInterface()
		drawFriendsListInterface()
	end
end

function handleSafariBtn()
	if (getButtonDisplayed()) then
		outputChatBox("You pressed the button but nothing happened...")
	end
end

function handleMusicBtn()
	if (getButtonDisplayed()) then
		outputChatBox("Your phone started playing music...")
	end
end


function handleSamsungDx()
	dxDrawImage ( 1100/1600*screenWidth, 300/900*screenHeight, 500/1600*screenWidth, 500/900*screenHeight, 'conf/images/samsung.png')
end

function showSamsung()
	outputChatBox("You took your phone out of your pocket...", 0, 150, 150)
	handleSamsungInterface()
	addEventHandler("onClientRender", root, handleSamsungDx)
end

function hideSamsung()
	outputChatBox("You put the phone back in your pocket...", 0, 150, 150)
	removeEventHandler("onClientRender", root, handleSamsungDx)
end


function handleIphoneDx()
	dxDrawImage ( 1200/1600*screenWidth, 250/900*screenHeight, 300/1600*screenWidth, 621/900*screenHeight, 'conf/images/iphone.png')
end

function showIphone()
	handleIphoneInterface()
	addEventHandler("onClientRender", root, handleIphoneDx)
end

function hideIphone()
	removeEventHandler("onClientRender", root, handleIphoneDx)
end


addCommandHandler("iphone", showIphone)
addCommandHandler("samsung", showSamsung)

local shovel_object = nil


function shovel() --Carry liftup and liftdown
	local counter = 1
	
	setTimer(function()
		if (counter == 1) then
			setPedAnimation(localPlayer, "CARRY", "liftup", -1, false)
			counter = counter + 1
			
			shovel_object = createObject(2936, 0, 0, 10)
			setObjectBreakable ( shovel_object, true )
			setObjectScale(shovel_object, randomFloat(0.1, 0.7, 1))
			exports.bone_attach:attachElementToBone(shovel_object,localPlayer,4,0,0.5,-0.5,0,0,0)
		else
			setPedAnimation(localPlayer, "CARRY", "putdwn", -1, false)
			exports.bone_attach:detachElementFromBone(shovel_object)
			--setObjectMass ( shovel_object, 0 )
			--breakObject ( shovel_object)
			destroyElement(shovel_object)
			counter = 1
		end
	end, 1500, 10)
	
end

addCommandHandler("giveshovel", shovel)