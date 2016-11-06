





function handlePlayerDamage(attacker, weapon, bodypart, loss)
	if not (isLoggedIn(source)) then
		outputChatBox("hello", attacker)
		cancelEvent()
	end
end