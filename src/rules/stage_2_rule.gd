var rules_text: Array[Array] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	[
		"[color=#d44d13][b]Choco[/b][/color] likes to sleep near a window. Perhaps she likes playing outside.",
		"[color=#d44d13][b]Miko[/b][/color] loves the office. He always watches me work on the computer.",
		"[color=#0c19ad][b]HINTS:[/b][/color]\nIf no other cats are mentioned, they can be put anywhere else.",
		#"[color=#d44d13][b]Chris[/b][/color] has been messing around the TV. I don't want to deal with paying for repairs."
	],
]

# Common coords:
# - Sofa near window = (-11,28)
# - Bed (0, 27)
# - Near TV (-17, 30)

var rule: Dictionary = {
	"Choco":{
		"not_tile": [
			
			],
		"only_tile": [
			Vector2i(-11,28)
		],
		"cat": [],
		"tv": false
	},
	"Tissue": {
		"not_tile": [
			
		],
		"cat": [],
		"tv": false
	},
	"Chris": {
		"not_tile": [
			
			],
		"cat": [],
		"tv": false
	},
	"Boom": {
		"not_tile": [
			
		],
		"cat": [],
		"tv": false
	},
	"Nima": {
		"not_tile": [
			
		],
		"cat": [],
		"tv": false
	},
	"Miko": {
		"not_tile": [
			#Vector2i(-18, 43),
			#Vector2i(-12, 38),
			#Vector2i(-11, 28),
			#Vector2i(-2, 34),
			#Vector2i(-9, 56)
			],
		"cat": [],
		"only_room": ["office"]
	}
}
