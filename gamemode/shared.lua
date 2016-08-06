local _G = table.Copy( _G )

local _, folders = _G.file.Find( "gamemode/modules/*", "LUA" )

for i = 1, #folders do

    for k, file in SortedPairs( _G.file.Find( folders[ i ] .. "/sv*.lua", "LUA" ) ) do

        if SERVER then
            
            include( file )

        end

    end

    for k, file in SortedPairs( _G.file.Find( folders[ i ] .. "/sh*.lua", "LUA" ) ) do

        if SERVER then
            
            AddCSLuaFile( file )
            include( file )

        else

            include( file )

        end

    end

    for k, file in SortedPairs( _G.file.Find( folders[ i ] .. "/cl*.lua", "LUA" ) ) do

        if SERVER then
            
            AddCSLuaFile( file )

        else

            include( file )

        end

    end

end