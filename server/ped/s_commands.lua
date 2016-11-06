

function dance(p)
	if (isElement(p) and isLoggedIn(p)) then
		setPedAnimation ( p, "DANCING", "dance_loop", -1, true, false, false)
	end
end

function smoke(p)
	if (isElement(p) and isLoggedIn(p)) then
		setPedAnimation ( p, "SHOP", "Smoke_RYD", -1, true, false, false)
	end
end

function stopEmote(p, commandName)
	if (isElement(p) and isLoggedIn(p)) then
		setPedAnimation(p, false)
	end
end

function serverHelp(p, commandName)
	if (isElement(p) and isLoggedIn(p)) then
		triggerClientEvent(p, "showHelp", p, showHelpScreenFromServer)
	end
end

addCommandHandler("semote", stopEmote)
addCommandHandler("dance", dance)
addCommandHandler("smoke", smoke)
addCommandHandler("support", serverHelp)