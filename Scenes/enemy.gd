extends CharacterBody2D
var player_pos
var target_pos

@onready var player = get_parent().get_node("Player") 
const SPEED = 100
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	
	
	velocity = position.direction_to(player_pos) * SPEED
	
	move_and_slide()
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	
	move_and_slide()
