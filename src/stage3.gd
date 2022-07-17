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
		"zh": "迫于家庭原因,你选择在大学读会计专业,然后毕业后顺利陈章地在一间会计事务所工作...\n\n工作非常繁忙,曾经痴迷dnd,骰子不离手的你,骰子也不知道扔到哪里去了.\n\n虽然你不喜欢这份工作,但是它能够赚足够的钱让你的母亲养病,你也选择慢慢地接受它.",
		"en": "You choose to study accounting, after graduation you work in an accounting firm.\nYou are busy at work, no time to play, the dice has gone don't know where.\nAlthough you don't like the job, but it can make enough money for your mother to recuperate."
	})
	$Dialogue.start()
	yield($Dialogue, "dialogue_finished")
	$Dialogue.visible = false
	
	yield(self.get_tree().create_timer(1.0), "timeout")
	$Bg.play("show")
	yield(self.get_tree().create_timer(0.5), "timeout")
	yield(self.show_dialogue([{
		"content": {
			"zh": "XXX,我有点东西想要和你说.",
			"en": "XXX,I have something to talk"
		},
		"pos": Vector2(900, 375)
	}]), "completed")
	$Bg.play("turn")
	yield($Bg, "animation_finished")
	$Bg.play("after_turn")
	
	yield(self.show_dialogue([{
		"content": {
			"zh": "是这样的,因为XXX原因,我们急需要人手.",
			"en": "Because of XXX reasons, we urgently need manpower."
		},
		"pos": Vector2(900, 375)
	}, {
		"content": {
			"zh": "我知道你已经连续加班了几个月了,但是只能辛苦下你了.",
			"en": "I know that you have been working overtime for several months, but you need to work overtime more long time."
		},
		"pos": Vector2(900, 375)
	}, {
		"content": {
			"zh": "你也知道的,要把集体利益放在第一位,没有集体利益哪来的个人利益.",
			"en": "You also know that the collective interest must be put first, and there is no individual interest where the collective interest can come from."
		},
		"pos": Vector2(900, 375)
	}]), "completed")
	
	
	$Dialogue.visible = true
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
		"zh": "面对加班的要求,你选择是?",
		"en": "Faced with the requirement of overtime, what's your choice?"
	})
	
	$Dialogue.add_option({
		"text": I18n.translate({
			"zh": "去他的老子不干了!",
			"en": "Shit, I'm out!"
		}),
		"disabled": true
	})
	var node = $Dialogue.add_option({
		"text": I18n.translate({
			"zh": "加班,生活要紧",
			"en": "Work overtime, life matters"
		}),
		"disabled": false
	})
	$Dialogue.start()
	node.connect("pressed", self, "change_scene")
	yield($Dialogue, "dialogue_finished")
	$Dialogue.visible = false
	

func change_scene():
	if $Dialogue/MarginContainer/HBoxContainer/Desc.percent_visible == 1:
		$"/root/SceneChanger".change_scene("res://src/stage4.tscn")
