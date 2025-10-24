#version 300 es
precision mediump float;

in vec2 TexCoords;
out vec4 FragColor;

uniform sampler2D image;
uniform vec3 spriteColor;

void main()
{
    FragColor = vec4(spriteColor, 1.0) * texture(image, TexCoords);
}





// #version 330 core
// in vec2 TexCoords;
// out vec4 color;

// uniform sampler2D image;
// uniform vec3 spriteColor;

// void main()
// {
//     color = vec4(spriteColor, 1.0) * texture(image, TexCoords);
// }
// #version 330 core
// out vec4 color;
// void main() {
//     color = vec4(1.0, 1.0, 0.0, 1.0); // hot pink
// }
