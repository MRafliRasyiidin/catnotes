var rules_text: Array[Array] = [
	[
		#"The office ceiling leaks when it rains. I need to move the beds.",
		#"[color=#d44d13][b]Miko[/b][/color] still doesn't like [color=#d44d13][b]Chris[/b][/color].",
		"I think [color=#d44d13][b]Miko[/b][/color] and [color=#d44d13][b]Chris[/b][/color] are okay now? I hope they don't fight anymore.",
		"I think I heard [color=#d44d13][b]Chris[/b][/color] hissing at [color=#d44d13][b]Boom[/b][/color]. Maybe don't put them in the same room.",
		"[color=#d44d13][b]Nima[/b][/color] likes to be undisturbed. She doesn't like the bedroom though.",
		#"[color=#0c19ad][b]HINTS:[/b][/color]\nYou can [b]flip the page[/b] of the notepad.",
	],
	[
		"[color=#d44d13][b]Choco[/b][/color] usually sleeps near a window but she hates the rain. She prefers to sleep in the kitchen when it rains.",
		"[color=#d44d13][b]Boom[/b][/color] and [color=#d44d13][b]Tissue[/b][/color] are getting really close. Almost inseparable. Cute.",
		"[color=#0c19ad][b]HINTS:[/b][/color]\nIf two cats are really fond of each other, [b]put them in the same room.[/b]"
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
			Vector2i(-18, 35),
			Vector2i(-13, 39),
			Vector2i(-11, 28),
			Vector2i(2, 32),
			Vector2i(-6, 41),
			Vector2i(-2, 44),
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
		"cat": [],
		"same_room": ["Tissue"]
	},
	"Nima": {
		"not_tile": [
			Vector2i(2, 32)
		],
		"cat": ["Choco", "Tissue","Chris", "Boom", "Miko"]
	},
	"Miko": {
		"not_tile": [
			
		],
		"cat": []
	}
}
