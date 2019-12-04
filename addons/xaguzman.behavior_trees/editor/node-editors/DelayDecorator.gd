tool
extends GraphNode

export (float) var time setget set_time

onready var textbox := $HBoxContainer/Value

func _ready():
    set_slot(0, true, 0, BTEditorGlobals.DEFAULT_NODE_COLOR, true, 0, BTEditorGlobals.DEFAULT_NODE_COLOR)

func set_time(val: float)->void:
    time = val
    textbox.text = str(val)

func _on_Value_text_changed():
    time = int(textbox.text)
