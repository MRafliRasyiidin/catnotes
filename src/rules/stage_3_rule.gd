var rules_text: Array[Array] = [
	[
		#"The office ceiling leaks when it rains. I need to move the beds.",
		#"[color=#d44d13][b]Tissue[/b][/color]’s been sleeping more lately. She doesn’t eat as much.",
		#"[color=#d44d13][b]Choco[/b][/color] seems restless. Maybe he misses going outside.",
		"[color=#d44d13][b]Nima[/b][/color] scratched the sofa again. I shouldn't put her near it.",
		"[color=#d44d13][b]Boom[/b][/color] always hissed at the stove whenever I cook.",
		"[color=#d44d13][b]Miko[/b][/color] has been avoiding the living room recently."
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
		"cat": []
	},
	"Tissue": {
		"not_tile": [],
		"cat": []
	},
	"Chris": {
		"not_tile": [],
		"cat": []
	},
	"Boom": {
		"not_tile": [
			Vector2i(-13, 53),
			Vector2i(-8, 57)
		],
		"cat": []
	},
	"Nima": {
		"not_tile": [
			#Vector2i(-19, 35),
			#Vector2i(-15, 41),
			#Vector2i(-12, 36)
		],
		"avoid_room": ["living_room"],
		"cat": []
	},
	"Miko": {
		"not_tile": [
			Vector2i(-19, 35),
			Vector2i(-15, 41),
			Vector2i(-12, 36),
		],
		"cat": []
	}
}
