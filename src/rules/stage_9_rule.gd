var rules_text: Array[Array] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	[
		"Tissue passed away last week. I kept her bed by the window.",
		"[color=#d44d13][b]Choco[/b][/color] sometimes sits by a window, waiting...",
		"The apartement feels emptier.",
		"It's strange not hearing Tissue's purr.",
		"[color=#d44d13][b]Boom[/b][/color] wants to stay close to Tissue's bed. He's very quiet.",
		"",
	],[
		"The kitchen is being renovated. Maybe it's time to fix the leak in the office as well.",
		"[color=#d44d13][b]Boom[/b][/color] doesn't want to be near other cats right now.",
		"[color=#d44d13][b]Chris[/b][/color] wants to watch TV.",
		"I guess [color=#d44d13][b]Miko[/b][/color] and [color=#d44d13][b]Chris[/b][/color] are good for now."
		#"And again, [color=#d44d13][b]Chris[/b][/color] still doesn't like [color=#d44d13][b]Boom[/b][/color].",
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
			
			],
		"only_tile": [
			Vector2i(-11,28),
			Vector2i(2,32),
		],
		"cat": []
	},
	"Tissue": {
		"not_tile": [],
		"cat": []
	},
	"Chris": {
		"not_tile": [],
		"cat": [],
		"tv_prefer": true
	},
	"Boom": {
		"not_tile": [],
		"only_room": ["bedroom"],
		"cat": ["Choco", "Tissue", "Chris", "Nima", "Miko"]
	},
	"Nima": {
		"not_tile": [],
		"cat": []
	},
	"Miko": {
		"not_tile": [],
		"cat": []
	}
}
