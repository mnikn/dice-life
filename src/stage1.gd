extends Node2D

var dialogueScene = preload("res://src/PersonDialogue.tscn")

func show_dialogue(dialog):
	for item in dialog:
		var d1 = self.dialogueScene.instance()
		self.add_child(d1)
		d1.start(I18n.translate(item.content), item.pos)
		yield(d1, "dialogue_finished")

func _ready():
	$Dialogue.visible = false
	yield(self.show_dialogue([{
		"content": {
			"zh": "亲爱的,你感觉怎么样?",
			"en": "Dear, how's your feeling?"
		},
		"pos": Vector2(517, 400)
	}, {
		"content": {
			"zh": "我很好,看,这是我们的小宝宝.",
			"en": "I'm fine, look, our little baby."
		},
		"pos": Vector2(770, 400)
	}, {
		"content": {
			"zh": "看看这个小男孩,他长大后肯定像我一样帅气.",
			"en": "Look at this little boy, He must be as handsome as me when he grows up."
		},
		"pos": Vector2(517, 400)
	}, {
		"content": {
			"zh": "哈哈,你真不要脸.",
			"en": "Haha, you are so shameless."
		},
		"pos": Vector2(770, 400)
	}, {
		"content": {
			"zh": "我只希望他能够平安长大.",
			"en": "I just hope he can grow up healthy."
		},
		"pos": Vector2(770, 400)
	}]), "completed")
	
	
	$Dialogue.visible = true
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
		"zh": "诞生在普通家庭的你,虽然很多条件不如富裕的家庭,但是你还是接受并慢慢长大了...",
		"en": "You were born in a normal family, although many conditions are not as good as a wealthy family, but you still accept it and grow up..."
	})
	
	$Dialogue.start()
	yield($Dialogue, "dialogue_finished")
	
	$"/root/SceneChanger".change_scene("res://src/stage2.tscn")
