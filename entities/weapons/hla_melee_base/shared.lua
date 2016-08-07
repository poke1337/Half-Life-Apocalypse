if SERVER then

  AddCSLuaFile( "shared.lua" )

	SWEP.Weight 						= 5
	SWEP.AutoSwitchTo 			= false
	SWEP.AutoSwitchFrom 		= false
 
elseif CLIENT then
	
	SWEP.ViewModelFOV				= 70
	SWEP.DrawAmmo						= false
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
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo					= "none"
 
SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip= -1
SWEP.Secondary.Automatic 	= false
SWEP.Secondary.Ammo 			= "none"

SWEP.Category							= "Half-Life: Apocalypse"
SWEP.Author								= "Poke"

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

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + self.WeaponDeploySpeed )

	self.Weapon:EmitSound( self.Primary.DrawSound )

	return true

end

function SWEP:Initialize()

	if SERVER then

		self:SetWeaponHoldType( self.HoldType )

	end

	self.Weapon:SetDeploySpeed( self.WeaponDeploySpeed )

end

function SWEP:Holster()

	return true

end

function SWEP:PrimaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	
	self:EmitSound( self.SwingSound )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )

	timer.Create("HitDelay", self.SwingTime, 1, function() self:Hit() end)

	timer.Start( "HitDelay" )

end

function SWEP:Hit()

	for i=0, 170 do

		local tr = util.TraceLine( {
			start = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)),
			endpos = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)) + ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.7 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) ),
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		} )

		if ( tr.Hit ) then
			
			local strikevector = ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.5 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) )
			
			bullet 					= {}
			bullet.Num    	= 1
			bullet.Src    	= (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 15))
			bullet.Dir    	= strikevector:GetNormalized()
			bullet.Spread 	= Vector(0, 0, 0)
			bullet.Tracer 	= 0
			bullet.Force  	= self.Force
			bullet.Hullsize = 0
			bullet.Distance = self.HitDistance * 1.5
			bullet.Damage 	= math.random(self.MinDamage, self.MaxDamage)

			self.Owner:FireBullets(bullet)

			self:EmitSound(self.SwingSound)

			if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then

				self:EmitSound(self.HitSoundBody)
				tr.Entity:SetVelocity(self.Owner:GetAimVector() * Vector( 1, 1, 0 ) * self.HitPushback)

			else

				self:EmitSound(self.HitSoundWorld)

			end

		break

		end

	end

end

function SWEP:SecondaryAttack()
end

function SWEP:OnRemove()

	timer.Remove("HitDelay")

	return true

end