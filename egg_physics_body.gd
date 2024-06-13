extends RigidBody2D

var egg_charging = false;
var egg_on_fire = false;
var egg_boosted = false;

var howLongCharging = 0;
const FIRE_START_TIME = 1.5;
const WEAKEST_EGG_POWER = 200;
const MAX_EGG_POWER = 2000;
const EGG_CHARGE_RATE = 750;
var egg_launch_power = WEAKEST_EGG_POWER;
var current_mouse_position;

var EggArrow;
var myBoost;

signal sendEggSpeed(egg_speed: float);
signal startChargingEgg();
signal launchEgg();
signal lightEggOnFire();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EggArrow = get_node("../EggArrow");
	
	for boost in get_tree().get_nodes_in_group("SPEED_BOOST_AREA"):
		boost.hitSpeedBoost.connect(onBoostHit);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var egg_speed = round(linear_velocity.length() / 10);
	emit_signal("sendEggSpeed", egg_speed);
	
	current_mouse_position = get_global_mouse_position();
	if egg_charging:
		egg_launch_power += EGG_CHARGE_RATE * delta;
		howLongCharging += delta;
		if howLongCharging >= FIRE_START_TIME and not egg_on_fire:
			setEggOnFire();
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var touch_event = event as InputEventMouseButton;
		
		# When the screen is first clicked
		if touch_event.pressed:
			SetEggToCharging();
			emit_signal("startChargingEgg");
		# When the screen is released
		else:
			LaunchEgg();
			SetEggToNormal();
			
func setEggOnFire():
	egg_on_fire = true;
	emit_signal("lightEggOnFire");
			
func SetEggToCharging() -> void:
	egg_charging = true;
	egg_on_fire = false;
	egg_boosted = false;
	
func LaunchEgg() -> void:
	emit_signal("launchEgg");
	var launchAngle = EggArrow.rotation - PI / 2;
	var xLaunch = cos(launchAngle) * egg_launch_power;
	var yLaunch = sin(launchAngle) * egg_launch_power;
	linear_velocity = Vector2(xLaunch, yLaunch);
	angular_velocity = rotation;
	
func SetEggToNormal() -> void:
	egg_boosted = false;
	egg_on_fire = false;
	egg_charging = false;
	egg_launch_power = WEAKEST_EGG_POWER;
	howLongCharging = 0;


func _on_goal_flag_area_body_entered(body: Node2D) -> void:
	print("GOAL REACHED!");
	pass # Replace with function body.


func onBoostHit(boostSpeed, boostAngle):
	egg_boosted = true;
	var boost_sound = get_node("../SoundNode/SpeedBoost");
	boost_sound.play();
	linear_velocity = Vector2(boostSpeed * cos(boostAngle), boostSpeed * sin(boostAngle));
	
# GETTERS

func isCharging():
	#print("returning: ", egg_charging);
	return egg_charging;
	
func isOnFire():
	return egg_on_fire;
	
func isBoosted():
	return egg_boosted;
