shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Max range extended — go wild
uniform float blur_radius : hint_range(0.0, 50.0, 0.5) = 12.0;

void fragment() {
    vec2 tex_size = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 pixel_size = 1.0 / tex_size;

    vec4 color = vec4(0.0);
    float total = 0.0;

    // Stronger, smoother Gaussian-like weighting
    for (float x = -blur_radius; x <= blur_radius; x++) {
        for (float y = -blur_radius; y <= blur_radius; y++) {
            float dist = length(vec2(x, y)) / blur_radius;
            float weight = exp(-dist * dist * 2.0); // Gaussian falloff
            color += texture(SCREEN_TEXTURE, SCREEN_UV + vec2(x, y) * pixel_size) * weight;
            total += weight;
        }
    }

    color /= total;
    COLOR = color;
}
