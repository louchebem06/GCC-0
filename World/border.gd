extends StaticBody2D
@onready var collision_polygon_2d = $CollisionPolygon2D
@onready var polygon_2d = $Polygon2D
@onready var torch = $"../Torch"


func _ready():
	RenderingServer.set_default_clear_color( Color( 0.47, 0.53, 0.6, 1 ))

