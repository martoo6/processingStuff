final int radius = 100;
final int CANTPOINTS =10;
PVector[] cPoint = new PVector[CANTPOINTS];
PVector[] tcPoint = new PVector[CANTPOINTS];

void setup(){
  size(800,600);
  smooth();
  for(int i=0;i<CANTPOINTS;i++){
    final float val =random(0,TWO_PI);
    if(i%2==0){
      cPoint[i] =  new PVector((width/2)+cos(val)*radius,(height/2)+sin(val)*radius);
    }else{
      cPoint[i] =  new PVector((width/2)+cos(val)*random(radius/2, radius),(height/2)+sin(val)*random(radius/2, radius));
      final float val2 =random(0,TWO_PI);
      tcPoint[i] =  new PVector((width/2)+cos(val2)*random(radius/2, radius),(height/2)+sin(val2)*random(radius/2, radius));
    }
  }
}

void draw(){
  background(0);
  update();
  beginShape(TRIANGLES);
  for(int i=0;i<CANTPOINTS;i++){
    vertex(cPoint[i].x, cPoint[i].y);
  }
  endShape();
}


void update(){
  for(int i=0;i<CANTPOINTS;i++){
    if(i%2!=0){
      cPoint[i].x+=(tcPoint[i].x-cPoint[i].x)/16;
      cPoint[i].y+=(tcPoint[i].y-cPoint[i].y)/16;
      if( (abs(tcPoint[i].x-cPoint[i].x)<10)&(abs(tcPoint[i].y-cPoint[i].y)<10) ){
        final float val =random(0,TWO_PI);
        tcPoint[i].x=(width/2)+cos(val)*radius;
        tcPoint[i].y=(height/2)+sin(val)*radius;
      }  
    }
  }
}


