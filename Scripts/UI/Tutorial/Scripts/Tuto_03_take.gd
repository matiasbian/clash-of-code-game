extends TutoLevelTwo


func _get_dialogs():
	return [
		{
			"dialog": "TUTORIAL_03B_00"
		},
		{
			"dialog": "TUTORIAL_03B_01"
		},
		{
			"dialog": "TUTORIAL_03B_02"
		},
		{
			"dialog": 'TUTORIAL_03B_03',
			"action": _show_sel_com_and_show
		},
		{
			"dialog": 'TUTORIAL_03B_04',
			"action": show_avaialable_commands,
			"param": "Take"
		},
		{
			"dialog": "TUTORIAL_03B_05",
			"action": _reparent_selected_commands,
			"param" : false
		},
		{
			"dialog": 'TUTORIAL_03B_06',
			"action": show_forward
		},
		{
			"dialog": 'TUTORIAL_03B_07'
		},
		{
			"dialog": "TUTORIAL_03B_08"
		}
	]
func _show_sel_com_and_show():
	jump_child = 6
	show_specific_command()
	
	temp_available_commands_container.visible = true
	
	avail_parent.remove_child(available_commands)
	temp_available_commands_container.add_child(available_commands)
	available_commands.set_owner(temp_available_commands_container)
	
	game_manager.action_added.connect(self.go_and_remove)
	
func go_and_remove(btn):
	game_manager.action_added.disconnect(go_and_remove)
	go()
	

func _show_button(button = "Right"):
	show_specific_command(button)
	game_manager.action_added.connect(self.go_and_remove)
	
	
	
