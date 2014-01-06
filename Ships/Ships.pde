import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
PBox2D box2d;

ArrayList<Ship> lstShip = new ArrayList<Ship>(); 
ArrayList<PVector> lstAttractor = new ArrayList<PVector>();

void setup() {
  size(800,600);
  smooth();

  // Initialize box2d physics and create the world
  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.setGravity(0,0);
  
  for(int i=0;i<1;i++) lstShip.add(new Ship(random(width), random(height)));
  lstAttractor.add(new PVector(width/2, height/2));
}

void draw() {
  //background(255);

  // We must always step through time!
  box2d.step();
  for(PVector a:lstAttractor){
    fill(0);
    stroke(0);
    ellipse(a.x,a.y,10,10);
    for (Ship s: lstShip) s.attract(a.x, a.y);
  }
  for (Ship s: lstShip) s.display();
}
