import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

ArrayList<Figure> figures = new ArrayList<Figure>();
ArrayList<ArrayList<Integer>> colors = new ArrayList<ArrayList<Integer>>();
ArrayList <Integer> currentPalette;

void setup(){
  size(800,600);
  Ani.init(this);
  noStroke();
  
  ArrayList<Integer> palette = new ArrayList<Integer>();
  palette.add(color(0,134,252));
  palette.add(color(211,157,249));
  palette.add(color(180,238,249));
  palette.add(color(170,50,252));
  palette.add(color(50,157,252));
  colors.add(palette);
  
  palette = new ArrayList<Integer>();
  palette.add(color(236,217,172));
  palette.add(color(226,149,131));
  palette.add(color(165,102,114));
  palette.add(color(126,63,119));
  palette.add(color(73,27,85));
  colors.add(palette);
  
  palette = new ArrayList<Integer>();
  palette.add(color(118,163,29));
  palette.add(color(253,255,250));
  palette.add(color(250,217,203));
  palette.add(color(238,167,136));
  palette.add(color(128,168,187));
  colors.add(palette);
  
  palette = new ArrayList<Integer>();
  palette.add(color(236,199,160));
  palette.add(color(93,199,138));
  palette.add(color(252,98,66));
  palette.add(color(182,57,92));
  palette.add(color(62,153,120));
  colors.add(palette);
  
  palette = new ArrayList<Integer>();
  palette.add(color(255,153,102));
  palette.add(color(242,128,102));
  palette.add(color(230,102,102));
  palette.add(color(217,77,102));
  palette.add(color(204,51,102));
  colors.add(palette);
  
  /*palette = new ArrayList<Integer>();
  palette.add(color());
  palette.add(color());
  palette.add(color());
  palette.add(color());
  colors.add(palette);
  */
  
  currentPalette = colors.get(int(random(colors.size()-1)));
  
  for(int i=0;i<100;i++){
    figures.add(new Figure());
  }
}

void draw(){
  background(0);
  for (int i = figures.size()-1; i >= 0; i--) {
    figures.get(i).render();
  }
}

class Figure{
  color mainColor;
  PVector pos;
  Ani animation;
  
  Figure(){
    mainColor = currentPalette.get(int(random(currentPalette.size()-1))).intValue();
    pos = new PVector(random(width),random(height));
    animation = new Ani(pos, random(1,2), "y", random(height), Ani.SINE_IN_OUT);
    animation.setPlayMode(Ani.YOYO);
    animation.repeat();
  }
    
  void render(){
    pushMatrix();
    translate(pos.x,pos.y);
    fill(lerpColor(mainColor,color(0),0.5));
    stroke(lerpColor(mainColor,color(0),0.5));
    rect(0,20,20,height);
    stroke(lerpColor(mainColor,color(0),0.7));
    fill(lerpColor(mainColor,color(0),0.7));
    rect(20,20,20,height);
    stroke(mainColor);
    fill(mainColor);
    quad(0,20,20,0,40,20,20,40);
    popMatrix();
  }
}
