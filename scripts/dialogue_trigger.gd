extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		set_deferred("monitoring", false)
		
		trigger_cutscene(body)

func trigger_cutscene(player: CharacterBody2D):
	if "is_dialogue_active" in player:
		player.is_dialogue_active = true
	
	var balloon = DialogueManager.show_example_dialogue_balloon(
		dialogue_resource, 
		dialogue_start
	)
	
	if balloon:
		await balloon.tree_exited
	
	if "is_dialogue_active" in player:
		player.is_dialogue_active = false
	queue_free()
