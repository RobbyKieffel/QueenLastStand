shader_type canvas_item;

uniform float speed = 0.0;
//uniform vec4 outline_color : source_color;

//void vertex() {
	//// Called for every vertex the material is visible on.
//}

void fragment() {
	vec2 new_uv = vec2(UV.x + TIME * speed, UV.y);
	COLOR = texture(TEXTURE, new_uv);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
