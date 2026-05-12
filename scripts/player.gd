extends CharacterBody2D
@onready var sprite = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = 0.0

var current_interactable = null 
var is_dialogue_active: bool = false 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	#--------------------------------------
	#SCRAPPED
	if Input.is_action_just_pressed("ui_accept"):
		if is_dialogue_active:
			print("Action ignored: Dialogue is already running.")
		elif current_interactable:
			talk()
		elif is_on_floor():
			velocity.y = JUMP_VELOCITY
	#--------------------------------------
	if not is_dialogue_active:
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = 0
		velocity.y = 0
	if velocity.x > 0:
		sprite.flip_h = false 
	elif velocity.x < 0:
		sprite.flip_h = true  

	if velocity.x != 0:
		sprite.play("walk")
	else:
		sprite.play("idle")
	move_and_slide()

func talk() -> void:
	if current_interactable and not current_interactable.was_talked_to:
		is_dialogue_active = true
		var balloon = DialogueManager.show_example_dialogue_balloon(
			current_interactable.dialogue_resource, 
			current_interactable.dialogue_start,
			[current_interactable]
		)
		if balloon:
			await balloon.tree_exited
			current_interactable.was_talked_to = true
		is_dialogue_active = false
	elif current_interactable:
		print("This NPC has nothing more to say")
	

func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		print("Something entered the area: ", body.name)
		current_interactable = body


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body == current_interactable:
		current_interactable = null
