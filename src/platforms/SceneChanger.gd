extends Node
signal change_finished()
var scene
var is_changing = false

func _ready():
	$ColorRect.rect_size = Vector2(0,0)
	$ColorRect.color = Color(255,255,255,0)
	$ColorRect.visible = false

func change_scene(scene: String, animation = "fade"):
	self.scene = scene
	self.is_changing = true

	$AnimationPlayer.play("fade")
	yield($AnimationPlayer, "animation_finished")
	self.is_changing = false
	self.emit_signal("change_finished")

func _next_scene():
	self.get_tree().change_scene(scene)
