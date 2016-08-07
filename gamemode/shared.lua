GM.Version = "0.9.0"
GM.Name = "Half-Life: Apocalypse"
GM.Author = "Poke and Blue Badger"

DeriveGamemode( "base" )

hla = hla or {}

function GM:Initialize()

    self.BaseClass.Initialize( self )

end

local root = GM.FolderName .. "/gamemode/basemodules/"

local _, folders = _G.file.Find( root .. "*", "LUA" )

for i = 1, #folders do

    for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sv*.lua", "LUA" ) ) do

        if SERVER then

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

    for k, file in SortedPairs( _G.file.Find( folders[ i ] .. "/sh*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )
            include( root .. folders[ i ] .. "/" .. file )

        else

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

    for k, file in SortedPairs( _G.file.Find( folders[ i ] .. "/cl*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )

        else

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

end

local root = GM.FolderName .. "/gamemode/modules/"

local _, folders = _G.file.Find( root .. "*", "LUA" )

for i = 1, #folders do

    for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sv*.lua", "LUA" ) ) do

        if SERVER then

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

    for k, file in SortedPairs( _G.file.Find( folders[ i ] .. "/sh*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )
            include( root .. folders[ i ] .. "/" .. file )

        else

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

    for k, file in SortedPairs( _G.file.Find( folders[ i ] .. "/cl*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )

        else

            include( root .. folders[ i ] .. "/" .. file )

        end

    end

end
