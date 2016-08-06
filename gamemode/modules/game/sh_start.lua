local iVoted 				= {}
local fProcentVote	= 0.67

if CLIENT then return end --> Remove this and the locals above when we get a settings file. And change the file to a server file.

hla.CreateHook("RoundStart")
hla.CreateHook("PlayerDisconnected") --> Use on player disconnect hook.
hla.CreateHook("ShowSpare2") --> Use the F4 hook.

--> Remove a players vote if they voted and then disconnected.
hla.AddHook("PlayerDisconnected", "Remove start vote", function(ply)

	for i=1,#iVoted do

		if ply == iVoted[i] then
			
			table.RemoveByValue(iVoted, i)
			break

		end

	end

end)

--> Player vote to start the round.
hla.AddHook("ShowSpare2", "Vote to start button", function(ply)

	table.insert(iVoted, ply)

	if #player.GetAll() * fProcentVote <= #iVoted then
		
		table.Empty( iVoted )
		hook.Call("RoundStart", #player.GetAll())

	end

end
