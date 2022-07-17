extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = "Please select language:"
	
	var node = $Dialogue.add_option({
		"text": "english",
		"disabled": false
	})
	node.connect("pressed", self, "set_lang", ["en"])
	node = $Dialogue.add_option({
		"text": "中文",
		"disabled": false
	})
	node.connect("pressed", self, "set_lang", ["zh"])
	$Dialogue.start()

func set_lang(lang):
	if not $Dialogue/MarginContainer/HBoxContainer/Desc.percent_visible == 1:
		return
	I18n.set_lang(lang)
	$"/root/SceneChanger".change_scene("res://src/stage0.tscn")
