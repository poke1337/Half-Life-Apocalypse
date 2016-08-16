GM.Version = "0.12.0"
GM.Name = "Half-Life: Apocalypse"
GM.Author = "Poke and Blue Badger"

DeriveGamemode( "base" )

hla = hla or {}
hla.Hooks = hla.Hooks or {}

for k,f in ipairs(file.Find(GM.FolderName .. "/gamemode/config/*", "LUA")) do

    local file = "config/" .. f

    if SERVER then

        AddCSLuaFile( file )

    end

    include( file )

end

function GM:Initialize()

    self.BaseClass.Initialize( self )

end

if SERVER then

    hla.LoadModulesServer = function( root )

        local _, folders = _G.file.Find( root .. "*", "LUA" )

        for i = 1, #folders do

            for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sv*.lua", "LUA" ) ) do

                include( root .. folders[ i ] .. "/" .. file )

            end

            for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sh*.lua", "LUA" ) ) do

                AddCSLuaFile( root .. folders[ i ] .. "/" .. file )
                include( root .. folders[ i ] .. "/" .. file )

            end

            for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/cl*.lua", "LUA" ) ) do

                AddCSLuaFile( root .. folders[ i ] .. "/" .. file )

            end

        end

    end

else

    hla.LoadModulesClient = function( root )

        local _, folders = _G.file.Find( root .. "*", "LUA" )

        for i = 1, #folders do

            for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sh*.lua", "LUA" ) ) do

                include( root .. folders[ i ] .. "/" .. file )

            end

            for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/cl*.lua", "LUA" ) ) do

                include( root .. folders[ i ] .. "/" .. file )

            end

        end

    end

end

if SERVER then

    hla.LoadModulesServer( GM.FolderName .. "/gamemode/basemodules/" )

else

    hla.LoadModulesClient( GM.FolderName .. "/gamemode/basemodules/" )

end

if SERVER then

    hla.LoadModulesServer( GM.FolderName .. "/gamemode/modules/" )

else

    hla.LoadModulesClient( GM.FolderName .. "/gamemode/modules/" )

end