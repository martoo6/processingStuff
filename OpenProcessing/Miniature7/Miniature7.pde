/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/3884*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
int i,j;
void draw(){
smooth();
beginShape();
for(j=0;j<99;j++){
  float a=j*PI/48,r=noise(j%96*.1,i*.003)*10*(9-i%9)*(sin(i*.001)+1);
  curveVertex(150+r*sin(a),150+r*cos(a));
}
endShape();
if(i++%9!=1) draw();
}
