RSRC                     VisualShader            ????????                                            @      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports 	   function    script 	   operator    input_name    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    nodes/vertex/0/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        (   local://VisualShaderNodeFloatFunc_hrmtp =      &   local://VisualShaderNodeColorOp_tf0h4 s      $   local://VisualShaderNodeInput_boj86 ?      (   local://VisualShaderNodeFloatFunc_csqbt 	      &   local://VisualShaderNodeFloatOp_wac3n P	      &   local://VisualShaderNodeFloatOp_bjlav ?	         local://VisualShader_u6pjn 
         VisualShaderNodeFloatFunc                       VisualShaderNodeColorOp                                   ??                                      VisualShaderNodeInput             time          VisualShaderNodeFloatFunc                      VisualShaderNodeFloatOp                                      ?A                  VisualShaderNodeFloatOp                                       @                  VisualShader    	      N  shader_type spatial;



void fragment() {
// Input:5
	float n_out5p0 = TIME;


// FloatFunc:3
	float n_out3p0 = sin(n_out5p0);


// FloatOp:10
	float n_in10p1 = 2.50000;
	float n_out10p0 = n_out3p0 * n_in10p1;


// FloatFunc:8
	float n_out8p0 = abs(n_out10p0);


// FloatOp:9
	float n_in9p1 = 25.00000;
	float n_out9p0 = n_out8p0 / n_in9p1;


// ColorOp:4
	vec3 n_in4p0 = vec3(1.00000, 0.00000, 0.00000);
	vec3 n_in4p1 = vec3(0.00000, 0.00000, 0.00000);
	vec3 n_out4p0 = vec3(1.0) - (vec3(1.0) - n_in4p0) * (vec3(1.0) - n_in4p1);


// Output:0
	ALPHA = n_out9p0;
	EMISSION = n_out4p0;


}
 
   
   ???Ñ???#             $   
     W?  ??%            &   
     ??  4C'            (   
     ??  ??)            *   
     ??  ??+            ,   
     ?A  ?-            .   
     ?  ??/                               	                     
              	                     
             RSRC