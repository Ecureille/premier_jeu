extends Node2D

func _ready():
	if %LabelNombrePiece:
		%LabelNombrePiece.text = str(Global.piece)
