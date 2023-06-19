extends Node2D

@export var player:CharacterBody2D
@onready var camera = player.get_node("Camera")
@onready var tilemap = $TileMap
@onready var star_path = preload("res://items/star.tscn")
var out = false
var shoots = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var used_rect = tilemap.get_used_rect()
	var num_horizontal_tiles = used_rect.size.x
	var limit = num_horizontal_tiles * 32
	camera.limit_right = limit



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):

	if player.position.y > player.get_node("Camera").limit_bottom + player.get_node("collistion").shape.size.y * 2:
			off_screen()
	if Input.is_action_just_pressed("powerup"):
		shoot_star()
			
			
	
func fade_to_level_menu(_time:float):
	for node in self.get_children(true):
		node.set_physics_process(false)
		node.set_process(false)
	for node in $enemys.get_children(false):
			node.set_physics_process(false)
			node.set_process(false)
	$music_animations.play("fade_out")
	$transitions/fade.play_backwards("out")
	$transitions.visible = true

	


func off_screen():
	get_tree().reload_current_scene()


func shoot_star():
	if shoots <= 2:
		var star = star_path.instantiate()
		add_child(star)
		star.transform.origin = player.global_position + Vector2(50,0)
		star.add_to_group("star")
		star.set_process(true)
		print("star")
		shoots += 1


func _on_star_body_entered(body, n):
	if body.name == "player":
		body.powerup = true
		get_node("items/" + n).queue_free()

