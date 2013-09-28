float arrived(){
  float arrived = 0;
  if(coords != null){
    for(int i = 0; i < coords.size(); i++){
      Point coord = (Point) coords.get(i);
      if(coord.arrived == true){
        arrived++;
      }
    }
    return (arrived/coords.size())*100;
  }
  else{
    return 0;
  }
}

void checkSeekerCount(int count){
  if(count > 1) {
    if(seekers.size() < count) {
      for(int y = 0; y < 15; y++){
        newSeeker(random(width),random(height));
      }
    }
    else if(seekers.size() > count){
      for(int z = 0; z < (seekers.size() - count); z++){
        seekers.remove(seekers.size()-1);
      }
    }
  }
}

void newSeeker(float x, float y) {
  float maxspeed = random(15,20);
  float maxforce = random(0.5, 0.6);
  seekers.add(new Boid(new PVector(x,y),maxspeed,maxforce));
}

void update(int count, RPoint[] pnts, int baseR){
  for ( int i = 0; i < count; i++ )
  {
    float mx = (pnts[i].x)+width/2;
    float my = (pnts[i].y)+height/2;

    if(newtext){
      coords.add(new Point(mx, my, false));
    }

    if((i < seekers.size()) && (i < coords.size())) {
      Boid seeker = (Boid) seekers.get(i);
      Point coord = (Point) coords.get(i);
      seeker.arrive(new PVector(coord.x,coord.y));
      seeker.update();
      float r = (seeker.vel.mag()/2)+baseR;

      ellipse(seeker.loc.x, seeker.loc.y, r, r);

      if(((seeker.loc.x > mx-1) && (seeker.loc.x < mx+1)) && ((seeker.loc.y > my-1) && (seeker.loc.y < my+1)) && (coord.arrived == false)){
        coord.arrived = true;
      }
    }
  }
}

void keyPressed (){
  if(auto == false){
    if (  keyCode == DELETE || keyCode == BACKSPACE ){
      if ( inp.length() > 0 ){
        inp = inp.substring(0,inp.length()-1);
      }
    }
    else if (key != CODED){
      inp = inp + key;
    }
  }
}

void mouseReleased(){
  if(auto == true){
    auto = false;
  }
  else{
    auto = true;
    inp = words[currWord];
  }
}








