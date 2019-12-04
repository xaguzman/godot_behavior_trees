tool
extends HBoxContainer

signal removed(index)

onready var label := $LabelIndex


export (int) var index = 0 setget set_index

func set_index(val: int)->void:
    if label:
        index = val
        label.text = str(index)
    else:
        call_deferred("set_index", val)

func _on_Delete_pressed():
    call_deferred("emit_signal", "removed", index)
