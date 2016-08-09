hla.CreateHookServer("PlayerDeathThink")

hla.AddHookServer("PlayerDeathThink", "Death thinking", function(ply)

	if ply:Team() == 0 then return false end --> Disallow spawning of joining players.

	if ply:Team() == 1 && hla.Settings["GameState"] == 0 then --> Allow respawn when the gamestate is in warmup
		
		return true

	end

	return false --> Don't allow players to respawn themself

end)