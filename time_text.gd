extends Label

var timeLeft;
const STARTING_LEVEL_TIME = 40;
const FLASH_TIME = 0.5;
var NORMAL_TEXT_COLOR;

var seconds;
var milliseconds = 0;
var timeThisSecond = 0;

var timer_running = true;
var lastTenSeconds = false;

var lastTenSecondsSound;
var timeOutSound;
var timerNormalSound;

var goalFlag;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NORMAL_TEXT_COLOR = self.modulate;
	
	lastTenSecondsSound = get_node("../LastTenSeconds");
	timeOutSound = get_node("../TimeOut");
	timerNormalSound = get_node("../TimerNormal");
	
	timeLeft = STARTING_LEVEL_TIME;
	seconds = STARTING_LEVEL_TIME;
	
	goalFlag = get_tree().get_first_node_in_group("GOAL_FLAG");
	goalFlag.goalReached.connect(onGoalReached);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_running: updateTimer(delta);
	
	
func updateTimer(delta):
	timeLeft -= delta;
	if timeLeft <= 0:
		timer_running = false;
		timeOutSound.play();
		text = "TIME: 00:00";
		setTextRed();
	else:
		timeThisSecond += delta;
		seconds = int(timeLeft);
		milliseconds = int((timeLeft - seconds) * 100)
		var timeDisplay = "%02d:%02d";
		timeDisplay = (timeDisplay % [seconds, milliseconds]);
		text = "TIME: " + timeDisplay;
		
		if timeThisSecond > 1:
			timeThisSecond -= 1;
			if not lastTenSeconds and seconds == 9:
				lastTenSeconds = true;
			if lastTenSeconds and timer_running:
				flashTextRed();
				lastTenSecondsSound.play();
			else:
				flashTextGreen();
				timerNormalSound.play();
				
func onGoalReached():
	timer_running = false;

func flashTextRed():
	setTextRed();
	var tween = create_tween();
	tween.parallel().tween_property(self, "modulate", NORMAL_TEXT_COLOR, FLASH_TIME);
	
func flashTextGreen():
	setTextGreen();
	var tween = create_tween();
	tween.parallel().tween_property(self, "modulate", NORMAL_TEXT_COLOR, FLASH_TIME);
	
func setTextRed():
	modulate = Color(1, .5, .5, 1);
	
func setTextGreen():
	modulate = Color(.5, 1, .5, 1);
