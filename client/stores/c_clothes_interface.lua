function createSkinPickGui()
	if (source == localPlayer) then
    	if not (getWindowDisplayed()) then
	        GUIEditor.window[1] = guiCreateWindow(100, 86, 594, 629, "Skinpanel", false)
	        guiWindowSetSizable(GUIEditor.window[1], false)
	        guiSetProperty(GUIEditor.window[1], "CaptionColour", "FF03F80F")
	        GUIEditor.gridlist[1] = guiCreateGridList(32, 224, 227, 295, false, GUIEditor.window[1])
	        guiGridListAddColumn(GUIEditor.gridlist[1], "Ids", 0.5)
	        guiGridListAddColumn(GUIEditor.gridlist[1], "Skins", 0.5)
	        aSkins = aLoadSkins ( )
	        aListSkins (1)
	        GUIEditor.label[1] = guiCreateLabel(53, 188, 151, 26, "Choose your skin :", false, GUIEditor.window[1])
	        guiSetFont(GUIEditor.label[1], "default-bold-small")
	        guiLabelSetColor(GUIEditor.label[1], 252, 1, 1)
	        GUIEditor.button[1] = guiCreateButton(443, 561, 110, 38, "Buy", false, GUIEditor.window[1])
	        guiSetFont(GUIEditor.button[1], "default-bold-small")
	        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFF2F507")    
	        addEventHandler ( "onClientGUIClick", GUIEditor.window[1], aClientSkinClick )
	        addEventHandler("onClientGUIClick", GUIEditor.button[1], clientBuySkin)
			guiSetInputEnabled(true)
			showCursor(true)
     	end   
	end
end
	


function aLoadSkins ()
	local table = {}
	local node = xmlLoadFile ( "conf/skins.xml" )
	if ( node ) then
		local groups = 0
		while ( xmlFindChild ( node, "group", groups ) ~= false ) do
			local group = xmlFindChild ( node, "group", groups )
			local groupn = xmlNodeGetAttribute ( group, "name" )
			table[groupn] = {}
			local skins = 0
			while ( xmlFindChild ( group, "skin", skins ) ~= false ) do
				local skin = xmlFindChild ( group, "skin", skins )
				local id = #table[groupn] + 1
				table[groupn][id] = {}
				table[groupn][id]["model"] = xmlNodeGetAttribute ( skin, "model" )
				table[groupn][id]["name"] = xmlNodeGetAttribute ( skin, "name" )
				skins = skins + 1
			end
			groups = groups + 1
		end
		xmlUnloadFile ( node )
	else
		outputChatBox("Failed to load xml")
		end
	return table
end

function aListSkins ( mode )
guiGridListClear ( GUIEditor.gridlist[1] )
	if ( mode == 1 ) then --Normal
		local skins = {}
		for name, group in pairs ( aSkins ) do
			if (name ~= "Special" or name == "Special" and getVersion().number >= 272) then
				for id, skin in pairs ( group ) do
					local id = tonumber ( skin["model"] )
					skins[id] = skin["name"]
				end
			end
		end
		local i = 0
		while ( i <= 300) do
			if ( skins[i] ~= nil) then
				if (i < 274 or i > 288 or i == 70 or i == 71) then
				local row = guiGridListAddRow ( GUIEditor.gridlist[1] )
				guiGridListSetItemText ( GUIEditor.gridlist[1], row, 1, tostring ( i ), false, true )
				guiGridListSetItemText ( GUIEditor.gridlist[1], row, 2, skins[i], false, false )
				end
			end
			i = i + 1
		end
		guiGridListSetSortingEnabled ( GUIEditor.gridlist[1], true )
		end
end

function clientBuySkin()
	if (getWindowDisplayed()) then --checks if the window exists
		local skinId = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
		triggerServerEvent("newSkin", getLocalPlayer(), skinId)
		destroyAll()
		setPedAnimation ( getLocalPlayer(), false)
		guiSetInputEnabled(false)
		showCursor(false)
	end
end

function aClientSkinClick(button, state) --sets the skin temp for the player
	if ( button == "left" ) then
		if ( source == GUIEditor.gridlist[1] ) then
			if ( guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ) ~= -1 ) then
				local skinId = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), 1 )
				setElementModel ( getLocalPlayer(), skinId )
				local randomAnimation = math.random(3)
				if (randomAnimation == 1) then
					setPedAnimation ( getLocalPlayer(), "DEALER", "DEALER_IDLE_01")
				elseif (randomAnimation == 2) then
					setPedAnimation ( getLocalPlayer(), "DEALER", "DEALER_IDLE_02")
				elseif (randomAnimation == 3) then
					setPedAnimation ( getLocalPlayer(), "DEALER", "DEALER_IDLE_03")
				end	
			end
		end
	end
end


--CUSTOM EVENTS--

addEvent("skinGui", true)
addEventHandler("skinGui", localPlayer, createSkinPickGui)