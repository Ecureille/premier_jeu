extends Control

@onready var levelSelect = preload("res://scenes/level_select.tscn")
@onready var logo_chargement: Sprite2D = $LogoChargement

func _on_ready() -> void:
	await get_tree().create_timer(2.3).timeout
	get_tree().change_scene_to_packed(levelSelect)

func _process(delta):
	logo_chargement.rotation += delta * 5 # Fait tourner le parent, donc le logo tourne bien
