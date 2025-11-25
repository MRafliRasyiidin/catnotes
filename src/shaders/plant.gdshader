shader_type canvas_item;

uniform float amplitude = 5.0;      // how far the top waves (in pixels)
uniform float speed = 2.0;          // animation speed
uniform float bend_start = 0.5;     // normalized height where bending begins (0 = bottom, 1 = top)
uniform float frequency = 3.0;      // number of wave cycles along the height

void vertex() {
    // In Godot UV.y = 0 at the top, 1 at the bottom.
    // Flip it so 0 = bottom, 1 = top (so mask applies to top part)
    float y_norm = 1.0 - UV.y;

    // Mask so only the top area moves
    float mask = smoothstep(bend_start, 1.0, y_norm);

    // Wave motion (time + vertical influence)
    float offset = sin(TIME * speed + UV.y * frequency) * amplitude * mask;

    // Apply lateral displacement only (sway left-right)
    VERTEX.x += offset;
}