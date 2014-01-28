#define PROCESSING_COLOR_SHADER

uniform float time;

void main() {
  	hslToRgb(100 +(tan(gl_FragCoord.y*0.02)*cos(gl_FragCoord.x*0.2)*50+tan(gl_FragCoord.x*0.02)*cos(gl_FragCoord.y*0.2)*50)*cos(time*0.1), 255.0, 255.0);
}


void hue2rgb(in float p,float q,in float t,out float ret){
            if(t < 0) t += 1;
            if(t > 1) t -= 1;
            if(t < 1/6) {
            	ret = p + (q - p) * 6 * t;
            }else{
            	if(t < 1/2) {
            		ret = q;
            	}else{
            		if(t < 2/3){
            			ret = p + (q - p) * (2/3 - t) * 6;
            		}else{
            			ret = p;
            		}
            	}
            }
}

void hslToRgb(in float h,in float s,in float l){
    if(s == 0) {
    	 gl_FragColor = vec4(1,1,1,1);
    }else{
    	float q = l < 0.5 ? l * (1 + s) : l + s - l * s;
    	float p = 2 * l - q;

    	hue2rgb(p, q, h + 1/3,  gl_FragColor.r);
    	hue2rgb(p, q, h,  gl_FragColor.g);
    	hue2rgb(p, q, h - 1/3,  gl_FragColor.b);
    }
}