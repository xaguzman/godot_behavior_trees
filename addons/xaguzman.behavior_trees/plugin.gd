tool
extends EditorPlugin

#const BTScript = preload("res://addons/xaguzman.behavior_trees/core/behavior-tree.gd")
const BTIcon = preload("res://addons/xaguzman.behavior_trees/editor/icons/icon_tree.png")
const BehaviorTreeNode = preload("res://addons/xaguzman.behavior_trees/core/behavior-tree.gd")
const BehaviorTreeEditor = preload("res://addons/xaguzman.behavior_trees/editor/BehaviorTreeEditor.gd")

var tool_button : ToolButton
var behavior_editor_container : Control

var _selected_tree : BehaviorTreeNode

func get_plugin_name():
    return "Easy Behavior Trees"
    
func _enter_tree():
    behavior_editor_container = Control.new()
    behavior_editor_container.rect_min_size = Vector2(0, 250)
    behavior_editor_container.anchor_right = 1
    behavior_editor_container.anchor_bottom = 1
    tool_button = add_control_to_bottom_panel(behavior_editor_container, "Behavior")
    tool_button.hide()
        
    add_custom_type("BehaviorTree", "Node", BehaviorTreeNode, BTIcon)
       
func _exit_tree():
    remove_custom_type("BehaviorTree");

func handles(object):
    return object is BehaviorTreeNode

func edit(object: Object):
    if object == _selected_tree:
        return
    
    if behavior_editor_container.get_child_count() > 0:
        print_debug("behavior_editor_container children count = %s " % str(behavior_editor_container.get_child_count()))
        var current_editor = behavior_editor_container.get_child(0)
        
        print_debug("packing %s " % _selected_tree.name)
        print_debug("with editor %s, %s " % [current_editor.name, str(typeof(current_editor))])
        var pack_result = _selected_tree.editor.pack(current_editor)
        
        ResourceSaver.save("res://addons/xaguzman.behavior_trees/%s.tscn" % _selected_tree.name, _selected_tree.editor)
        print_debug("packing result %s" % pack_result)
        
        behavior_editor_container.remove_child(current_editor)
        current_editor.queue_free()    
    
    if not object:
        return
    
    var bt = object as BehaviorTreeNode    
    
    behavior_editor_container.add_child(bt.editor_node)   
    _selected_tree = bt
    behavior_editor_container.update()

#func get_state():
#    return { "visible": behavior_editor_container.visible }
#
#func set_state(state):
#    behavior_editor_container.visible = state.visible

#func apply_changes():
#    var current_editor = behavior_editor_container.get_child(0) as BehaviorTreeEditor
#    print("packing editor for " % current_editor.name )
#    _selected_tree.editor.pack(current_editor)


func make_visible(visible):
    if visible:
        tool_button.show()
        if tool_button.is_pressed():
            make_bottom_panel_item_visible(behavior_editor_container)
    else:
#        edit(null)
        tool_button.hide()
        behavior_editor_container.hide()
