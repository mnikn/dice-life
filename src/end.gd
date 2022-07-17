extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/RichTextLabel.bbcode_text = I18n.translate({
		"zh": "[center]感谢你的游玩![/center]",
		"en": "[center]Thanks for playing![/center]"
	})
