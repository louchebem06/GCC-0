extends Node2D

@onready var mainMenu = $MainMenu

@onready var inputIP = $MainMenu/InputIP
@onready var joinButton = $MainMenu/JoinButton
@onready var createServerButton = $MainMenu/CreateServerButton

@onready var world = $Map


const DEFAULT_IP = "127.0.0.1";
const PORT = 4242;

signal player_connected(peer_id)
signal player_disconnected(peer_id)

var peer = ENetMultiplayerPeer.new()

var player_scene = preload("res://scenes/player.tscn");

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connection_succeeded)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	joinButton.pressed.connect(self._joinButtonPressed)
	createServerButton.pressed.connect(self._createServerButton)
	world.hide()

func _process(_delta):
	if Input.is_action_just_pressed("Close"):
		get_tree().quit()

func _joinButtonPressed():
	if inputIP.text == null || inputIP.text == "":
		peer.create_client(DEFAULT_IP, PORT)
	else:
		peer.create_client(inputIP.text, PORT)
	multiplayer.multiplayer_peer = peer

func _createServerButton():
	if (peer.create_server(PORT) == OK):
		multiplayer.multiplayer_peer = peer
		_add_player(multiplayer.get_unique_id())
		mainMenu.hide()
		world.show()

@rpc("any_peer")
func _add_player(id):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred('add_child', player);

func _remove_player(id):
	var player_name = str(id)
	var player = get_node_or_null(player_name)
	if player:
		player.queue_free()

func _on_player_connected(id):
	world.show()
	emit_signal("player_connected", id)

func _on_player_disconnected(id):
	_remove_player(id)
	emit_signal("player_disconnected", id)

func _on_connection_succeeded():
	mainMenu.hide()
	rpc("_add_player", multiplayer.get_unique_id())

func _on_connection_failed():
	mainMenu.show()
	world.hide();

func _on_server_disconnected():
	mainMenu.show()
	world.hide();
