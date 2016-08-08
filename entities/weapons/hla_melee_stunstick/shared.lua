if SERVER then

	AddCSLuaFile ("shared.lua")

	SWEP.Weight 						= 5
	SWEP.AutoSwitchTo 			= false
	SWEP.AutoSwitchFrom 		= false
 
elseif CLIENT then

	//killicon.Add( "hla_ranged_pistol", "hud/killicons/pistol", Color( 255, 100, 20, 255 ) )
	
	//SWEP.WepSelectIcon 		= surface.GetTextureID("hud/killicons/pistol" )
	SWEP.PrintName 					= "HL:A StunStick"
 
	//Sets the position of the weapon in the switching menu 
	//(appears when you use the scroll wheel or keys 1-6 by default)
	--Handguns = 1
	--Rifles = 2
	--Heavy = 3
	--Snipers = 4
	SWEP.Slot 							= 1
	SWEP.SlotPos 						= 2

	SWEP.SwayScale					= 1
	SWEP.BobScale						= 1
	
end

SWEP.HoldType 						= "melee"
SWEP.ViewModel 						= "models/weapons/c_stunstick.mdl"
SWEP.WorldModel 					= "models/weapons/w_stunstick.mdl"
SWEP.Category 						= "Half-Life: Apocalypse"
SWEP.Purpose							= "Kill people."
SWEP.Instructions					= "Hit people with a stick"
 
SWEP.Spawnable 						= true
SWEP.AdminSpawnable				= true

SWEP.Base									= "hla_melee_base"

SWEP.WeaponDeploySpeed 		= 1
SWEP.UseHands							= true

SWEP.HitDistance					= 40
SWEP.HitInclination				= 0.2
SWEP.HitPushback					= 400
SWEP.HitRate							= 1.10
SWEP.MinDamage						= 20
SWEP.MaxDamage						= 27
SWEP.SwingTime						= 0.2
SWEP.Force 								= 5

SWEP.Primary.DrawSound 		= Sound( "" )
SWEP.SwingSound   				= Sound( "" )
SWEP.HitSoundWorld   			= Sound( "" )
SWEP.HitSoundBody   			= Sound( "" )
SWEP.BreakSound		   			= Sound( "" )

util.PrecacheSound( SWEP.Primary.DrawSound )
util.PrecacheSound( SWEP.SwingSound )
util.PrecacheSound( SWEP.HitSoundWorld )
util.PrecacheSound( SWEP.HitSoundBody )
util.PrecacheSound( SWEP.BreakSound )