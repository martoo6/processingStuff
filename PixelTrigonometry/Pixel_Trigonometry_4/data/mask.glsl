#define PROCESSING_COLOR_SHADER

uniform float time;
uniform int detail;

void hsvToRgb(in float h,in float s,in float v){
float r, g, b;
 
float i = h * 6;
float f = h * 6 - i;
float p = v * (1 - s);
float q = v * (1 - f * s);
float t = v * (1 - (1 - f) * s);
 
switch(mod(i,6)){
    case 0: r = v; g = t; b = p; break;
    case 1: r = q; g = v; b = p; break;
    case 2: r = p; g = v; b = t; break;
    case 3: r = p; g = q; b = v; break;
    case 4: r = t; g = p; b = v; break;
    case 5: r = v; g = p; b = q; break;
}
 
gl_FragColor = vec4(r,g,b,1);
}
        

void main() {
    //float val = 100.0 + (tan(gl_FragCoord.y*0.02) * cos(gl_FragCoord.x*0.2)*50 + tan(gl_FragCoord.x*0.02) * cos(gl_FragCoord.y*0.2) * 50) *cos(time * 0.01);
    //float val = 150+tan(gl_FragCoord.x*gl_FragCoord.y*0.05)*cos(time*0.005);
    precision highp float;
    highp float val = (cos(gl_FragCoord.x*0.005)*cos(gl_FragCoord.y*0.005)-cos(time*0.002))*detail;
  	hsvToRgb(val, 255.0, 255.0);
}


