local ply = LocalPlayer()

hla.CreateHookClient( "HUDPaint" )

hla.AddHookClient( "HUDPaint", "DebugHud", function()

	draw.SimpleText( "Testing1231231231233321313213213123131232131312313", "DermaDefault", 0, -50, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP, 1, Color( 0, 0,0 ) )

end )