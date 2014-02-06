#define PROCESSING_COLOR_SHADER

uniform float time;
uniform float detail;


//Clamps the colors, nice but not working
//From: http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
//vec3 hsv2rgb(vec3 c)
//{
//   vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
//    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
//    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
//}
  
  vec4 hsv_to_rgb(float h, float s, float v, float a)
{
float c = v * s;
h = mod((h * 6.0), 6.0);
float x = c * (1.0 - abs(mod(h, 2.0) - 1.0));
vec4 color;
 
if (0.0 <= h && h < 1.0) {
color = vec4(c, x, 0.0, a);
} else if (1.0 <= h && h < 2.0) {
color = vec4(x, c, 0.0, a);
} else if (2.0 <= h && h < 3.0) {
color = vec4(0.0, c, x, a);
} else if (3.0 <= h && h < 4.0) {
color = vec4(0.0, x, c, a);
} else if (4.0 <= h && h < 5.0) {
color = vec4(x, 0.0, c, a);
} else if (5.0 <= h && h < 6.0) {
color = vec4(c, 0.0, x, a);
} else {
color = vec4(0.0, 0.0, 0.0, a);
}
 
color.rgb += v - c;
 
return color;
}      

void main() {
    float x = gl_FragCoord.x;
    float y = gl_FragCoord.y;
    float val = (tan(y*0.02) * cos(x*0.2)*50.0 + tan(x*0.02) * cos(y*0.2) * 50.0) *(abs(cos(time * 0.01))-0.7);
    //float val = 150+tan(gl_FragCoord.x*gl_FragCoord.y*0.05)*cos(time*0.005);
    //float val = (cos(x*0.05)*cos(y*0.05)-cos(time*0.02))*detail;
  	gl_FragColor = hsv_to_rgb(val, 1.0, 1.0, 1.0);
}


