extends Area2D

@export_file("*.tscn") var target_scene_path: String
@onready var prompt = $InteractPrompt 

var is_player_nearby: bool = false

func _ready() -> void:
	prompt.hide() 
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_nearby = true
		show_prompt(true)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_nearby = false
		show_prompt(false)

func show_prompt(should_show: bool):
	prompt.visible = should_show
	var tween = create_tween()
	var target_alpha = 1.0 if should_show else 0.0
	tween.tween_property(prompt, "modulate:a", target_alpha, 0.2)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_nearby:
		if target_scene_path != "":
			SceneTransition.change_scene(target_scene_path)
