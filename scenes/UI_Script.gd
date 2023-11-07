extends CanvasLayer

@onready var scoreText = %ScoreText
@onready var highScoreText = %HighScoreText
var highScore = 0
var save_path = "user://score.save"
var score = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	load_score()
	pass


func _update_high_score():
	highScoreText.text = str(highScoreText)

func _update_score(blah):
	var original = int(scoreText.text)
	original += blah
	scoreText.text = str(original)
	score = original

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_score():
	print("saving high score")
	highScore = score
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(highScore)
	
func load_score():
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		highScore = file.get_var()
	else:
		print("file not found")
		highScore = 0
