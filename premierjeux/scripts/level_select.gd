extends Control

@onready var levels: Array = [$level1/TextureRect, $level2/TextureRect, $level3/TextureRect,$level4/TextureRect ,$level5/TextureRect]
var current_world: int = 0
@onready var firstLevel = preload("res://scenes/Level1.tscn")

func _ready():
	$imgPlayer.global_position = levels[current_world].global_position
	
func _input(event):
	if event.is_action_pressed("ui_left") and current_world > 0:
		$imgPlayer.flip_h = true
		current_world -= 1
		$imgPlayer.global_position = levels[current_world].global_position
		
	if event.is_action_pressed("ui_right") and current_world < levels.size()-1 :
		$imgPlayer.flip_h = false
		current_world += 1
		$imgPlayer.global_position = levels[current_world].global_position
		
	if	event.is_action_pressed("ui_text_submit"):
		match current_world:
			0:
				get_tree().change_scene_to_packed(firstLevel)
			1:
				print("Valeur est 2")
			2:
				print("Valeur est 3")
			3:
				print("Valeur est 4")
			4:
				print("Valeur est 5")
			_:
				print("Autre valeur")
