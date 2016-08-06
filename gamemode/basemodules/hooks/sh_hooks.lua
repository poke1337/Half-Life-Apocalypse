hla.CreateHook = function( hookName )

    for _, v in pairs( hook.GetTable() ) do

        if G.type( v ) ~= "table" then continue end
        
        for hook, _ in pairs( v ) do
            
            if hookName == hook then return end

        end

    end

    G.hook.Add( hookName, "hla_" .. hookName, function( ... )

        if G.type( hla.Hooks[ hookName ] ) ~= "table" then return end

        local args = { ... }

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