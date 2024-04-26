class_name HealthBar
extends TextureProgressBar

@export var shake_amp_over_health: Curve

@onready var particles: GPUParticles2D = get_node("%GPUParticles2D")

func _ready() -> void:
	shake_amp_over_health.bake()
	Events.player_damaged.connect(_on_player_damaged)

func health_progress_changed(progress: float) -> void:
	material.set("shader_parameter/amplitude", shake_amp_over_health.sample_baked(progress))

func _on_player_damaged(amount: int, _dealer: DamageDealer) -> void:
	particles.amount = max(1, amount)
	particles.restart()
	var tween := create_tween()
	if !tween:
		return
	tween.tween_property(material, "shader_parameter/amplitude_2", 0.0, 0.6).from(2)
