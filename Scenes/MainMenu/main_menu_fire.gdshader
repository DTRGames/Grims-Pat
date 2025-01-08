shader_type canvas_item;

uniform float Yoffset = 0.5;
uniform float animaiton_speed = 0.5;
uniform sampler2D noise_tex: hint_default_black, repeat_enable;
uniform vec4 flame_color : source_color = vec4(1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = vec2(UV.x, UV.y + TIME * animaiton_speed);
	vec4 noise_color = texture(noise_tex, uv);
	vec4 final_color = noise_color;
	final_color.rgb += vec3(UV.y - Yoffset);
	final_color.rgb = step(final_color.rgb, vec3(0.5));
	final_color.rgb = vec3(1.0) - final_color.rgb;

	final_color.a = final_color.r;
	final_color.rgb = flame_color.rgb;

	COLOR = final_color;

	// Called for every pixel the material is visible on.
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
