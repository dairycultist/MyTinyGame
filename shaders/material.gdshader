shader_type spatial;
render_mode unshaded;

uniform sampler2D tex;
uniform float uv_scale = 1.0;

void fragment() {
	
	float lightness = dot(NORMAL, vec3(0, 0.5, 0.3)) * 0.5 + 0.5;
	
	ALBEDO = texture(tex, UV * uv_scale).rgb * lightness;
}