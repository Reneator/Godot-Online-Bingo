extends Node

signal start_game(session)
signal client_ready(session)

remote func start_game(session):
	emit_signal("start_game", session)

remote func client_ready(session):
	emit_signal("client_ready", session)
