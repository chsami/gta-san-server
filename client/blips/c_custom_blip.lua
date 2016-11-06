addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
	function()
		exports.customblips:createCustomBlip ( 819, -1350, 15, 15, "conf/images/blips/icon.png" )
		exports.customblips:createCustomBlip ( 1948, -1768, 15, 15, "conf/images/blips/fuel.png" )
		exports.customblips:createCustomBlip ( 1084, -1245, 15, 15, "conf/images/blips/materials.png" )
		exports.customblips:createCustomBlip ( 1421, -1316, 15, 15, "conf/images/blips/materials.png" )
	end
)


--Add blip table information