extends CharacterBody3D

# Export variables for easy tweaking in the editor
@export var jump_strength: float = 5.0  # How high/fast the enemy jumps
@export var jump_duration: float = 0.5  # Time to reach peak of jump
@export var detection_area: Area3D  # Reference to the Area3D node
@export var jump_animation: String = "jump_scare"  # Name of animation (if using AnimationPlayer)
@export var scare_sound: AudioStream  # Optional sound for scare effect

var has_jumped: bool = false  # Prevent multiple jumps
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animation_player: AnimationPlayer = $AnimationPlayer  # Reference to AnimationPlayer
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D  # Optional audio player

#func _ready():
	## Connect the Area3D's body_entered signal
	#if detection_area:
		#detection_area.body_entered.connect(_on_area_3d_body_entered)
	#else:
		#push_error("Area3D not assigned to enemy!")

func _physics_process(delta):
	# Apply gravity when in the air
	if not is_on_floor() and has_jumped:
		velocity.y -= gravity * delta
		move_and_slide()

func _on_area_3d_body_entered(body: Node3D):
	print("body entered")
	# Check if the entering body is the player (assumes player is in "Player" group)
	if body.is_in_group("PlayerCharacter") and not has_jumped:
		print("boo")
		has_jumped = true  # Prevent re-triggering
		perform_jump_scare()

func perform_jump_scare():
	# Option 1: Physics-based jump
	velocity.y = jump_strength
	move_and_slide()

	# Option 2: Animation-based jump (if using AnimationPlayer)
	if animation_player and animation_player.has_animation(jump_animation):
		animation_player.play(jump_animation)

	# Play scare sound (if assigned)
	if scare_sound and audio_player:
		audio_player.stream = scare_sound
		audio_player.play()

	# Optional: Move enemy slightly toward player for effect
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * 0.5  # Small lunge toward player
