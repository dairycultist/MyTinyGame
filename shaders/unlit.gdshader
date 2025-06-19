shader_type spatial;
render_mode unshaded;

uniform sampler2D tex;
uniform float cutoff : hint_range(0.0, 1.0) = 0.5;

void fragment() {

	vec4 sample = texture(tex, UV);
	
	if (sample.a < cutoff) {
		discard;
	}

	ALBEDO = sample.rgb;
}