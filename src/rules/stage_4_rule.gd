var rules_text: Array[String] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	"Tissue passed away last week. I kept her bed by the window.",
	"[color=#d44d13][b]Choco[/b][/color] sometimes sits there by the window on the sofa, waiting.",
	"The apartement feels emptier.",
	"It's strange not hearing Tissue's purr.",
	"[color=#d44d13][b]Miko[/b][/color] still doesn't like [color=#d44d13][b]Chris[/b][/color].",
	"I think I heard [color=#d44d13][b]Chris[/b][/color] hissing at Boom. Maybe don't put them in the same room."
]

var rule: Dictionary = {
	"Choco":{
		"coor": [
			Vector2i(-19, 31),
			#Vector2i(-11, 28),
			Vector2i(-11, 35),
			Vector2i(2, 31),
			Vector2i(-6, 40),
			Vector2i(-16, 62),
			],
		"cat": []
	},
	"Tissue": {
		"coor": [],
		"cat": []
	},
	"Chris": {
		"coor": [],
		"cat": ["Boom"]
	},
	"Boom": {
		"coor": [],
		"cat": []
	},
	"Nima": {
		"coor": [],
		"cat": []
	},
	"Miko": {
		"coor": [],
		"cat": ["Chris"]
	}
}
