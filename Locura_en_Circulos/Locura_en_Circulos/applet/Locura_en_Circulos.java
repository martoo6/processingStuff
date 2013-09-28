import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Locura_en_Circulos extends PApplet {

int maxcircles =200;
Circle[] circulos = new Circle[maxcircles];

public void setup(){
  size(800,600);
  for(int i=0;i<maxcircles;i++){
    int rX = (int)random(width);  
    int rS = (int)random(10);
    circulos[i]=new Circle(rX,height,rS);
  }
}
public void draw(){
  for(int i=0;i<maxcircles;i++){
    circulos[i].display();
    circulos[i].update();
  }
}

class Circle{
  float x, y, speed;
  Circle(float xpos, float ypos, float s){
    x=xpos;
    y=ypos;
    speed=s;
    
  }
  public void update(){
    y-=speed;
    x=x+(int)sin(speed);
    if(y==0){
      y=height;
    }
  }
  public void display(){
    strokeWeight(1);
    stroke(0);
    pushMatrix();
    translate(x, y);
    ellipse(0, 0, 40, 40);
    popMatrix();
  }
}


public void mousePressed()
{
  setup();
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#DFDFDF", "Locura_en_Circulos" });
  }
}
