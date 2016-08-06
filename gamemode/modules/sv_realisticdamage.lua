hla.CreateHookServer("ScalePlayerDamage")
hla.CreateHookServer("ScaleNPCDamage")

hla.AddHookServer("ScalePlayerDamage", "Realistic player damage", function(ply, hitgroup, dmginfo)

	if(hitgroup == HITGROUP_GENERIC && ply:Armor() == 0) then dmginfo:ScaleDamage(1.8) end

	if(hitgroup == HITGROUP_HEAD 		&& ply:Armor() == 0) then dmginfo:ScaleDamage(2) end
	if(hitgroup == HITGROUP_HEAD 		&& ply:Armor() > 0) then dmginfo:ScaleDamage(1.5) end

	if(hitgroup == HITGROUP_CHEST 	&& ply:Armor() == 0) then dmginfo:ScaleDamage(1.8) end
	if(hitgroup == HITGROUP_CHEST 	&& ply:Armor() > 0) then dmginfo:ScaleDamage(1.5) end

	if(hitgroup == HITGROUP_STOMACH && ply:Armor() == 0) then dmginfo:ScaleDamage(1.5) end

	if(hitgroup == (HITGROUP_LEFTLEG || HITGROUP_RIGHTLEG || HITGROUP_LEFTARM || HITGROUP_RIGHTARM)) then dmginfo:ScaleDamage(0.5) end

end)

hla.AddHookServer("ScaleNPCDamage", "Realistic NPC Damage", function(npc, hitgroup, dmginfo)

	if(hitgroup == HITGROUP_HEAD) then dmginfo:ScaleDamage(2) end

end)


