extends Node2D

var dialogueScene = preload("res://src/PersonDialogue.tscn")

func show_dialogue(dialog):
	for item in dialog:
		var d1 = self.dialogueScene.instance()
		self.add_child(d1)
		d1.start(I18n.translate(item.content), item.pos)
		yield(d1, "dialogue_finished")

func _ready():
	$Dialogue.visible = true
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
		"zh": "随着时间逝去,你长大成为了一个青年...\n\n你平常喜欢玩dnd,骰子不离手,而今天是要讨论你上大学要读哪一个专业.",
		"en": "As time goes by, you grow up and become a young man...\n\nYou usually like to play dnd and keep dice in your hands, today is to discuss which major you want to study in college."
	})
	$Dialogue.start()
	yield($Dialogue, "dialogue_finished")
	$Dialogue.visible = false
	
	yield(self.show_dialogue([{
		"content": {
			"zh": "孩子,没想到转眼间你就要上大学了.",
			"en": "Boy, times go so fast, you are in the age go to college."
		},
		"pos": Vector2(517, 400)
	}, {
		"content": {
			"zh": "是啊,我们的孩子聪明伶俐,应该选择一门赚钱的专业.",
			"en": "Our children are smart and should choose a career that makes money."
		},
		"pos": Vector2(770, 400)
	}, {
		"content": {
			"zh": "我看孩子平时很喜欢玩游戏,要不跟随兴趣报游戏设计相关的专业吧.",
			"en": "He like playing games, why not just follow the interest, learn game design majors?"
		},
		"pos": Vector2(517, 400)
	}, {
		"content": {
			"zh": "游戏这东西太不务正业了,而且也赚不了多少钱.",
			"en": "Playing games has no future, and it doesn't make much money."
		},
		"pos": Vector2(770, 400)
	}, {
		"content": {
			"zh": "而且你最近不是还检查出病吗,要治好可要花大量的钱.",
			"en": "And you have been diagnosed recently, it will cost a lot of money to cure."
		},
		"pos": Vector2(770, 400)
	}, {
		"content": {
			"zh": "我觉得应该还是交给孩子自己选择.",
			"en": "I think it should be left to the kid to choose."
		},
		"pos": Vector2(517, 400)
	}]), "completed")
	
	
	$Dialogue.visible = true
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
		"zh": "你选择读什么专业?",
		"en": "What major do you choose to study?"
	})
	
	$Dialogue.add_option({
		"text": I18n.translate({
			"zh": "游戏设计",
			"en": "Game design"
		}),
		"disabled": true
	})
	var node = $Dialogue.add_option({
		"text": I18n.translate({
			"zh": "会计",
			"en": "Accounting"
		}),
		"disabled": false
	})
	node.connect("pressed", self, "change_scene")
	$Dialogue.start()
	yield($Dialogue, "dialogue_finished")
	$Dialogue.visible = false
	
func change_scene():
	if $Dialogue/MarginContainer/HBoxContainer/Desc.percent_visible == 1:
		$"/root/SceneChanger".change_scene("res://src/stage3.tscn")
