extends CharacterBody2D

const SPEED = 400.0
const SPEED_SPRINT = 800.0
var CURRENT_SPEED = 0

const JUMP_VELOCITY = -600.0
const JUMP_VELOCITY_SPRINT = -710.0
var CURRENT_VELOCITY = 0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var Layer1 = %Layer1
@onready var LabelNombrePiece = %LabelNombrePiece

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("shift"):
		CURRENT_SPEED = SPEED_SPRINT
		CURRENT_VELOCITY = JUMP_VELOCITY_SPRINT
	else:
		CURRENT_SPEED = SPEED
		CURRENT_VELOCITY = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = CURRENT_VELOCITY
		
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 1 :
		velocity.x = direction * CURRENT_SPEED
		sprite_2d.flip_h = false
	elif direction == -1 :
		velocity.x = direction * CURRENT_SPEED
		sprite_2d.flip_h = true
	else :
		velocity.x = move_toward(velocity.x, 0, CURRENT_SPEED)
		
	move_and_slide()

func _process(_delta):
	# Convertir la position globale en position locale relative au TileMap
	var local_pos = Layer1.to_local(global_position)

	# Convertir la position locale en coordonnées de cellule (cellule de la grille)
	var case = Layer1.local_to_map(local_pos)

	# Obtenir l'identifiant de la source de tuile à cette cellule
	var id_tuile = Layer1.get_cell_source_id(case)

	# Obtenir les coordonnées de la tuile dans son atlas (si tu utilises un tileset atlas)
	var atlas_coords = Layer1.get_cell_atlas_coords(case)

	# Exemple de condition plus précise : on vérifie ID + coordonnée dans l'atlas
	if id_tuile == 0 and atlas_coords == Vector2i(11, 7):  # exemple de coordonnées
		Global.piece = Global.piece + 1
		LabelNombrePiece.text = str(Global.piece)
		Layer1.set_cell(case, -1)  # supprimer la tuile
