extends Control

@onready var Loading = preload("res://scenes/loading.tscn")

func _on_start_btn_button_down() -> void:
	get_tree().change_scene_to_packed(Loading)


func _on_quit_btn_button_down() -> void:
	get_tree().quit()
	
