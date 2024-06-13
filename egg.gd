extends AnimatedSprite2D
# ---=== Egg player code ===---

const SQUISH_SCALE = 0.65;
const AIM_CIRCLE_SPIN_SPEED = 2;

var egg_charging = false;
var egg_on_fire = false;
var egg_boosted = false;
var current_mouse_position;
var fireChargeAnim;

var egg_charge_sound;
var PhysicsParent;

var aimCircle;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PhysicsParent = get_node("../");
	PhysicsParent.startChargingEgg.connect(SetEggToCharging);
	PhysicsParent.launchEgg.connect(HandleEggLaunchSounds);
	PhysicsParent.lightEggOnFire.connect(setEggOnFire);
	
	egg_charge_sound = get_node("../../SoundNode/EggCharge");
	set_process_input(true);
	print("Game ready!");
	var kitchen_music = get_node("../../KitchenMusic");		# $KitchenMusic works if it's a child node
	kitchen_music.play();
	aimCircle = get_node("../../AimCircle");
	fireChargeAnim = $FireChargeAnim;
	fireChargeAnim.play("default");
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_mouse_position = get_global_mouse_position();
	aimCircle.rotation += AIM_CIRCLE_SPIN_SPEED * delta;

	if PhysicsParent.isCharging():
		aimCircle.visible = true;
		aimCircle.position = current_mouse_position;
		if not PhysicsParent.isOnFire():
			egg_charge_sound.pitch_scale += .2 * delta;
	else:
		aimCircle.visible = false;
		
	if PhysicsParent.isOnFire():
		fireChargeAnim.visible = true;
	else:
		fireChargeAnim.visible = false;
		
	if PhysicsParent.isBoosted():
		setEggToBoosted();
	
			
# CHARGING FUNCTIONS:

func SetEggToCharging() -> void:
	StartEggChargingSounds();
	modulate = Color(1, 1, 1, 1);		# Erase fire color
	scale.y = SQUISH_SCALE;
	
func StartEggChargingSounds() -> void:
	egg_charge_sound = get_node("../../SoundNode/EggCharge");
	egg_charge_sound.play();
	
# OTHER EGG COLOR EFFECTS:

func setEggOnFire() -> void:
	#egg_on_fire = true;
	modulate = Color(1, .5, .5, 1);		# Set egg to fire color
	fireChargeAnim.visible = true;
	var fire_charge_sound = get_node("../../SoundNode/FireChargeSound");
	fire_charge_sound.play();
	
func setEggToBoosted() -> void:
	#egg_boosted = true;
	modulate = Color(.5, 1, .5, 1);
			
# LAUNCHING FUNCTIONS:
			
func HandleEggLaunchSounds() -> void:
	scale.y = 1;
	var egg_crack_sound = get_node("../../SoundNode/EggCrack");
	egg_crack_sound.play();
	var egg_pop_sound = get_node("../../SoundNode/EggPop");
	egg_pop_sound.play();
	egg_charge_sound.stop();
	egg_charge_sound.pitch_scale = 1;
	
# COLLISION

# Isn't happening
func _on_fridge_area_body_entered(body: Node2D) -> void:
	var bounce_sound = get_node("../../SoundNode/EggBounce");
	bounce_sound.pitch_scale = randf_range(.5, 1.25);
	bounce_sound.play();
