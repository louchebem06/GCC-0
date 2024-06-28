extends Area2D
class_name InteractionArea


@export var action_name: String = "interact"
@onready var label = $Label

func _ready():
	label.hide()

var interact: Callable = func():
	pass


func _on_body_entered(body):
	#InteractionManager.register_area(self)
	print("Enter")
	label.show()
	pass


func _on_body_exited(body):
	#InteractionManager.unregister_area(self)
	print("Exit")
	label.hide()
	pass
