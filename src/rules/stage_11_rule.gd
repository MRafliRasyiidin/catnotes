var rules_text: Array[Array] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	[
		"[color=#d44d13][b]Choco[/b][/color] came back. She doesn't like the new kitchen.",
		"[color=#d44d13][b]Boom[/b][/color] is more accepting of other cats now, but he still wants to be in the bedroom.",
		"[color=#d44d13][b]Nima[/b][/color] wants to be in the kitchen for some reason. I guess she missed it so much.",
		
		#"I’m thinking of fostering another cat soon."
	],[
		"[color=#d44d13][b]Miko[/b][/color] and [color=#d44d13][b]Chris[/b][/color] are at it as always. Not surprised at all.",
		"[color=#d44d13][b]Chris[/b][/color] doesn't [color=#d44d13][b]Boom[/b][/color] again. Wonder what happened?",
		"[color=#d44d13][b]Chris[/b][/color] wants to watch the TV but [color=#d44d13][b]Choho[/b][/color] hates it.",
	]
]

var rule: Dictionary = {
	"Choco":{
		"not_tile": [

			],
		"avoid_room": ["kitchen"],
		"cat": []
	},
	"Tissue": {
		"not_tile": [],
		"cat": []
	},
	"Chris": {
		"not_tile": [
			
		],
		"cat": [],
		"tv_prefer": true
	},
	"Boom": {
		"not_tile": [],
		"only_room":["bedroom"],
		"cat": []
	},
	"Nima": {
		"not_tile": [],
		"only_room":["kitchen"],
		"cat": []
	},
	"Miko": {
		"not_tile": [],
		"cat": ["Chris"]
	}
}
