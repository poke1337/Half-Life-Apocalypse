hla.CreateHookServer("PlayerSpawn")

hla.AddHookServer("PlayerSpawn", "No player collision", function(ply)

	timer.Simple(0.1,function()

		if ply:IsValid() then

			ply:SetCollisionGroup(15)

		end

	end )

	ply:SetMoveType(MOVETYPE_WALK)

end)