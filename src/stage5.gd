extends Node2D

var dialogueScene = preload("res://src/PersonDialogue.tscn")

func show_dialogue(dialog):
	for item in dialog:
		var d1 = self.dialogueScene.instance()
		self.add_child(d1)
		d1.start(I18n.translate(item.content), item.pos)
		yield(d1, "dialogue_finished")

func _ready():
	$Bg.play("default")
	$Dialogue.visible = true
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
		"zh": "虽然你选择了接受治疗,但是这实在是太痛苦了,你无法忍受这种痛苦,于是决定自杀.\n\n你选择自杀的方式是?",
		"en": "Although you chose to receive treatment, it was so painful that you could not bear the pain, so you decided to commit suicide.\nHow did you choose to commit suicide?"
	})
	
	var node = $Dialogue.add_option({
		"text": I18n.translate({
			"zh": "手枪",
			"en": "Pistol"
		}),
		"disabled": false
	})
	node.connect("mouse_entered", self, "disabled_btn", [node])
	node = $Dialogue.add_option({
		"text": I18n.translate({
			"zh": "安眠药",
			"en": "Sleeping pills"
		}),
		"disabled": false
	})
	node.connect("mouse_entered", self, "disabled_btn", [node])
	node = $Dialogue.add_option({
		"text": I18n.translate({
			"zh": "上吊",
			"en": "Hanged"
		}),
		"disabled": false
	})
	node.connect("mouse_entered", self, "disabled_btn", [node])
	node = $Dialogue.add_option({
		"text": I18n.translate({
			"zh": "投骰子决定",
			"en": "Roll the dice to decide"
		}),
		"disabled": false
	})
	node.connect("pressed", self, "show_end")
	$Dialogue.start()
	yield($Dialogue, "dialogue_finished")
	$Dialogue.visible = false

func disabled_btn(node):
	node.disabled = true

func show_end():
	for node in $Dialogue.get_node("MarginContainer/HBoxContainer/Options").get_children():
		node.queue_free()
	$Dialogue.visible = true
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
		"zh": "你想选择一种自杀的方式,但是你决定哪一种都很可怕让你无法选择.\n\n到最后你看到了一个骰子,你又回忆起小时候痴迷dnd骰子不离手的时光,你想干脆由骰子决定吧.",
		"en": "You want to choose a way to kill yourself, but you decide which one is too scary to choose.\n\nAt the end you see a dice, and you recall the time when you were obsessed with dnd dice as a child, and you choose to let the dice to decide."
	})
	$Dialogue.start()
	yield($Dialogue, "dialogue_finished")
	$Dialogue.visible = false
	
	randomize()
	var d = randi() % 3 + 1
	
	if d == 1:
		$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
			"zh": "你掷下骰子,骰子无声地转动着...\n\n直到最后骰子终于停了下面,是1.",
			"en": "You roll the dice, and the dice roll silently...\n\nUntil the dice finally stops, it's 1."
		})
		$Dialogue.visible = true
		$Dialogue.start()
		yield($Dialogue, "dialogue_finished")
		$Dialogue.visible = false
		
		$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
			"zh": "你举起了手枪,把枪对准自己的太阳穴,并慢慢回味自己的一生.\n\n最后一声枪响,你的回忆结束了.",
			"en": "You raise the pistol, aim it at your temple, and slowly reminisce Your own life.\n\nThe last shot is fired, and your memories are over."
		})
		$Dialogue.visible = true
		$Dialogue.start()
		yield($Dialogue, "dialogue_finished")
		$Dialogue.visible = false
		
	elif d == 2:
		$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
			"zh": "你掷下骰子,骰子无声地转动着...\n\n直到最后骰子终于停了下面,是2.",
			"en": "You rolled the dice, and the dice rolled silently...\n\nUntil the last dice finally stopped, it was 2."
		})
		
		$Dialogue.visible = true
		$Dialogue.start()
		yield($Dialogue, "dialogue_finished")
		$Dialogue.visible = false
		
		$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
			"zh": "你拿起了安眠药,把大量的药片吞了进去,并慢慢回味自己的一生.\n\n最后你的意识逐渐模糊,你的回忆结束了.",
			"en": "You picked up the sleeping pills, swallowed a lot of them, and slowly reminisced Your own life.\n\nIn the end, your consciousness gradually blurs, and your memories are over."
		})
		$Dialogue.visible = true
		$Dialogue.start()
		yield($Dialogue, "dialogue_finished")
		$Dialogue.visible = false
	else:
		$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
			"zh": "你掷下骰子,骰子无声地转动着...\n\n直到最后骰子终于停了下面,是3.",
			"en": "You roll the dice, and the dice roll silently...\n\nUntil the end the dice finally stopped down, it's 3."
		})
		$Dialogue.visible = true
		$Dialogue.start()
		yield($Dialogue, "dialogue_finished")
		$Dialogue.visible = false
		
		$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
			"zh": "你把绳子绑在天花板上,站在凳子把脖子套在绳子上,并慢慢回味自己的一生.\n\n最后你一脚踢开凳子,你的回忆结束了.",
			"en": "You tie the rope to the ceiling, stand on the stool and wrap your neck around the rope, And slowly reminisce about your life.\n\nIn the end, you kicked off the stool and your memory is over."
		})
		
		$Dialogue.visible = true
		$Dialogue.start()
		yield($Dialogue, "dialogue_finished")
		$Dialogue.visible = false
	
	if $Dialogue/MarginContainer/HBoxContainer/Desc.percent_visible == 1:
		$"/root/SceneChanger".change_scene("res://src/end.tscn")
