shader_type canvas_item;

uniform vec2 direction = vec2(1.0, 0.0);
uniform float speed_scale = 0.02;
uniform float elapsed_time = 0.0; // controlled by GDScript

void fragment() {
    vec2 move = direction * elapsed_time * speed_scale;
    COLOR = texture(TEXTURE, UV + move);
}
