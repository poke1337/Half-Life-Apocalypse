hla.CreateHookServer("PlayerHurt")
hla.CreateHookServer("KeyPress")

hla.AddHookServer("PlayerHurt", "Slowing Down Hurt Players", function( victim, attacker, healthRemaining, damageTaken )

	victim:SetNetworkedBool("BeingHurt", true)

	if damageTaken < hla.Settings["WalkSpeed"] then 

		victim:SetWalkSpeed(math.Clamp(hla.Settings["WalkSpeed"] - damageTaken, 1, hla.Settings["WalkSpeed"]))
		victim:SetRunSpeed(math.Clamp(hla.Settings["WalkSpeed"] - damageTaken, 1, hla.Settings["WalkSpeed"]))

	end

	if victim:Armor() < 1 then

		victim:ViewPunch(Angle(-(damageTaken*2), 0, 0))

	else

		victim:ViewPunch(Angle(-damageTaken, 0, 0))
	
	end

	timer.Create(victim:SteamID() .. "Hurt Slow Down", 0.5, 1, function()

		if victim:IsValid() then

			victim:SetWalkSpeed(hla.Settings["WalkSpeed"]) 
			victim:SetRunSpeed(hla.Settings["RunSpeed"])
			victim:SetNetworkedBool("BeingHurt", false)

		end 

	end) 

end)

hla.AddHookServer("KeyPress", "Anti Bhop", function(ply, key)

	if key == IN_JUMP then

		if ply:GetNetworkedBool("BeingHurt") == false then

			ply:SetWalkSpeed(hla.Settings[ "JumpSpeed" ])
			ply:SetRunSpeed(hla.Settings[ "JumpSpeed" ])

			timer.Create(ply:SteamID() .. "Jump Slow Down", 0.5, 1, function() 

				if ply:IsValid() then

					ply:SetWalkSpeed(hla.Settings["WalkSpeed"])
					ply:SetRunSpeed(hla.Settings["RunSpeed"]) 

				end 

			end) 

		end

	end

end)