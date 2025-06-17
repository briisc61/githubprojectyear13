extends VBoxContainer

const TEMPLATE_MAP_SCENE = preload("res://addons/Map/TemplateMapScene.tscn")


func _on_button_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(TEMPLATE_MAP_SCENE)




func _on_button_3_quit_pressed() -> void:
	get_tree().quit()
