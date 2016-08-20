hla.Settings = {}
hla.PModels = {}

--> Player movement
hla.Settings[ "RunSpeed" ] 		= 300
hla.Settings[ "WalkSpeed" ] 	= 200
hla.Settings[ "JumpSpeed" ] 	= 100
hla.Settings[ "DuckSpeed" ] 	= 0.2
hla.Settings[ "UnDuckSpeed" ] = 0.4

--> Round start voting
hla.Settings[ "iVoted" ]				= {}
hla.Settings[ "iVotedRTV" ]			= {}
hla.Settings[ "fProcentVote" ] 	= 0.67

--> Game state
hla.Settings[ "GameState" ] 		= 0

--> Game state
hla.Settings[ "Team1N" ] = "Humans"
hla.Settings[ "Team1C" ] = Color(80, 200, 80)
hla.Settings[ "Team2N" ] = "Infected"
hla.Settings[ "Team2C" ] = Color(200, 80, 80)