#version 330 core
layout (location = 0) in vec4 vertex; // <vec2 position, vec2 texCoords>

out vec2 TexCoords;

uniform mat4 model;
uniform mat4 projection;

void main()
{
    TexCoords = vertex.zw;
    // gl_Position = projection * model * vec4(vertex.xy, 0.0, 1.0);
    // gl_Position = projection * vec4(vertex.xy, 0.0, 1.0);
    gl_Position = vec4(vertex.xy, 0.0, 1.0);
}


// #version 330 core
// layout(location = 0) in vec4 vertex;

// void main() {
//     // Map 0..1 quad coordinates to normalized device coordinates (-1..1)
//     gl_Position = vec4(vertex.xy * 2.0 - 1.0, 0.0, 1.0);
// }

// #version 330 core
// layout(location = 0) in vec4 vertex;
// uniform mat4 projection;

// void main() {
//     // Apply only projection
//     gl_Position = projection * vec4(vertex.xy, 0.0, 1.0);
// }

