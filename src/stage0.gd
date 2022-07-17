extends Node2D

func _ready():
	print_debug("sss")
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
		"zh": "伴随着啼哭,你诞生了.\n\n你选择诞生在怎样的家庭?",
		"en": "With crying, you were born.\n\nWhat kind of family did you choose to be born in?"
	})
	
	$Dialogue.add_option({
		"text": I18n.translate({
			"zh": "富裕的家庭",
			"en": "Wealthy family"
		}),
		"disabled": true
	})
	
	var btn = $Dialogue.add_option({
		"text": I18n.translate({
			"zh": "普通的家庭",
			"en": "Normal family"
		}),
		"disabled": false
	})
	btn.connect("pressed", self, "change_scene")

	$Dialogue.start()
	
func change_scene():
	$"/root/SceneChanger".change_scene("res://src/stage1.tscn")
