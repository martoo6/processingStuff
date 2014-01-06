// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2012
// PBox2D example

// A rectangular box
class Ship {

  // We need to keep track of a Body and a width and height
  Body body;
  float r;

  // Constructor
  Ship(float x, float y) {
    r = random(8,16);
    // Add the box to the box2d world
    makeBody(new Vec2(x,y),r,r);
    attract(random(width),random(height));
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);  
    // Is it off the bottom of the screen?
    if (pos.y > height+r) {
      killBody();
      return true;
    }
    return false;
  }

  void attract(float x,float y) {
    // From BoxWrap2D example
    Vec2 worldTarget = box2d.coordPixelsToWorld(x,y);   
    Vec2 bodyVec = body.getWorldCenter();
    // First find the vector going from this body to the specified point
    worldTarget.subLocal(bodyVec);
    // Then, scale the vector to the specified force
    worldTarget.normalize();
    worldTarget.mulLocal((float) 1000);
    // Now apply it to the body's center of mass.
    body.applyForce(worldTarget, bodyVec);
  }


  // Drawing the box
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    //rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    ellipse(0,0,r,r);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon (this is what we use for a rectangle)
    PolygonShape sd = new PolygonShape();
   
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 0.1;
    fd.friction = 1.3;
    fd.restitution = 0;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }
}

