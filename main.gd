@tool
extends Node

@onready var shaderRect : ColorRect = $ColorRect

enum PALETTE {
	ORIGINAL,
	HARSH,
	GREY
}

const PALETTE_COLORS = {
	"ORIGINAL" = ["#c7f0d8", "#43523d"],
	"HARSH" = ["#9bc700", "#2b3f09"],
	"GREY" = ["#879188", "#1a1914"]
}

@export var palette: PALETTE = PALETTE.ORIGINAL: set = _set_palette

var shader : ShaderMaterial

func _ready() -> void:
	shader = shaderRect.material as ShaderMaterial;
	update_palette()

func update_palette() -> void:
	var colors : Array = get_palette_colors(palette)
	shaderRect.material.set("shader_parameter/color_white", Color(colors[0]))
	shaderRect.material.set("shader_parameter/color_black", Color(colors[1]))

func get_palette_colors(the_palette: PALETTE):
	match the_palette:
		PALETTE.ORIGINAL:
			return PALETTE_COLORS["ORIGINAL"]
		PALETTE.HARSH:
			return PALETTE_COLORS["HARSH"]
		PALETTE.GREY:
			return PALETTE_COLORS["GREY"]

func _set_palette(new_palette : PALETTE) -> void:
	palette = new_palette
	update_palette()
	
