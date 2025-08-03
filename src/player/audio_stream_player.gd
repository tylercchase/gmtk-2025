extends AudioStreamPlayer


func _ready() -> void:
    finished.connect(replay_but_different)
    play()


func replay_but_different():
    pitch_scale = 0.3 + randf() / 2
    play()
    pass