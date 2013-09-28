/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4573*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
float i,r,a,t;

void setup(){
  size(800,400,P3D);
  background(0);
}

void draw(){
  stroke(-1);
  tint(#f5faff);
  image(g,.5,.5);
  for(i=0;i<1E4;i++){
    r=abs(noise(i)-.2)*mouseX;
    a=noise(i%64)*9+t/r;
    point(400+cos(a)*r,200+sin(a)*r/2);
  }
  t++;
}
