extends CharacterBody2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

var was_talked_to: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not was_talked_to:
		was_talked_to = true

		if "is_dialogue_active" in body:
			body.is_dialogue_active = true
		
		var balloon = DialogueManager.show_example_dialogue_balloon(
			dialogue_resource, 
			dialogue_start
		)
		
		if balloon:
			await balloon.tree_exited
		
		if "is_dialogue_active" in body:
			body.is_dialogue_active = false

func disable_npc():
	was_talked_to = true
