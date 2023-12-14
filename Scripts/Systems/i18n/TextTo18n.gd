class_name TextTo18n extends Node

var key:String = ""

func _init(_key, elem):
	key = _key
	elem.text = tr(key)
