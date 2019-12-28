tool
extends Node

#class_name BehaviorTree, "res://addons/xaguzman.behavior_trees/editor/icons/icon_tree.svg"
const BehaviorTreeEditor = preload("res://addons/xaguzman.behavior_trees/editor/BehaviorTreeEditor.tscn")

export (PackedScene) var editor setget ,get_editor

var editor_node : GraphEdit setget ,get_editor_node

var root_node


func get_editor()->PackedScene:
    if not editor:
        print_debug("getting empty editor")
        editor = BehaviorTreeEditor
    
    return editor

func get_editor_node() -> GraphEdit:
    editor_node = get_editor().instance()
    return editor_node

#func set_editor(val: PackedScene)->void:    
#    pass

func _ready():
    OK
    pass
