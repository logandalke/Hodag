RSRC                     VisualShader            ��������                                            $      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports 	   function    script    code    graph_offset    mode    modes/blend    flags/skip_vertex_transform    flags/unshaded    flags/light_only    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        (   local://VisualShaderNodeColorFunc_ev136 f         local://VisualShader_t6lxo �         VisualShaderNodeColorFunc             VisualShader          $  shader_type canvas_item;



void fragment() {
	vec3 n_out2p0;
// ColorFunc:2
	vec3 n_in2p0 = vec3(0.00000, 0.00000, 0.00000);
	{
		vec3 c = n_in2p0;
		float max1 = max(c.r, c.g);
		float max2 = max(max1, c.b);
		n_out2p0 = vec3(max2, max2, max2);
	}


// Output:0
	COLOR.rgb = n_out2p0;


}
    
   $^��^��	                                   
     ��  �B                               RSRC