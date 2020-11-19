extends Node

var entries

var user_name = ""

var lobby_key = ""

#clean up the session logic

var session : Session

var game_session: Session

var host_session: Session

var saved_ip_address = "127.0.0.1:37256"

var max_players = 100

var is_host = false

var is_connected = false
