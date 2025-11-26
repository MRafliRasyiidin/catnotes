var rules_text: Array[Array] = [
	[
		#"The office ceiling leaks when it rains. I need to move the beds.",
		#"[color=#d44d13][b]Tissue[/b][/color]’s been sleeping more lately. She doesn’t eat as much.",
		#"[color=#d44d13][b]Choco[/b][/color] seems restless. Maybe he misses going outside.",
		"[color=#d44d13][b]Nima[/b][/color] scratched the sofa again. I shouldn't put her near it."
		#"[color=#d44d13][b]Miko[/b][/color] hissed at [color=#d44d13][b]Chris[/b][/color] again."
	],
]

# Common coords:
# - Sofa near window = (-11,28)
# - Bed (0, 27)
# - Near TV (-17, 30)

var rule: Dictionary = {
	"Choco":{
		"coor": [
			Vector2i(-18, 32),
			Vector2i(-17, 39),
			Vector2i(-11, 35),
			Vector2i(0, 27),
			Vector2i(0, 33),
			Vector2i(-13, 61),
			],
		"cat": []
	},
	"Tissue": {
		"coor": [],
		"cat": []
	},
	"Chris": {
		"coor": [],
		"cat": []
	},
	"Boom": {
		"coor": [],
		"cat": []
	},
	"Nima": {
		"coor": [Vector2i(-11, 35), Vector2i(-11, 28), Vector2i(-17, 39), Vector2i(-18, 32)],
		"cat": []
	},
	"Miko": {
		"coor": [],
		"cat": ["Chris"]
	}
}
