var rules_text: Array[Array] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	[
		"Choco really loves playing outside. She hasn't returned for days.",
		"It feels emptier and emptier and emptier...",
		"Still raining heavily. I hope Choco's okay.",
		"[color=#d44d13][b]Boom[/b][/color] still wants to be alone in the bedroom.",
		"",
	],[
		"The office is all fixed now. [color=#d44d13][b]Miko[/b][/color] seems to really like it there.",
		"[color=#d44d13][b]Chris[/b][/color] and [color=#d44d13][b]Miko[/b][/color] are fighting again.",
		"[color=#d44d13][b]Chris[/b][/color] wants to watch TV. He likes to sleep close to it.",
		"[color=#d44d13][b]Nima[/b][/color] likes to be near the plant in the corner of the living room. Not sure why."
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
			
		],
		"cat": []
	},
	"Tissue": {
		"not_tile": [],
		"cat": []
	},
	"Chris": {
		"not_tile": [],
		"only_tile": [
			Vector2i(-17,32)
			],
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
		"only_tile": [
			Vector2i(-16,45)
			],
		"cat": []
	},
	"Miko": {
		"not_tile": [],
		"cat": ["Chris"]
	}
}
