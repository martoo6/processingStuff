//Never ends, don't know why...

PVector particles[] = new PVector[5000];  
Attractor attractors[] = new Attractor[15];

void setup(){
  size(800,600);
  background(0);
  for(int i=0;i<particles.length;i++) particles[i]= new PVector(random(width), random(height)); 
  for(int e=0;e<attractors.length;e++) attractors[e]= new Attractor();
}

void draw(){
  background(0 );
  stroke(255);
  //stroke(255,10);
  for(int i=0;i<particles.length;i++){
    for(int e=0;e<attractors.length;e++) {
      PVector heading = PVector.sub(attractors[e].pos,particles[i]);
      float dist =heading.mag();
      heading.normalize();
      heading.div(dist);
      heading.mult(attractors[e].strenght*100);
      //distance*=distance; 
      particles[i].add(heading);
    }
    
    point(particles[i].x, particles[i].y); 
  } 
 //Debuging purposes only 
  //for(int e=0;e<attractors.length;e++) ellipse(attractors[e].pos.x,attractors[e].pos.y, attractors[e].strenght*100, attractors[e].strenght*100);
}

class Attractor{
  PVector pos = new PVector(random(width), random(height));
  float strenght = random(1);
}
