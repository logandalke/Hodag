RSRC                     VisualShader            ????????                                            3      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports 	   operator    script 	   function    input_name    op_type    code    graph_offset    mode    modes/blend    flags/skip_vertex_transform    flags/unshaded    flags/light_only    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        &   local://VisualShaderNodeColorOp_1incy       (   local://VisualShaderNodeColorFunc_adtlo j      $   local://VisualShaderNodeInput_ket8h ?      "   local://VisualShaderNodeMix_w7i7t ?      (   local://VisualShaderNodeFloatFunc_n28bb ?      &   local://VisualShaderNodeFloatOp_t7kd8 u      &   local://VisualShaderNodeFloatOp_hoyxh ?         local://VisualShader_06fl1 5	         VisualShaderNodeColorOp                          ?                                      VisualShaderNodeColorFunc             VisualShaderNodeInput             time          VisualShaderNodeMix                    
                 
     ??  ??             	                  VisualShaderNodeFloatFunc                       VisualShaderNodeFloatOp                                       @                  VisualShaderNodeFloatOp                                       @                  VisualShader    
      2  shader_type canvas_item;



void fragment() {
// ColorOp:2
	vec3 n_in2p0 = vec3(0.50000, 0.00000, 0.00000);
	vec3 n_in2p1 = vec3(0.00000, 0.00000, 0.00000);
	vec3 n_out2p0 = vec3(1.0) - (vec3(1.0) - n_in2p0) * (vec3(1.0) - n_in2p1);


	vec3 n_out3p0;
// ColorFunc:3
	vec3 n_in3p0 = vec3(0.00000, 0.00000, 0.00000);
	{
		vec3 c = n_in3p0;
		float max1 = max(c.r, c.g);
		float max2 = max(max1, c.b);
		n_out3p0 = vec3(max2, max2, max2);
	}


// Input:4
	float n_out4p0 = TIME;


// FloatOp:7
	float n_in7p1 = 2.00000;
	float n_out7p0 = n_out4p0 * n_in7p1;


// FloatFunc:6
	float n_out6p0 = sin(n_out7p0);


// FloatOp:8
	float n_in8p1 = 2.00000;
	float n_out8p0 = n_out6p0 / n_in8p1;


// Mix:5
	vec2 n_out5p0 = mix(vec2(n_out2p0.xy), vec2(n_out3p0.xy), n_out8p0);


// Output:0
	COLOR.rgb = vec3(n_out5p0, 0.0);


}
    
   d{J?1(?                      
    ??D  ?B                
     ??  ??               
     ?   B               
     z?  ?C               
     MD  ?               
     pB  pC               
     ??  ?C             !   
     ?C  ?C"                                                                                                                 RSRC