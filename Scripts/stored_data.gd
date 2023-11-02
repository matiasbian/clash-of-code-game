extends Node

var save_path = "user://%s.save"

func save(path, data):
	var _path = save_path % path
	
	var file = FileAccess.open(_path, FileAccess.WRITE)
	file.store_var(data)

func load(data):
	var path = save_path % data
	
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		return file.get_var()
	else:
		return false
