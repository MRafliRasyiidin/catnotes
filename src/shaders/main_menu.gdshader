shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float blur_radius : hint_range(0.0, 50.0, 0.5) = 12.0;
uniform int samples : hint_range(3, 15) = 8;

void fragment() {
    vec2 tex_size = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 pixel_size = 1.0 / tex_size;
    vec4 color = vec4(0.0);
    float total = 0.0;

    float step_size = (blur_radius * 2.0) / float(samples);

    for (float x = -blur_radius; x <= blur_radius; x += step_size) {
        for (float y = -blur_radius; y <= blur_radius; y += step_size) {
            float dist = length(vec2(x, y)) / blur_radius;
            float weight = exp(-dist * dist * 2.0);
            color += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(x, y) * pixel_size) * weight;
            total += weight;
        }
    }

    color /= total;
    COLOR = color;
}