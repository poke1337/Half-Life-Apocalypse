hla = hla or {}
hla.Hooks = {}
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "config/config.lua" )

include( "shared.lua" )
include( "config/config.lua" )