hla.CreateHookClient = function( hookName )

    for _, v in pairs( hook.GetTable() ) do

        if _G.type( v ) ~= "table" then continue end
        
        for hook, _ in pairs( v ) do
            
            if hookName == hook then return end

        end

    end

    _G.hook.Add( hookName, "hla_" .. hookName, function( ... )

        if _G.type( hla.Hooks[ hookName ] ) ~= "table" then return end

        local args = { ... }

        for identifier, _ in pairs( hla.Hooks[ hookName ] ) do

            if _G.type( hla.Hooks[ hookName ][ identifier ] ) ~= "function" then continue end
            local errors, errorMsg = _G.pcall( hla.Hooks[ hookName ][ identifier ]( unpack( args ) ), nil )

            if errors then
                
                local infoFunction = debug.getinfo( hla.Hooks[ hookName ][ identifier ], "S" )

                _G.ErrorNoHalt( errorMsg )
                _G.print( infoFunction.linedefined )

            end

        end

    end )

end

hla.AddHookClient = function( hookName, identifier, func )

    hla.Hooks[ hookName ] = hla.Hooks[ hookName ] or {}

    if _G.type( hla.Hooks[ hookName ][ identifier ] ) == "function" then
        
        local infoFunction = debug.getinfo( hla.Hooks[ hookName ][ identifier ], "S" )

        _G.ErrorNoHalt( "Hook Name: " .. "\'" .. hookName .. "\'" , "Identifier: " .. "\'" .. identifier .. "\'" .. " already exists on line " .. infoFunction.linedefined .. " " .. infoFunction.source )

    end

    hla.Hooks[ hookName ][ identifier ] = func

end

hla.RemoveHookClient = function( hookName, identifier )

    hla.Hooks[ hookName ][ identifier ] = nil

end