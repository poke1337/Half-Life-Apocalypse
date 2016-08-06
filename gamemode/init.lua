AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

hla = hla or {}

AddCSLuaFile( "config/config.lua" )

include( "shared.lua" )
include( "config/config.lua" )