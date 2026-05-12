extends Area2D

@export_file("*.tscn") var next_scene_path: String

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		set_deferred("monitoring", false) 
		
		if next_scene_path != "":
			SceneTransition.change_scene(next_scene_path)
		else:
			print("Warning: No next scene path set on this exit!")
