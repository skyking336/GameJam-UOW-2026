extends Node

var have_fire = false
var have_ice = false
var have_poision = false

var abilities : Array[String]

func add_ability(ability : String):
	abilities.append(ability)

func check_ability():
	for i in abilities.size():
		if abilities[i] == "Fire":
			have_fire = true
		if abilities[i] == "Ice":
			have_ice = true
		if abilities[i] == "Poison":
			have_poision = true
			

	
