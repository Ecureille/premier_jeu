extends CharacterBody2D

@onready var SpriteFastFood: Sprite2D = $SpriteFastFood
@onready var KillCollisionShape: CollisionShape2D = $Killzone/CollisionShape2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_vision: RayCast2D = $RayCastVision

@export var vitesse_normale: float = 200
@export var vitesse_alerte: float = 800
@export var vision_distance: float = 1000

var direction = 1
var player_node = null

func _ready():
	var skins = [
		preload("res://assets/level1/Burger.png"), preload("res://assets/level1/CuissePoulet.png"),
		preload("res://assets/level1/Donut.png"), preload("res://assets/level1/Frites.png"),
		preload("res://assets/level1/Glace.png"), preload("res://assets/level1/Sandwich.png"),
		preload("res://assets/level1/Soda.png"), preload("res://assets/level1/SoupeChinoise.png"),
		preload("res://assets/level1/Sushi.png"), preload("res://assets/level1/Tacos.png")
	]
	var random_skin = skins[randi() % skins.size()]
	SpriteFastFood.texture = random_skin
	var rect_shape = KillCollisionShape.shape
	if rect_shape is RectangleShape2D and random_skin.get_size() != Vector2.ZERO:
		SpriteFastFood.scale = rect_shape.size / random_skin.get_size()
		
	player_node = get_parent().get_node_or_null("Player")
	call_deferred("configurer_vision")

func configurer_vision():
	ray_cast_vision.add_exception(self)
	
	var voisins = get_parent().get_children()
	for voisin in voisins:
		if "Ennemie" in voisin.name:
			ray_cast_vision.add_exception(voisin)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player_node:
		var distance = global_position.distance_to(player_node.global_position)
		
		if distance < vision_distance:
			ray_cast_vision.target_position = to_local(player_node.global_position)
			ray_cast_vision.force_raycast_update()
			
			if ray_cast_vision.is_colliding():
				var objet_touche = ray_cast_vision.get_collider()
				
				# DEBUG : Regarde ce message dans la console en bas !
				print("Je touche : ", objet_touche.name) 
				
				if objet_touche.name == "Player":
					print(">>> JE TE VOIS (Pas de mur) <<<")
	
	if ray_cast_right.is_colliding():
		direction = -1
		SpriteFastFood.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		SpriteFastFood.flip_h = false
	position.x += direction * vitesse_normale * delta
	move_and_slide()

func _on_tete_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		body.velocity.y = -700
		queue_free()
