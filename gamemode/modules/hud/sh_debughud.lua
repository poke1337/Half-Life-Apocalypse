if SERVER then

	hla.CreateHookServer( "hlaFinishedLoading" )

	hla.AddHookServer( "hlaFinishedLoading", "DebugHud", function()

		if !hla.Settings[ "DebugHud" ] then return end

		util.AddNetworkString( "ServersideHooksTable" )

		hla.CreateHookServer( "PlayerInitialSpawn" )

		net.Receive( "ServersideHooksTable", function( len, ply )

			net.Start( "ServersideHooksTable" )

				net.WriteUInt( table.Count( hla.Hooks ), 16 )

				for i, v in pairs( hla.Hooks ) do

					net.WriteString( i )
					net.WriteUInt( table.Count( hla.Hooks[ i ] ), 16 )

					for k, x in pairs( hla.Hooks[ i ] ) do
						
						net.WriteString( k )

					end

				end

			net.Send( ply )

		end )


	end )

end

if CLIENT then

	hla.CreateHookClient( "hlaFinishedLoading" )

	hla.AddHookClient( "hlaFinishedLoading", "DebugHud", function()

		hla.CreateHookClient( "HUDPaint" )

		local dot = "."

		hla.AddHookClient( "HUDPaint", "DebugHudLoad", function()

			local dots = "."

			if CurTime() > ( CurTime() + 0.1 ) then

				if dots == "..." then
			
					dots = "."

				else

					dots = dots .. dot

				end

			end

			draw.SimpleTextOutlined( "Loading" .. dots, "DebugFixedSmall", ScrW() * 0.001, 0, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP, 1, Color( 0, 0,0 ) )

		end )

		timer.Simple( 1, function() --> Replace with finished loading hook.

			hla.RemoveHookClient( "HUDPaint", "DebugHudLoad" )

			local ply = LocalPlayer()

			local debugTable = {}

			local function debugCreateText( text )

				if type( text ) ~= "string" then return end

				debugTable[ #debugTable + 1 ] = text

			end

			debugCreateText( "RunSpeed = " .. hla.Settings[ "RunSpeed" ] )
			debugCreateText( "WalkSpeed = " .. hla.Settings[ "WalkSpeed" ] )
			debugCreateText( "JumpSpeed = " .. hla.Settings[ "JumpSpeed" ] )
			debugCreateText( "DuckSpeed = " .. hla.Settings[ "DuckSpeed" ] )
			debugCreateText( "UnDuckSpeed = " .. hla.Settings[ "UnDuckSpeed" ] )
			debugCreateText( "GameState = " .. hla.Settings[ "GameState" ] )

			hla.AddHookClient( "HUDPaint", "DebugHud", function()

				for i = 1, #debugTable do
					
					draw.SimpleTextOutlined( debugTable[ i ], "DebugFixedSmall", ScrW() * 0.001, ScrH() * 0.01 * ( i - 1 ), Color( 255, 255, 255 ), TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP, 1, Color( 0, 0,0 ) )

				end

			end )

			debugCreateText( "" )
			debugCreateText( "Clientside Hooks:" )
			debugCreateText( "{" )

			for i, v in pairs( hla.Hooks ) do

				debugCreateText( "    " .. i .. " {"  )

				for k, x in pairs( hla.Hooks[ i ] ) do

					if k ~= #hla.Hooks[ i ] then
						
						debugCreateText( "        " .. "1" .. " = " .. k .. "," )

					else
					
						debugCreateText( "        " .. "1" .. " = " .. k .. " }" )

					end

				end

				debugCreateText( "    }" )
				debugCreateText( "" )

			end

			debugCreateText( "}" )

			debugCreateText( "" )
			debugCreateText( "Serverside Hooks:" )
			debugCreateText( "{" )

			net.Start( "ServersideHooksTable" )
			net.SendToServer()

			net.Receive( "ServersideHooksTable", function( len, ply )

				local num = net.ReadUInt( 16 )

				for i = 1, num do

					local string1 = net.ReadString()

					debugCreateText( "    " .. string1 .. " {" )

					local num2 = net.ReadUInt( 16 )

					for k = 1, num2 do

						local string2 = net.ReadString()
						
						if k ~= num2 then

							debugCreateText( "        " .. k .. " = " .. string2 .. "," )

						else

							debugCreateText( "        "  .. k .. " = " .. string2 .. " }" )

						end

					end

					debugCreateText( "" )

				end

				debugCreateText( "}" )

			end )

		end )

	end )

end
--DebugHud()