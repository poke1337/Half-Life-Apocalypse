if CLIENT then

	local ply = LocalPlayer()

	local function GlobalLength( length, type )

		if type == w then
			
			return length * ( ScrW() / 1920 )

		elseif type == h then
			
			return length * ( ScrH() / 1080 )

		end

	end

	local function openMainMenu()

		local startTime = SysTime()

		local selectedModel

		local selectedColour

		gui.EnableScreenClicker( true )

		local main = vgui.Create( "DPanel" )

		main:SetSize( ScrW() / 1.5, ScrH() / 1.5 )
		main:Center()

		main.Paint = function( self, w, h )

			Derma_DrawBackgroundBlur( self, startTime ) -- Blur background

			surface.SetDrawColor( 200, 200, 200 )
			surface.DrawRect( 0, 0, w, h )

			DisableClipping( true )

			surface.SetDrawColor( 0, 0, 0, 255 )
			surface.DrawOutlinedRect( -1, -1, w + 2, h + 2 )

			DisableClipping( false )

		end

		local mX, mY, mW, mH = main:GetBounds()

		local cButton = vgui.Create( "DButton", main )

		cButton:SetPos( mW - GlobalLength( 15, w ), 0 )
		cButton:SetSize( GlobalLength( 15, w ), GlobalLength( 15, w ) )
		cButton:SetText( "x" )

		cButton.DoClick = function( self )

			main:Remove()

			gui.EnableScreenClicker( false )

		end

		local mdl = vgui.Create( "DModelPanel", main )

		mdl:SetModel( "models/player/kleiner.mdl" )
		mdl:SetPos( mW - GlobalLength( 275, w ), GlobalLength( 15, h ) )
		mdl:SetSize( GlobalLength( 250, w ), ScrH() / 1.5 - GlobalLength( 15, h ) )
		mdl:SetFOV( 36 )
		mdl:SetCamPos( Vector( 45, 0, 43 ) )
		mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 160, 80, 255 ) )
		mdl:SetDirectionalLight( BOX_LEFT, Color( 80, 160, 255, 255 ) )
		mdl:SetAmbientLight( Vector( -64, -64, -64 ) )
		mdl:SetAnimated( true )
		mdl.Angles = Angle( 0, 0, 0 )
		mdl:SetLookAt( Vector( -100, 0, 25 ) )

		local colourPicker = vgui.Create( "DColorMixer", main )

		colourPicker:SetPos( GlobalLength( 25, w ), mH / 1.87 )
		colourPicker:SetSize( mW - GlobalLength( 800, w ), mH / 2.25 )
		colourPicker:SetAlphaBar( false )
		colourPicker:SetWangs( true )
		colourPicker:SetPalette( false )

		colourPicker.ValueChanged = function()

			function mdl.Entity:GetPlayerColor()

				return Vector( colourPicker:GetVector().r, colourPicker:GetVector().g, colourPicker:GetVector().b, 1 )

			end

			selectedColour = Vector( colourPicker:GetVector().r, colourPicker:GetVector().g, colourPicker:GetVector().b, 1 )

		end

		local mdlSelectorScrollPanel = vgui.Create( "DScrollPanel", main )

		mdlSelectorScrollPanel:SetPos( mW - GlobalLength( 750, w ), GlobalLength( 30, h ) )
		mdlSelectorScrollPanel:SetSize( GlobalLength( 450, w ), ScrH() / 1.5 - GlobalLength( 45, h ) )

		mdlSelectorScrollPanel.Paint = function( self, w, h )

		DisableClipping( true )
			surface.SetDrawColor( 65, 133, 244, 255 )
			surface.DrawOutlinedRect( -1, -1, w + 2, h + 2 )
		DisableClipping( false )

		surface.SetDrawColor( 240, 240, 240, 255 )
		surface.DrawRect( 0, 0, w, h )

		end

		local SideBar = mdlSelectorScrollPanel:GetVBar()

		function SideBar:Paint( w, h )

			surface.SetDrawColor( 0, 0, 0, 0 )
			surface.DrawRect( 0, 0, w, h )

		end

		function SideBar.btnUp:Paint( w, h )

			surface.SetDrawColor( 65, 133, 244, 255 )
			surface.DrawRect( 0, 0, w, h )

			surface.SetDrawColor( 240, 240, 240, 255 )
			draw.NoTexture()
			surface.DrawPoly( {

	    			{ x = w / 2, y = h / 3 },
	    			{ x = w * ( 2 / 3 ), y = h * ( 2 / 3 ) },
	    			{ x = w / 3, y = h * ( 2 / 3 ) },
	    			
			 } )

		end

		function SideBar.btnDown:Paint( w, h )

			surface.SetDrawColor( 65, 133, 244, 255 )
			surface.DrawRect( 0, 0, w, h )

			surface.SetDrawColor( 240, 240, 240, 255 )
			draw.NoTexture()
			surface.DrawPoly( {

				{ x = w / 3, y = h / 3 },
	    			{ x = w * ( 2 / 3 ), y = h / 3 },
	    			{ x = w / 2, y = h * ( 2 / 3 ) },
	    			
			 } )

		end

		function SideBar.btnGrip:Paint( w, h )

			surface.SetDrawColor( 65, 133, 244, 255 )
			surface.DrawRect( 0, 0, w, h )

		end

		local mdlSelector = vgui.Create( "DIconLayout", mdlSelectorScrollPanel )

		mdlSelector:SetPos( 0, 0 )
		mdlSelector:SetSize( GlobalLength( 450, w ), ScrH() / 1.5 - GlobalLength( 45, h ) )
		mdlSelector:SetSpaceX( 1 )
		mdlSelector:SetSpaceY( 1 )

		for name, model in SortedPairs( player_manager.AllValidModels() ) do

			util.PrecacheModel( model )

			local icon = vgui.Create( "SpawnIcon", mdlSelector )

			icon:SetModel( model )
			icon:SetSize( GlobalLength( 64, w ), GlobalLength( 64, w ) )
			icon:SetTooltip( string.gsub( name, "^.", string.upper ) )

			icon.DoClick = function()

				mdl:SetModel( model )

				selectedModel = model

				function mdl.Entity:GetPlayerColor()

					return Vector( colourPicker:GetVector().r, colourPicker:GetVector().g, colourPicker:GetVector().b, 1 )

				end

				selectedColour = Vector( colourPicker:GetVector().r, colourPicker:GetVector().g, colourPicker:GetVector().b, 1 )

			end

			icon.Paint = function( self, w, h )

				surface.SetDrawColor( 0, 0, 0 )
				surface.DrawOutlinedRect( 0, 0, w, h )

				surface.SetDrawColor( 255, 255, 255 )
				surface.DrawRect( 1, 1, w - 2, h - 2 )

			end

		end

	end

	hla.CreateHookClient( "InitPostEntity" )

	hla.AddHookClient( "InitPostEntity", "createMainMenu", openMainMenu() )

else

	return

end