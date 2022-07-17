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
		"zh": "你平稳地度过了一生,组建了一个家庭,有了儿子和孙子孙女.\n\n最后你生命的最后一刻终于来临...",
		"en": "You lived your life peacefully, started a family, had sons and grandchildren.\n\nThe last moment of your life has finally come..."
	})
	$Dialogue.start()
	yield($Dialogue, "dialogue_finished")
	$Dialogue.visible = false
	
	yield(self.show_dialogue([{
		"content": {
			"zh": "医生,我爸爸的情况怎么样?",
			"en": "Doctor, how is my father?"
		},
		"pos": Vector2(590, 375)
	}]), "completed")
	
	yield(self.show_dialogue([{
		"content": {
			"zh": "说实话,情况很糟糕,不过如果接受化疗的话应该可以多活几年.",
			"en": "To be honest, the situation is terrible, but if you get chemotherapy he can live a few more years."
		},
		"pos": Vector2(690, 375)
	}, {
		"content": {
			"zh": "可是病人不愿意接受化疗,他认为化疗太痛苦了,不如带着尊严死去.",
			"en": "The patient was reluctant to accept chemotherapy, he thought that chemotherapy was too painful, and it was better to die with dignity."
		},
		"pos": Vector2(690, 375)
	}, {
		"content": {
			"zh": "爸爸!接受化疗吧!我们不想失去你!",
			"en": "Dad! Get chemo! We don't want to lose you!"
		},
		"pos": Vector2(590, 375)
	}]), "completed")
	
	
	$Dialogue.visible = true
	$Dialogue/MarginContainer/HBoxContainer/Desc.bbcode_text = I18n.translate({
		"zh": "面对你儿子的请求,你选择是?",
		"en": "Faced with your son's request, what's your choice?"
	})
	
	$Dialogue.add_option({
		"text": I18n.translate({
			"zh": "放弃治疗",
			"en": "Abandon treatment"
		}),
		"disabled": true
	})
	var node = $Dialogue.add_option({
		"text": I18n.translate({
			"zh": "接受治疗",
			"en": "Accept treatment"
		}),
		"disabled": false
	})
	node.connect("pressed", self, "change_scene")
	$Dialogue.start()
	yield($Dialogue, "dialogue_finished")
	$Dialogue.visible = false

func change_scene():
	if $Dialogue/MarginContainer/HBoxContainer/Desc.percent_visible == 1:
		$"/root/SceneChanger".change_scene("res://src/stage5.tscn")
