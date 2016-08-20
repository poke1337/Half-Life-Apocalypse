GM.Version = "0.14.5"
GM.Name = "Half-Life: Apocalypse"
GM.Author = "Poke and Blue Badger"

DeriveGamemode( "base" )

hla = hla or {}
hla.Hooks = {}

print("----------------------------------")
print("--Starting setup of config files--")
print("----------------------------------")

for k,f in ipairs(file.Find(GM.FolderName .. "/gamemode/config/*", "LUA")) do

    local file = "config/" .. f

    if SERVER then

        AddCSLuaFile( file )
        print("AddCSLuaFile: " .. file )

    end

    include( file )

    print("Include: " .. file )

end

print("--------------------------")
print("--Config setup completed--")
print("--------------------------")

function GM:Initialize()

    print("-----------------------------------------")
    print("--Starting initializing of base classes--")
    print("-----------------------------------------")

    self.BaseClass.Initialize( self )

    print("----------------------------")
    print("--Initialization completed--")
    print("----------------------------")

end

print("---------------------------------")
print("--Starting setup of basemodules--")
print("---------------------------------")

local root = GM.FolderName .. "/gamemode/basemodules/"

print("Root folder: " .. root)

local _, folders = _G.file.Find( root .. "*", "LUA" )

for i = 1, #folders do

    for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sv*.lua", "LUA" ) ) do

        if SERVER then

            include( root .. folders[ i ] .. "/" .. file )
            print("Include: " .. file)

        end

    end

    for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sh*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )
            print("AddCSLuaFile: " .. file)

        end

        include( root .. folders[ i ] .. "/" .. file )
        print("Include: " .. file)

    end

    for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/cl*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )
            print("AddCSLuaFile: " .. file)

        end

        include( root .. folders[ i ] .. "/" .. file )
        print("Include: " .. file)

    end

end

print("-------------------------------")
print("--Basemodules setup completed--")
print("-------------------------------")

print("-----------------------------")
print("--Starting setup of modules--")
print("-----------------------------")

local root = GM.FolderName .. "/gamemode/modules/"

print("Root folder: " .. root)

local _, folders = _G.file.Find( root .. "*", "LUA" )

for i = 1, #folders do

    for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sv*.lua", "LUA" ) ) do

        if SERVER then

            include( root .. folders[ i ] .. "/" .. file )
            print("Included: " .. file )

        end

    end

    for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/sh*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )
            print("AddCSLuaFile: " .. file)

        end

        include( root .. folders[ i ] .. "/" .. file )
        print("Included: " .. file )

    end

    for k, file in SortedPairs( _G.file.Find( root .. folders[ i ] .. "/cl*.lua", "LUA" ) ) do

        if SERVER then

            AddCSLuaFile( root .. folders[ i ] .. "/" .. file )
            print("AddCSLuaFile: " .. file)


        end

        include( root .. folders[ i ] .. "/" .. file )
        print("Included: " .. file )

    end

end

print("---------------------------")
print("--Modules setup completed--")
print("---------------------------")