GM.Version  = "0.3.0"
GM.Name     = "Half-Life: Apocalypse"
GM.Author   = "Poke and Blue Badger"
GM.Path     = "gamemodes/hla/gamemode"

DeriveGamemode( "base" )

local G = table.Copy( _G )

function GM:Initialize()

  self.BaseClass.Initialize( self )

end

function GM:LoadAll(folder, noinclude, noadd)

  local path = { GM.Path, folder, "*.lua" }
  
  for k,v in ipairs( file.Find( table.concat( path, "/" ), "GAME" ) ) do

    local file = folder .. "/" .. v

    if SERVER && !noadd then

      print( "Added " .. folder .. " file: " .. v )
      AddCSLuaFile( file )

    end

    if CLIENT || ( SERVER && !noinclude ) then

      print( "Included " .. folder .. " file: " .. v )
      include( file )

    end

  end

end

print( "GAMEMODE INITIALIZATION" )

GM:LoadAll( "shared" )
GM:LoadAll( "client", true )

if SERVER then

  GM:LoadAll( "server", false, true )

end

print( "GAMEMODE LOADED" )
