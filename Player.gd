extends CharacterBody2D
@onready var attack_scene = load("res://Scenes/sword_range.tscn")
@onready var spawnerlocation = $Spawner.position
const SPEED = 300.0
const JUMP_VELOCITY = -800.0
var Damage = 5
var attacking = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func Attack():
	attacking = true
	var timer = $Timer
	
	var instance = attack_scene.instantiate()
	$Spawner.add_child(instance)
	timer.start()
	
	

func _physics_process(delta):
	
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta
	if Input.is_action_just_pressed("Attack") and attacking == false:
		Attack()
		
		
	Flipper()
	# Handle Jump.
	if (Input.is_action_pressed("Jump")) and is_on_floor():
		$AudioStreamPlayer2D.play()
		velocity.y += JUMP_VELOCITY
	if Input.is_action_just_released("Jump") && velocity.y <0:
		velocity.y = -200
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()


func _on_timer_timeout():
	$Spawner/SwordRange.queue_free()
	attacking = false

func Flipper():
	if Input.is_action_just_pressed("Left"):
		#spawnerlocation.x = -11
		$Sprite2D.flip_h=true
	if Input.is_action_just_pressed("Right"):
		#spawnerlocation.x = 11
		$Sprite2D.flip_h=false


#this is a test to check out github.
