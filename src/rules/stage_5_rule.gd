var rules_text: Array[Array] = [
	[
		#"The office ceiling leaks when it rains. I need to move the beds.",
		"[color=#d44d13][b]Miko[/b][/color] still doesn't like [color=#d44d13][b]Chris[/b][/color].",
		"I think I heard [color=#d44d13][b]Chris[/b][/color] hissing at [color=#d44d13][b]Boom[/b][/color]. Maybe don't put them in the same room.",
		"[color=#d44d13][b]Miko[/b][/color] doesn't want to be in the bedroom.",
		"[color=#d44d13][b]Tissue[/b][/color] still loves the living room.",
		"[color=#d44d13][b]Boom[/b][/color] likes to be close to me recently, usually in the bedroom.",
		
		#"[color=#0c19ad][b]HINTS:[/b][/color]\nIf two cats aren't fond of each other, [b]don't put them in the same room.[/b]",
	],
]

# Common coords:
# - Sofa near window = (-11,28)
# - Bedroom near window = (2,32)
# - Bed (0, 27)
# - Near TV (-17, 30)

var rule: Dictionary = {
	"Choco":{
		"coor": [
			
			],
		"cat": []
	},
	"Tissue": {
		"coor": [
			Vector2i(0, 27),
			Vector2i(2, 32),
			Vector2i(-7, 40),
			Vector2i(-4, 44),
			Vector2i(-8, 56)
		],
		"cat": []
	},
	"Chris": {
		"coor": [],
		"cat": ["Boom"]
	},
	"Boom": {
		"coor": [
			Vector2i(-11, 35),
			Vector2i(-7, 40),
			Vector2i(-4, 44),
			Vector2i(-8, 56)
		],
		"cat": []
	},
	"Nima": {
		"coor": [
			
		],
		"cat": []
	},
	"Miko": {
		"coor": [
			Vector2i(0, 27),
			Vector2i(2, 32)
		],
		"cat": ["Chris"]
	}
}
