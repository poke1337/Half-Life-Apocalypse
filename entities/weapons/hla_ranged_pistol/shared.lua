if SERVER then

	AddCSLuaFile ("shared.lua")

	SWEP.Weight 						= 5
	SWEP.AutoSwitchTo 			= false
	SWEP.AutoSwitchFrom 		= false
 
elseif CLIENT then

	//killicon.Add( "hla_ranged_pistol", "hud/killicons/pistol", Color( 255, 100, 20, 255 ) )
	
	//SWEP.WepSelectIcon 		= surface.GetTextureID("hud/killicons/pistol" )
	SWEP.PrintName 					= "HL:A Pistol"
 
	//Sets the position of the weapon in the switching menu 
	//(appears when you use the scroll wheel or keys 1-6 by default)
	--Handguns = 1
	--Rifles = 2
	--Heavy = 3
	--Snipers = 4
	SWEP.Slot 							= 1
	SWEP.SlotPos 						= 1

	SWEP.SwayScale					= 1
	SWEP.BobScale						= 1
	
end

SWEP.HoldType 						= "pistol"
SWEP.ViewModel 						= "models/weapons/v_pistol.mdl"
SWEP.WorldModel 					= "models/weapons/w_pistol.mdl"
SWEP.Category 						= "Half-Life: Apocalypse"
SWEP.Purpose							= "Kill people."
SWEP.Instructions					= "Point. Aim. Shoot."
 
SWEP.Spawnable 						= true
SWEP.AdminSpawnable				= true

SWEP.Base									= "hla_ranged_base"

SWEP.Primary.ClipSize 		= 100
SWEP.Primary.DefaultClip 	= 50
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo					= "pistol"
SWEP.Primary.BulletForce 	= 2

SWEP.PrimaryRecoil				= 0.28
SWEP.PrimaryDelay					= 0.32
SWEP.PrimaryCone					= 0.015
SWEP.PrimaryNum						= 1
SWEP.PrimaryDamage				= 30

SWEP.IronsightPos 				= Vector( -5.823, -6.369, 3.999 )
SWEP.IronsightAng 				= Vector( 0.66, -1.012, -8.124 )
SWEP.IronsightFOV 				= 68

SWEP.Primary.DrawSound 		= Sound( "" )
SWEP.Primary.Sound        = Sound( "" )
SWEP.Primary.ReloadSound 	= Sound( "" )
SWEP.IronsightSoundOn 		= Sound( "" )
SWEP.IronsightSoundOff 		= Sound( "" )
SWEP.ShootHitSound  			= Sound( "player/pistolhit/PistolHit" .. math.random(1,3) .. ".wav" )

util.PrecacheSound( SWEP.Primary.DrawSound )
util.PrecacheSound( SWEP.Primary.Sound )
util.PrecacheSound( SWEP.Primary.ReloadSound )
util.PrecacheSound( SWEP.IronsightSoundOn )
util.PrecacheSound( SWEP.IronsightSoundOff )
util.PrecacheSound( SWEP.ShootHitSound )
