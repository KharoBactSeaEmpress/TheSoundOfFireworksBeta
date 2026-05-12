extends Node2D

@export var intro_dialogue: DialogueResource
@export var intro_title: String = "start"

func _ready() -> void:
	# Small delay to ensure the scene has finished loading visually
	await get_tree().create_timer(0.5).timeout
	start_intro_dialogue()

func start_intro_dialogue():
	# 1. Find the player (assumes they are in the 'player' group)
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		# 2. Freeze the player
		player.is_dialogue_active = true
		
		# 3. Show the dialogue
		var balloon = DialogueManager.show_example_dialogue_balloon(intro_dialogue, intro_title)
		
		# 4. Wait for it to finish
		if balloon:
			await balloon.tree_exited
			
		# 5. Unfreeze the player
		player.is_dialogue_active = false
