class_name UnlockAtLevel

func _init(min_level, elem, only_disable = true):
	var level = GlobalVar.level
	if (level < min_level):
		if (only_disable):
			elem.disabled = true
		else:
			elem.visible = false
