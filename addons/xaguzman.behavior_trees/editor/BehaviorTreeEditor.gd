tool
extends GraphEdit

onready var add_item_button := $AddItemButton

func _on_gui_input(event):
    if event is InputEventMouseButton:    
        if event.button_index == BUTTON_RIGHT:
            add_item_button.popup_at(get_global_mouse_position())

func _on_AddItemButton_popup_closed(created_node:GraphNode):
    if not created_node:
        return
        
    add_child(created_node)
    created_node.owner = self
    created_node.offset = get_local_mouse_position() + scroll_offset - (created_node.rect_size / 2)
    created_node.connect("close_request", self, "_on_node_closed", [created_node.name])
    if created_node.has_user_signal("deleted_node"):
        created_node.connect("deleted_node", self, "_composite_node_child_removed", [created_node.name])
    
func _on_BehaviorTreeEditor_connection_request(from, from_slot, to, to_slot):
    connect_node(from, from_slot, to, to_slot)

func _on_BehaviorTreeEditor_disconnection_request(from, from_slot, to, to_slot):
    disconnect_node(from, from_slot, to, to_slot)
    
func _on_BehaviorTreeEditor_connection_to_empty(from, from_slot, release_position):
    add_item_button.popup_at(get_global_mouse_position())
    var created_node = yield(add_item_button, "popup_closed")
    if created_node:
        connect_node(from, from_slot, created_node.name, 0)

func _on_node_closed(node_name: String)->void:
    print ("closing node %s" % node_name)
    for connection in get_connection_list():
        if connection.from == node_name or connection.to == node_name:
            call_deferred( "disconnect_node", connection.from, connection.from_port, connection.to, connection.to_port)
    
    get_node(node_name).queue_free()

func _composite_node_child_removed(index: int, node_path: String)->void:
    var connections_from_node = []
    for conn in get_connection_list():
        if conn.from == node_path and conn.from_slot >= index:
            connections_from_node.append(conn)
            
    
    
    
func _on_BehaviorTreeEditor_connection_from_empty(to, to_slot, release_position):
    add_item_button.popup_at(get_global_mouse_position())
    var created_node = yield(add_item_button, "popup_closed")
    if created_node:
        connect_node(created_node.name, 0, to, to_slot)       


func _on_BehaviorTreeEditor_delete_nodes_request():
    pass # Replace with function body.

func _to_string():
    return get_script().resource_path
