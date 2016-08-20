hla.CreateHookServer("RoundEnd")
hla.CreateHookServer("Initialize")

local function CheckingAlivePlayers()

	if hla.Settings["GameState"] != 2 then return end

	local PlayerAlive = false

	for i=1,#player.GetAll() do

		if player.GetByID()[i]:IsValid() && player.GetByID()[i]:Alive() then 

			PlayerAlive = true
			break

		end

	end

	if !PlayerAlive then

		hook.Call("RoundEnd", 1)

	end

end

hla.AddHookServer("Initialize", "Map loaded dead checker", function()

	timer.Create("Dead Player Checker", 1, 0, function()

		CheckingAlivePlayers()

	end)

end)