hla.CreateHookServer("PlayerDeath")
hla.CreateHookServer("KeyPress")

hla.AddHookServer("PlayerDeath", "Death Spectating", function(victim, inflictor, attacker)

	timer.Simple(3, function() --> Spectate when you die.

		if victim:IsValid() then

			victim:SetObserverMode(OBS_MODE_ROAMING)
			victim:SetMoveType(MOVETYPE_OBSERVER)

		end 

	end)

	hla.CreateHookServer( "KeyPress", "Spectating KeyPress", function(ply, key)

		if key == IN_ATTACK then --> Change who you are spectating.

			if !ply:Alive() then

				local randomplayer = table.Random(player.GetAll())

				if (randomplayer:IsValid() && randomplayer:Alive() && randomplayer != ply && randomplayer != ply:GetObserverTarget()) then

					if randomplayer == nil then return end
					ply:SpectateEntity(randomplayer)

				end 

			end

		end

		if key == IN_JUMP then --> Change your spectating mode.

			if !ply:Alive() then

				local randomplayer = table.Random(player.GetAll())
				if (randomplayer:IsValid() && randomplayer:Alive() && randomplayer != ply && randomplayer != ply:GetObserverTarget()) then

					if(randomplayer == nil) then return end
					ply:SpectateEntity(randomplayer)

				end 

				if ply:GetObserverMode() == 6 then

					ply:SetObserverMode(OBS_MODE_CHASE)

				elseif ply:GetObserverMode() == 5 then

					ply:SetObserverMode(OBS_MODE_ROAMING) 

				end

			end

		end

	end)

end)