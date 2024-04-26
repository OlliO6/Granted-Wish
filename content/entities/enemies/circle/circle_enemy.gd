extends CharacterBody2D

const STOP_CHASE_DIST = 0.3

@export var speed: float

@onready var knockback: Knockback = $Knockback
@onready var sm: StateMachine = $StateMachine
@onready var idle_state: State = $StateMachine/IdleState
@onready var dead_state: State = $StateMachine/DeadState
@onready var celebrate_hit_state: State = $StateMachine/CelebrateHitState

var rush_dir: Vector2

func _physics_process(_delta: float) -> void:
	
	match sm.state:
		idle_state:
			var player := Globals.game.get_player() as Player
			rush_dir = (player.global_position - global_position)
			
			if rush_dir.length() < STOP_CHASE_DIST:
				return
				
			rush_dir = rush_dir.normalized()
			velocity = rush_dir * speed
		
		dead_state:
			velocity = Vector2.ZERO
		
		celebrate_hit_state:
			velocity = Vector2.ZERO
	
	velocity = knockback.compute_velocity(velocity)
	move_and_slide()

func _on_idle_state_entered() -> void:
	pass

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn":
		sm.switch_state(idle_state)

func _on_damage_taken(amount: int, dealer: DamageDealer) -> void:
	pass

func _on_dealed_damage(receiver: DamageReceiver) -> void:
	celebrate_hit_state.enter()
