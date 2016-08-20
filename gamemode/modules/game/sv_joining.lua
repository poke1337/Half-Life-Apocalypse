hla.CreateHookServer("PlayerInitialSpawn")
hla.CreateHookServer("PlayerSpawn")

hla.AddHookServer("PlayerInitialSpawn", "Set player team", function(ply)

	ply:SetTeam(0)

end )

hla.AddHookServer("PlayerSpawn", "Joining restrictions", function(ply)

	if ply:Team() == 0 then
		
		ply:KillSilent()

		ply:SetObserverMode(OBS_MODE_IN_EYE)
		ply:SetMoveType(MOVETYPE_NONE)

		for i=1,#player.GetAll() do --> Spectate a player if there are any alive
			
			if player.GetAll(i):IsValid() && player.GetAll(i):Alive() && player.GetAll(i) != ply:GetObserverTarget() then

				ply:SpectateEntity(player.GetAll(i))

			end

		end

	end

end )