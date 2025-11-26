var rules_text: Array[Array] = [
	[
		"The office ceiling is still leaking. I haven't had the time to fix it.",
		"[color=#d44d13][b]Nima[/b][/color] is a lonewolf as always.",
		#"Something's wrong with the kitchen as well. Just my luck.",
		#"[color=#d44d13][b]Miko[/b][/color] still doesn't like [color=#d44d13][b]Chris[/b][/color].",
		"Another month and [color=#d44d13][b]Miko[/b][/color] still doesn't like [color=#d44d13][b]Chris[/b][/color]...",
		"[color=#d44d13][b]Tissue[/b][/color] is more quiet than usual. She also doesn't eat as much...",
		"Feels like a lot of things are happening at once.",
		#"Seems like [color=#d44d13][b]Boom[/b][/color] is avoiding [color=#d44d13][b]Choco[/b][/color] since last week.",
	],
	[

		"Perhaps [color=#d44d13][b]Choco[/b][/color] has made peace with the rain. She likes too look at the water on the window.",
		"[color=#d44d13][b]Boom[/b][/color] and [color=#d44d13][b]Tissue[/b][/color] are so cute. I wish Tissue would be more energetic like usual.",
		"[color=#d44d13][b]Chris[/b][/color] wants to watch the TV. [color=#d44d13][b]Choco[/b][/color] and [color=#d44d13][b]Nima[/b][/color] hates it though.",
		"And again, [color=#d44d13][b]Chris[/b][/color] still doesn't like [color=#d44d13][b]Boom[/b][/color].",
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
		"not_tile":[],
		"only_tile": [
			Vector2i(-11, 28),
			Vector2i(2, 32)
			],
		"cat": [],
		"tv": true
	},
	"Tissue": {
		"not_tile": [
			
		],
		"cat": [],
		"same_room": ["Boom"]
	},
	"Chris": {
		"not_tile": [],
		"cat": ["Boom"],
		"tv_prefer": true
	},
	"Boom": {
		"not_tile": [
			
		],
		"cat": [],
		"same_room": ["Tissue"]
	},
	"Nima": {
		"not_tile": [
			Vector2i(-5, 32),
			Vector2i(2, 32)
		],
		"cat": [
			#"Choco", "Tissue","Chris", "Boom", "Miko"
			],
		"tv": true
	},
	"Miko": {
		"not_tile": [
			
		],
		"cat": ["Chris"]
	}
}
