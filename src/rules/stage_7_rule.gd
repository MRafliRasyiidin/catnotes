var rules_text: Array[Array] = [
	[
		"The office ceiling is starting to leak when it rains.",
		#"[color=#d44d13][b]Miko[/b][/color] still doesn't like [color=#d44d13][b]Chris[/b][/color].",
		"[color=#d44d13][b]Chris[/b][/color] is annoying [color=#d44d13][b]Miko[/b][/color] again... I need to separate them.",
		"[color=#d44d13][b]Tissue[/b][/color] is... wait... where is she? Feeding her has been difficult too.",
		"Seems like [color=#d44d13][b]Boom[/b][/color] is avoiding [color=#d44d13][b]Choco[/b][/color] since last week.",
	],
	[
		"[color=#d44d13][b]Nima[/b][/color] still prefer to sleep alone and doesn't like the bedroom. She's very friendly, though.",
		"[color=#d44d13][b]Choco[/b][/color] doesn't like to be near the window when it rains as usual.",
		"[color=#d44d13][b]Boom[/b][/color] and [color=#d44d13][b]Tissue[/b][/color] are still inseparable.",
		"Of course, [color=#d44d13][b]Chris[/b][/color] still doesn't like [color=#d44d13][b]Boom[/b][/color].",
		#"[color=#0c19ad][b]HINTS:[/b][/color]\nIf two cats are really fond of each other, [b]put them in the same room.[/b]"
	]
]

# Common coords:
# - Sofa near window = (-11,28)
# - Bedroom near window = (2,32)
# - Bed (0, 27)
# - Near TV (-17, 30)

var rule: Dictionary = {
	"Choco":{
		"not_tile": [
			Vector2i(-11, 28),
			Vector2i(2, 32)
			],
		"cat": []
	},
	"Tissue": {
		"not_tile": [
			
		],
		"cat": [],
		"same_room": ["Boom"]
	},
	"Chris": {
		"not_tile": [],
		"cat": ["Boom"]
	},
	"Boom": {
		"not_tile": [
			
		],
		"cat": ["Choco"],
		"same_room": ["Tissue"]
	},
	"Nima": {
		"not_tile": [
			Vector2i(-5, 32),
			Vector2i(2, 32)
		],
		"cat": ["Choco", "Tissue","Chris", "Boom", "Miko"]
	},
	"Miko": {
		"not_tile": [
			
		],
		"cat": ["Chris"]
	}
}
