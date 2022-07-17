extends NinePatchRect
signal dialogue_finished()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var finished = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/Content.percent_visible = 0
	self.visible = false

func _process(delta):
	self.rect_min_size = $MarginContainer.rect_size
	
func start(content, pos):
	$AudioStreamPlayer.play()
	var tween = create_tween()
	$MarginContainer/Content.text = content
	pos.y -= (len(content) / 13) * 30
	self.rect_position = pos
	self.visible = true
	tween.tween_property($MarginContainer/Content, "percent_visible", 1.0, 1.0)

	yield(tween, "finished")
	$AudioStreamPlayer.stop()
	finished = true
	
func _input(event):
	if event.is_action_pressed("ui_accept") and finished:
		self.emit_signal("dialogue_finished")
		self.queue_free()
