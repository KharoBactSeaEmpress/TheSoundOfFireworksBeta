extends CharacterBody2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@export var scary_face_1: Texture2D 
@export var scary_face_2: Texture2D

@onready var sprite = $Sprite2D
@onready var anim = $AnimationPlayer 

var was_talked_to: bool = false

func _ready() -> void:
	GameState.glitch_triggered.connect(_on_glitch_triggered)

func _on_glitch_triggered():
	if anim:
		anim.stop()
	sprite.stop() 

	if scary_face_1:
		var glitch_frames = SpriteFrames.new()
		glitch_frames.add_animation("scary")
		glitch_frames.add_frame("scary", scary_face_1)
		sprite.sprite_frames = glitch_frames
		sprite.play("scary")

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
