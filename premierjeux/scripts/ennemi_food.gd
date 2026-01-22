extends CharacterBody2D

@onready var SpriteFastFood: Sprite2D = $SpriteFastFood
@onready var KillCollisionShape: CollisionShape2D = $Killzone/CollisionShape2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var sprite_fast_food: Sprite2D = $SpriteFastFood

@export var vitesse_normale: float = 200
@export var vitesse_alerte: float = 300
@export var vision_distance: float = 300

var direction = 1

func _ready():
	var skins = [
		preload("res://assets/level1/Burger.png"),
		preload("res://assets/level1/CuissePoulet.png"),
		preload("res://assets/level1/Donut.png"),
		preload("res://assets/level1/Frites.png"),
		preload("res://assets/level1/Glace.png"),
		preload("res://assets/level1/Sandwich.png"),
		preload("res://assets/level1/Soda.png"),
		preload("res://assets/level1/SoupeChinoise.png"),
		preload("res://assets/level1/Sushi.png"),
		preload("res://assets/level1/Tacos.png")
	]
	
	var random_skin = skins[randi() % skins.size()]
	SpriteFastFood.texture = random_skin
	
	# 👉 Récupérer la taille de la hitbox
	var rect_shape := KillCollisionShape.shape
	if rect_shape is RectangleShape2D:
		var target_size = rect_shape.size

		# 👉 Taille réelle de l'image
		var texture_size = random_skin.get_size()

		if texture_size != Vector2.ZERO:
			# 👉 Ajuster le scale du sprite pour qu'il corresponde à la hitbox
			SpriteFastFood.scale = target_size / texture_size

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		sprite_fast_food.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		sprite_fast_food.flip_h = false
	position.x += direction * vitesse_normale * delta

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func _on_tete_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		print("le collition shape est rectangle")
		body.velocity.y = -700
		queue_free()
