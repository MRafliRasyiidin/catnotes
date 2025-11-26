var rules_text: Array[Array] = [
	[
		"Just moved in. The cats are still getting used to the place.",
		"Assign each cat to their bed.",
		"[color=#0c19ad][b]HINTS:[/b][/color]\nLeft-click and drag the cats to a location indicated by the [b]paws.[/b]\nRight-click and drag to move the camera around.",
	],
]

# Common coords:
# - Sofa near window = (-11,28)
# - Bed (0, 27)
# - Near TV (-17, 30)

var rule: Dictionary = {
	"Choco":{
		"not_tile": [],
		"cat": [],
	},
	"Tissue": {
		"not_tile": [],
		"cat": [],
	},
	"Chris": {
		"not_tile": [],
		"cat": [],
	},
	"Boom": {
		"not_tile": [],
		"cat": [],
	},
	"Nima": {
		"not_tile": [],
		"cat": [],
	},
	"Miko": {
		"not_tile": [],
		"cat": [],
		"tv": false
	}
}
