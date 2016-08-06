hla.CreateHookServer("RoundStart")
hla.CreateHookServer("PlayerDisconnected") --> Use on player disconnect hook.
hla.CreateHookServer("ShowSpare2") --> Use the F4 hook.

--> Remove a players vote if they voted and then disconnected.
hla.AddHookServer("PlayerDisconnected", "Remove start vote", function(ply)

	for i=1,#hla.Settings["iVoted"] do

		if ply == hla.Settings["iVoted"][i] then
			
			table.RemoveByValue(hla.Settings["iVoted"], i)
			break

		end

	end

end)

--> Player vote to start the round.
hla.AddHookServer("ShowSpare2", "Vote to start button", function(ply)

	table.insert(hla.Settings["iVoted"], ply)

	if #player.GetAll() * hla.Settings["fProcentVote"] <= #hla.Settings["iVoted"] then
		
		table.Empty(hla.Settings["iVoted"])
		hook.Call("RoundStart", #player.GetAll())

	end

end
