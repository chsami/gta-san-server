function showHelpScreen()
	if not (getWindowDisplayed()) then
		GUIEditor.window[1] = guiCreateWindow(0.28, 0.11, 0.49, 0.72, "Server help", true)
		guiWindowSetSizable(GUIEditor.window[1], false)

		GUIEditor.memo[1] = guiCreateMemo(57, 61, 696, 557, "Hello and welcome to our ghetto,\n\n\nCommands :\n\n/support - > for server information\n/semote - > stop doing an emote\n/dance - > dance\n/smoke - > smoke\n/ic - > trigger ingame character chat\n/oc - > trigger out of game character chat\n\nKey binds:\n\ntype \"i\" to check inventory/permits/current job\ntype \"o\" to check your character stats\n\nThe server currently plays in Los santos only, The only job that requires to go outside the boundaries of los santos is the pilot job.\n\nGangster job :\n\n- You can rob food stores eg : pizza, burger...\n- You can hack atm machines (they are displayed on the minimap with the green \"hack\" icon\n\nPilot job:\n\n-Fly passengers to their correct destination, get payed if you complete it\n\nPolice job :\n\n-Arrest People and put them in jail with help of a taser gun and police bat\n-Keep area's safe\n\nFarmer job:\n\n-Can farm coca plants (to make cocaine)\n-Can create cocaine by going to the farm\nProcess on how to make cocaine :\n Crack is made from cocaine -- a powdered drug that is derived from the leaves of the coca plant.\n How to get coca plants : Harvest them from the coca plantage nearby with the farming vehicle.\n How to get hydrochloric acid: Buy it from the medicine shop.\n How to get Potassium salt: Buy it form the medicine shop.\n How to get water: Use the pumps nearby.\n\nGym :\n\n-You can increase your character stamina and muscle  by visiting the gym which is indicated by the gym icon on the minimap\n\nPermits :\n\n-You'll need permits to drive certain vehicles or to execute certain fighting styles\n\n\nInterface:\n\n-Most interface have a red cross in the right corner, this is an easy way to close the interface\n\nTraveling system :\n\nOur travelling system is supported by the markers around the world, most of them will display their destination, use them to travel around or go by car/plane/bike\n\nDeath:\n\n-Will lose weapons on death\n\nTo contact the owner of the server mail to :\n\naintaro@hotmail.com\n\nEnjoy your stay en have fun!\n\n\nGreetz, Aintaro", false, GUIEditor.window[1])
		GUIEditor.button[1] = guiCreateButton(0.96, 0.04, 0.02, 0.02, "X", true, GUIEditor.window[1])
		guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")

		addEventHandler ( "onClientGUIClick", GUIEditor.button[1], closeHelpScreen, false)	
		showCursor(true)
	end
end

function handleShowHelpScreen()
	if not (isPedInVehicle(localPlayer)) then
		showHelpScreen()
	end
end

function showHelpScreenFromServer()
	if (localPlayer == source) then
		showHelpScreen()
	end
end

addEvent("showHelp", true)
addEventHandler("showHelp", localPlayer, showHelpScreenFromServer)

function closeHelpScreen()
	if (getWindowDisplayed()) then
		destroyAll()--destroy everything in the interface
		showCursor(false)
	end
end