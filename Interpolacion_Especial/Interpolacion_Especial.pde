PVector init, end;
int cantClick =0;
int cantLines = 100;

void setup(){
  size(800,600);
  background(255);
}

void draw(){
  background(255);
  if(cantClick == 2){
    PVector dist = new PVector();
    dist.x = (end.x-init.x)/cantLines;
    dist.y = (end.y-init.y)/cantLines;
    for(int i=1;i<cantLines;i++){
      line(init.x, init.y+dist.y*i, init.x+dist.x*i,end.y);
    }
  }
}

void mousePressed(){
  switch(cantClick){
  case 0:
    init = new PVector();
    init.x = mouseX;
    init.y = mouseY;
    cantClick = 1;
  break;
  case 1:
    end = new PVector();
    end.x = mouseX;
    end.y = mouseY;
    cantClick = 2;
  break;
  case 2:
    cantClick = 0;
  break;
  }
}
