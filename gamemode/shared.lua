GM.Version = "0.0.2"
GM.Name = "hla"
GM.Author = "Poke and Blue Badger"

DeriveGamemode( "base" )

local G = table.Copy( _G )

function GM:Initialize()

    self.BaseClass.Initialize( self )

end

hla = {}
hla.Hooks = {}

hla.CreateHook = function( hookName )

    G.hook.Add( hookName, "hla_" .. hookName, function( ... )

        for i = 1, #hla.Hooks[ hookName ] do
            
            local errors, errorMsg = G.pcall( hla.Hooks[ hookName ][ i ](), G.unpack( arg, 1, n ) )

            if errors then
                
                local infoFunction = debug.getinfo( hla.Hooks[ hookName ][ i ], "l" )

                G.ErrorNoHalt( errorMsg )
                G.print( infoFunction.linedefined )

            end

        end

    end )

end

hla.AddHook = function( hookName, func )

    hla.Hooks[ hookName ][ #hla.Hooks[ hookName ] + 1 ] = func

end

hla.CreateHook( "Think" )
hla.AddHook( "Think", function()

    print("hi")

end )

local root = GM.FolderName .. "/gamemode/modules/"

local _, folders = G.file.Find( root .. "*", "LUA" )

for i = 1, #folders do

    for k, file in SortedPairs( G.file.Find( root .. folders[ i ] .. "/sv*.lua", "LUA" ) ) do

        if SERVER then

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

    for k, file in SortedPairs( G.file.Find( folders[ i ] .. "/sh*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )
            include( root .. folders[ i ] .. "/" .. file )

        else

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

    for k, file in SortedPairs( G.file.Find( folders[ i ] .. "/cl*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )

        else

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

end