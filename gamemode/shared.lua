GM.Version = "0.2.1"
GM.Name = "Half-Life: Apocalypse"
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

        if not G.type( hla.Hooks[ hookName ] ) ~= "table" then return end

        local args = { ... }
        print( unpack( args ) )

        for identifier, _ in pairs( hla.Hooks[ hookName ] ) do

            if G.type( hla.Hooks[ hookName ][ identifier ] ) ~= "function" then continue end
            local errors, errorMsg = G.pcall( hla.Hooks[ hookName ][ identifier ]( unpack( args ) ), nil )

            if errors then
                
                local infoFunction = debug.getinfo( hla.Hooks[ hookName ][ identifier ], "S" )

                G.ErrorNoHalt( errorMsg )
                G.print( infoFunction.linedefined )

            end

        end

    end )

end

hla.AddHook = function( hookName, identifier, func )

    hla.Hooks[ hookName ] = hla.Hooks[ hookName ] or {}

    if G.type( hla.Hooks[ hookName ][ identifier ] ) == "function" then
        
        local infoFunction = debug.getinfo( hla.Hooks[ hookName ][ identifier ], "S" )

        G.ErrorNoHalt( "Hook Name: " .. "\'" .. hookName .. "\'" , "Identifier: " .. "\'" .. identifier .. "\'" .. " already exists on line " .. infoFunction.linedefined .. " " .. infoFunction.source )

    end

    hla.Hooks[ hookName ][ identifier ] = func

end

hla.RemoveHook = function( hookName, identifier )

    hla.Hooks[ hookName ][ identifier ] = nil

end

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