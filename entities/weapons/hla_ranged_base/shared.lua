if SERVER then

  AddCSLuaFile( "shared.lua" )

	SWEP.Weight 						= 5
	SWEP.AutoSwitchTo 			= false
	SWEP.AutoSwitchFrom 		= false
 
elseif CLIENT then
	
	SWEP.ViewModelFOV				= 70
	SWEP.DrawAmmo						= true
	SWEP.DrawCrosshair			= false
	SWEP.BounceWeaponIcon 	= false
	SWEP.ViewModelFlip			= false
	SWEP.SwayScale					= 1
	SWEP.BobScale						= 1

end
 
SWEP.Spawnable 						= false
SWEP.AdminSpawnable				= false

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo					= "none"
SWEP.Primary.BulletForce 	= 5
SWEP.PrimaryDelay					= 1
 
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 			= "none"

SWEP.Category							= "Half-Life: Apocalypse"
SWEP.Author								= "Poke"

SWEP.UseScope 						= false
SWEP.WeaponDeploySpeed 		= 1
SWEP.UseHands							= true

SWEP.IronsightPos 				= Vector( 0, 0, 0 )
SWEP.IronsightAng 				= Vector( 0, 0, 0 )
SWEP.IronsightFOV 				= 68

SWEP.Primary.DrawSound 		= Sound( "" )
SWEP.Primary.Sound        = Sound( "" )
SWEP.Primary.ReloadSound 	= Sound( "" )
SWEP.IronsightSoundOn 		= Sound( "" )
SWEP.IronsightSoundOff 		= Sound( "" )
SWEP.ShootHitSound  			= Sound( "" )

util.PrecacheSound( SWEP.Primary.DrawSound )
util.PrecacheSound( SWEP.Primary.Sound )
util.PrecacheSound( SWEP.Primary.ReloadSound )
util.PrecacheSound( SWEP.IronsightSoundOn )
util.PrecacheSound( SWEP.IronsightSoundOff )
util.PrecacheSound( SWEP.ShootHitSound )

local IRONSIGHT_TIME 			= 0.15

function SWEP:Deploy()

	self.Primary.Automatic  = self.PrimaryAutomatic
	self.Primary.Delay 			= self.PrimaryDelay
	self.Primary.Cone 			= self.PrimaryCone
	self.Primary.Damage 		= self.PrimaryDamage
	self.Primary.Recoil 		= self.PrimaryRecoil

	self.Weapon:EmitSound( self.Primary.DrawSound )
	self:SetIronsights(false, self.Owner)

	return true

end

function SWEP:Initialize()

	if SERVER then

		self:SetWeaponHoldType( self.HoldType )

	end

	self.Primary.Automatic 	= self.PrimaryAutomatic
	self.Primary.Delay 			= self.PrimaryDelay
	self.Primary.Cone 			= self.PrimaryCone
	self.Primary.Damage 		= self.PrimaryDamage
	self.Primary.Recoil 		= self.PrimaryRecoil

	self.Weapon:SetDeploySpeed( self.WeaponDeploySpeed )
	self.Weapon:SetNetworkedBool( "Ironsights", false )

end

function SWEP:Reload()

	self:SetIronsights(false)
	self.Weapon:DefaultReload( ACT_VM_RELOAD )

	self.Primary.Automatic 	= self.PrimaryAutomatic
	self.Primary.Delay 			= self.PrimaryDelay
	self.Primary.Cone 			= self.PrimaryCone
	self.Primary.Damage 		= self.PrimaryDamage
	self.Primary.Recoil 		= self.PrimaryRecoil

	self.Weapon:EmitSound( self.Primary.ReloadSound )

end

function SWEP:Holster() 
	
	if SERVER then

		self.Owner:SetFOV( 0, 0.3 )

	end

	return true

end

function SWEP:GetViewModelPosition(pos, ang)

	if ( not self.IronsightPos ) then return pos, ang end

	local bIron = self.Weapon:GetNWBool("Ironsights")

	if ( bIron != self.bLastIron ) then

		self.bLastIron = bIron
		self.fIronTime = CurTime()

		if bIron then

			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1

		else

			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0

		end

	end

	local fIronTime = self.fIronTime or 0

	if ( not bIron and fIronTime < CurTime() - IRONSIGHT_TIME ) then

		return pos, ang

	end

	local Mul = 1.0

	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then

		Mul = math.Clamp( ( CurTime() - fIronTime ) / IRONSIGHT_TIME, 0, 1 )

		if !bIron then Mul = 1 - Mul end

	end

	local Offset	= self.IronsightPos

	if ( self.IronsightAng ) then

		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronsightAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 			self.IronsightAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronsightAng.z * Mul )

	end

	local Right 		= ang:Right()
	local Up 				= ang:Up()
	local Forward 	= ang:Forward()

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang

end

function SWEP:Think()

	self:Ironsight()

end

function SWEP:PrimaryAttack()

	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	if !self:CanPrimaryAttack() then return end
	
	self.Weapon:EmitSound( Sound( self.Primary.Sound ) )
	
	self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone )
	
	if ( self.Owner:IsNPC() ) then return end
	
	self.Owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0 ) )
	
	if ( ( game.SinglePlayer() && SERVER ) || CLIENT ) then

		self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )

	end
	
		local tr = self.Owner:GetEyeTrace()
		if tr.Entity:IsNPC() or tr.Entity:IsPlayer() then
		tr.Entity:EmitSound ( self.ShootHitSound )

	end	

end

function SWEP:ShootBullet( dmg, recoil, numbul, cone )

	numbul 	= numbul 	or 1
	cone 		= cone 		or 0.01

	local bullet = {}
	bullet.Num 				= numbul
	bullet.Src 				= self.Owner:GetShootPos()
	bullet.Dir 				= self.Owner:GetAimVector()
	bullet.Spread 		= Vector( cone, cone, 0 )
	bullet.Force			= self.Primary.BulletForce
	bullet.Damage			= dmg

	self.Owner:ViewPunch( Angle( self.Primary.BulletForce * 0.5, 0, 0 ) )

	self.Owner:MuzzleFlash()

	self.Owner:FireBullets( bullet )
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	if ( self.Owner:IsNPC() ) then return end

	if ( ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() && CLIENT && IsFirstTimePredicted() ) ) then
	
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - recoil

		self.Owner:SetEyeAngles( eyeang )
	
	end

end

function SWEP:SecondaryAttack()
end

function SWEP:SetIronsights(b)

	self.Weapon:SetNetworkedBool("Ironsights", b)

end

function SWEP:GetIronsights()

	return self.Weapon:GetNWBool("Ironsights")

end

function SWEP:Ironsight()

	if !self.Owner:KeyDown( IN_USE ) then

		if self.Owner:KeyPressed( IN_ATTACK2 ) then

			self.Owner:SetFOV( self.IronsightFOV , 0.15 )
			self.Owner:ViewPunch( Angle( -1, -1, 0 ) )
			
			self:SetIronsights( true, self.Owner )
			self.Weapon:EmitSound( self.IronsightSoundOn )

			if CLIENT then return end

 		end

	end

	if self.Owner:KeyReleased( IN_ATTACK2 ) then

		self.Owner:SetFOV( 0, 0.15 )
		self.Owner:ViewPunch( Angle( 1, 1, 0 ) )

		self:SetIronsights( false, self.Owner )
		self.Weapon:EmitSound( self.IronsightSoundOff )

		if CLIENT then return end

	end
	
end