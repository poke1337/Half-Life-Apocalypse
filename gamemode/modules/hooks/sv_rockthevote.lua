hla.CreateHookServer("RoundEnd")
hla.CreateHookServer("PlayerDisconnected") --> Use on player disconnect hook.
hla.CreateHookServer("ShowSpare1") --> Use the F3 hook.

--> Remove a players vote if they voted and then disconnected.
hla.AddHookServer("PlayerDisconnected", "Remove rtv vote", function(ply)

	for i=1,#hla.Settings["iVotedRTV"] do

		if ply == hla.Settings["iVotedRTV"][i] then
			
			table.RemoveByValue(hla.Settings["iVotedRTV"], i)
			break

		end

	end

end)

--> Player vote to start the round.
hla.AddHookServer("ShowSpare1", "Vote to change map button", function(ply)

	table.insert(hla.Settings["iVotedRTV"], ply)

	if #player.GetAll() * hla.Settings["fProcentVote"] <= #hla.Settings["iVotedRTV"] then
		
		table.Empty(hla.Settings["iVotedRTV"])
		hook.Call("RoundEnd", 3)

	end

end )

