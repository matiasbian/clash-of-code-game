extends TutoLevelTwo


func _get_dialogs():
	return [
		{
			"dialog": "TUTORIAL_03_00"
		},
		{
			"dialog": "TUTORIAL_03_01"
		},
		{
			"dialog": "TUTORIAL_03_02"
		},
		{
			"dialog": 'TUTORIAL_03_03',
			"action": _show_sel_com_and_show
		},
		{
			"dialog": 'TUTORIAL_03_04',
			"action": show_avaialable_commands,
			"param": "Put"
		},
		{
			"dialog": "TUTORIAL_03_05",
			"action": _reparent_selected_commands,
			"param" : false
		},
		{
			"dialog": 'TUTORIAL_03_06',
			"action": show_forward
		},
		{
			"dialog": 'TUTORIAL_03_07'
		},
		{
			"dialog": "TUTORIAL_03_08"
		}
	]

	


func _show_button(button = "Right"):
	show_specific_command(button)
	game_manager.action_added.connect(self.go_and_remove)
	
	
	
