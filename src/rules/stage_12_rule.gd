var rules_text: Array[Array] = [
	[
		"I’m thinking of fostering another cat soon.",
		"All of them seems to be quite peaceful than usual. They're also exploring different areas.",
		"They don't mind sleeping anywhere.",
	],
	[
		"On the second thought... let's make [color=#d44d13][b]Chris[/b][/color] be nowhere near the computer... I think that'll be a good idea.",
		
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
			
			],
		"cat": []
	},
	"Tissue": {
		"not_tile": [
			
		],
		"cat": [],
		"same_room": []
	},
	"Chris": {
		"not_tile": [],
		"cat": [],
		"avoid_room":["office"]
	},
	"Boom": {
		"not_tile": [
			
		],
		"cat": [],
		"same_room": []
	},
	"Nima": {
		"not_tile": [
			
		],
		"cat": []
	},
	"Miko": {
		"not_tile": [
			
		],
		"cat": []
	}
}
