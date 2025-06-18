shader_type spatial;
render_mode unshaded;

uniform sampler2D tex;
uniform vec4 color : source_color = vec4(1.0);
uniform float uv_scale = 1.0;

void fragment() {

	float lightness = smoothstep(0.0, 0.8, dot(NORMAL, vec3(0, 0.5, 0.3)) * 0.5 + 0.5);

	ALBEDO = texture(tex, UV * uv_scale).rgb * lightness * color.rgb;
}