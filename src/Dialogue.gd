extends Control
signal dialogue_finished()

var OptionButtonScene = preload("res://src/OptionButton.tscn")

var finished = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/HBoxContainer/Desc.percent_visible = 0
	$MarginContainer/HBoxContainer/Options.modulate = Color("#00ffffff")

func add_option(option):
	var node = OptionButtonScene.instance()
	node.text = option.text
	node.disabled = option.disabled
	$MarginContainer/HBoxContainer/Options.add_child(node)
	return node


func start():
	self.finished = false
	$MarginContainer/HBoxContainer/Desc.percent_visible = 0
	$MarginContainer/HBoxContainer/Options.modulate = Color("#00ffffff")
	
	$AudioStreamPlayer.play()
	var tween = create_tween()
	tween.tween_property($MarginContainer/HBoxContainer/Desc, "percent_visible", 1.0, 2.0)

	yield(tween, "finished")
	$AudioStreamPlayer.stop()
	self.finished = true
	$MarginContainer/HBoxContainer/Options.modulate = Color("#fff")
	
func _input(event):
	if event.is_action_pressed("ui_accept") and self.finished and $MarginContainer/HBoxContainer/Options.get_child_count() == 0:
		self.emit_signal("dialogue_finished")
