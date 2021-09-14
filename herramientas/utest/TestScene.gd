extends PanelContainer
class_name TestScene, "./TestScene.icon.png"

onready var Results: TabContainer = $Core/Results
onready var Summary: HBoxContainer = $Core/Summary

func _ready():
	for c in get_children():
		print(c)
	_run_tests()
	

func _run_tests():
	Results.clear()
	
	var tests: Array = get_tests()
	Summary.time()
	var instance = preload("res://addons/WAT/runner/TestRunner.gd").new()
	add_child(instance)
	var results: Array = yield(instance.run(tests, 1, 1, Results), "completed")
	instance.queue_free()
	_on_test_run_finished(results)
	
func _on_test_run_finished(results: Array) -> void:
	Summary.summarize(results)
	
func get_tests():
	pass
