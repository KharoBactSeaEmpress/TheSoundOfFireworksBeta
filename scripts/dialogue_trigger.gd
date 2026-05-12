extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready() -> void:
	# Connect the signal via code for ease of use
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# 1. Verify it's the player
	if body.is_in_group("player"):
		# 2. IMMEDIATELY disable the area so it can't trigger again
		# We use set_deferred because we can't change physics state mid-collision
		set_deferred("monitoring", false)
		
		trigger_cutscene(body)

func trigger_cutscene(player: CharacterBody2D):
	# 3. Lock the player
	if "is_dialogue_active" in player:
		player.is_dialogue_active = true
	
	# 4. Show the dialogue
	var balloon = DialogueManager.show_example_dialogue_balloon(
		dialogue_resource, 
		dialogue_start
	)
	
	# 5. Wait for the player to finish the dialogue
	if balloon:
		await balloon.tree_exited
	
	# 6. Unlock the player
	if "is_dialogue_active" in player:
		player.is_dialogue_active = false
	
	# 7. Optionally delete the trigger node to clean up memory
	queue_free()
