var rules_text: Array[Array] = [
	[
		#"The office ceiling leaks when it rains. I need to move the beds.",
		#"[color=#d44d13][b]Tissue[/b][/color]’s been sleeping more lately. She doesn’t eat as much.",
		"[color=#d44d13][b]Choco[/b][/color] seems restless. Maybe she misses going outside. She wants to be near a window.",
		"The living room seems to be [color=#d44d13][b]Tissue[/b][/color]'s favorite spot these days.",
		#"[color=#d44d13][b]Boom[/b][/color] always hissed at the stove whenever I cook."
		"[color=#d44d13][b]Miko[/b][/color] hissed at [color=#d44d13][b]Chris[/b][/color]. Not sure what's up with them.",
		"[color=#0c19ad][b]HINTS:[/b][/color]\nIf two cats aren't fond of each other, [b]don't put them in the same room.[/b]",
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
			Vector2i(-6, 36),
			Vector2i(-4, 31),
			Vector2i(-6, 41),
			Vector2i(-5, 46)
			],
		"cat": []
	},
	"Tissue": {
		"coor": [
			Vector2i(-6, 36),
			Vector2i(-4, 31),
			Vector2i(2, 32),
			Vector2i(-6, 41),
			Vector2i(-5, 46)
		],
		"cat": []
	},
	"Chris": {
		"coor": [],
		"cat": []
	},
	"Boom": {
		"coor": [
			Vector2i(-13, 53),
			Vector2i(-8, 57)
		],
		"cat": []
	},
	"Nima": {
		"coor": [
			Vector2i(-19, 35),
			Vector2i(-15, 41),
			Vector2i(-12, 36)
		],
		"cat": []
	},
	"Miko": {
		"coor": [],
		"cat": ["Chris"]
	}
}
