#define PROCESSING_COLOR_SHADER
      

void main() {
  	gl_FragColor.r = gl_FragColor.r/gl_FragColor.g;
}


