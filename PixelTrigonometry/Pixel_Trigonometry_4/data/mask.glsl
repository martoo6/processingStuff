#define PROCESSING_COLOR_SHADER

uniform float time;
uniform float detail;

//From: http://lolengine.net/blog/2013/07/27/rgb-to-hsv-in-glsl
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
        

void main() {
    //float val = 100.0 + (tan(gl_FragCoord.y*0.02) * cos(gl_FragCoord.x*0.2)*50.0 + tan(gl_FragCoord.x*0.02) * cos(gl_FragCoord.y*0.2) * 50.0) *cos(time * 0.01);
    //float val = 150+tan(gl_FragCoord.x*gl_FragCoord.y*0.05)*cos(time*0.005);
    float val = (cos(gl_FragCoord.x*0.005)*cos(gl_FragCoord.y*0.005)-cos(time*0.02))*detail;
  	vec3 res = hsv2rgb(vec3(val, 255.0, 255.0));
  	gl_FragColor = vec4(res.r, res.g, res.b, 1.00);
}


