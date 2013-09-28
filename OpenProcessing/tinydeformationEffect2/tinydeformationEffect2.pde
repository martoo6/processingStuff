/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/4288*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int w=100,j,i,p,z;
float x,y,d,a;

void draw(){
p++;
for(j=-1;j<w;y=-1+2.0*j++/w)
for(i=-1;i<w;x=-1.0+2.0*i++/w,d=sqrt(x*x+y*y),z=int(w*cos(a=atan2(y,x))/d+p)^int(w*sin(a)/d+p))set(i,j,color(d,z&w,z&w));}
