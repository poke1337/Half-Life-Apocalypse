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

		cButton:SetSize( GlobalLength( 100, w ), GlobalLength( 23, h ) )
		cButton:SetPos( mW - GlobalLength( 15, w ) - cButton:GetWide(), 2 )
		cButton:SetText( "Disconnect" )

		cButton.DoClick = function( self )

			surface.PlaySound( "garrysmod/ui_click.wav" )

  			LocalPlayer():ConCommand( "disconnect" )

		end

		function cButton:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 65, 133, 244, 255 ) )
			if cButton:IsHovered() then
				draw.RoundedBox( 0, 0, h - h * 0.10, w, h * 0.10, Color( 255, 80, 80 ) )  
				cButton:SetColor( Color( 255, 80, 80 ) )
			else
				draw.RoundedBox( 0, 0, h - h * 0.10, w, h * 0.10, Color( 255, 255, 255 ) )
				cButton:SetColor( Color( 255, 255, 255 ) )
			end
		end

		local mdl = vgui.Create( "DModelPanel", main )

		mdl:SetSize( GlobalLength( 340, w ), ScrH() / 1.5 - GlobalLength( 85, h ) )
		mdl:SetPos( mW - GlobalLength( 340, w ), GlobalLength( 30, h ) )
		mdl:SetFOV( 60 )
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
		mdlSelectorScrollPanel:SetSize( GlobalLength( 730, w ), ScrH() / 1.5 - GlobalLength( 45, h ) ) --> 730 Until you pick a model

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
		mdlSelector:SetSize( GlobalLength( 730, w ), ScrH() / 1.5 - GlobalLength( 45, h ) ) --> 730 Until you pick a model
		mdlSelector:SetSpaceX( 1 )
		mdlSelector:SetSpaceY( 1 )

		for name, values in hla.PModels do

			util.PrecacheModel( values.model )

			local icon = vgui.Create( "SpawnIcon", mdlSelector )

			icon:SetModel( values.model )
			icon:SetSize( GlobalLength( 64, w ), GlobalLength( 64, w ) )
			icon:SetTooltip( string.gsub( name, "^.", string.upper ) )

			icon.DoClick = function()

				surface.PlaySound( "garrysmod/ui_click.wav" )

				if !IsValid(selButton) then

					local selButton = vgui.Create( "DButton", main ) --> Create the continue button

					selButton:SetSize( GlobalLength( 340, w ), GlobalLength( 40, h ) )
					selButton:SetPos( mW - GlobalLength( 340, w ), mH - GlobalLength( 15, h ) - selButton:GetTall() )
					selButton:SetText( "Continue" )

					selButton.DoClick = function( self )

						surface.PlaySound( "garrysmod/ui_click.wav" )

						main:Remove()

						gui.EnableScreenClicker( false )

					end

					function selButton:Paint( w, h )
						draw.RoundedBox( 0, 0, 0, w, h, Color( 65, 133, 244, 255 ) )
						if selButton:IsHovered() then
							draw.RoundedBox( 0, 0, h - h * 0.10, w, h * 0.10, Color( 80, 255, 80 ) )  
							selButton:SetColor( Color( 80, 255, 80 ) )
						else
							draw.RoundedBox( 0, 0, h - h * 0.10, w, h * 0.10, Color( 255, 255, 255 ) )
							selButton:SetColor( Color( 255, 255, 255 ) )
						end
					end

				end

				if mdlSelector:GetWide() != GlobalLength( 400, w ) then

					mdlSelector:SetSize( GlobalLength( 400, w ), ScrH() / 1.5 - GlobalLength( 45, h ) ) --> Change to make space for the model panel
					mdlSelectorScrollPanel:SetSize( GlobalLength( 406, w ), ScrH() / 1.5 - GlobalLength( 45, h ) ) --> Change to make space for the model panel

				end

				mdl:SetModel( values.model )

				selectedModel = values.model

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

