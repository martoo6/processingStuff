import java.util.Comparator;
import java.util.Collections;

final int CANT_POINTS =300; 

ArrayList<Point> points = new ArrayList<Point>(); 

void setup(){
  size(400,400);
  background(0 );
  for(int i=0;i<CANT_POINTS;i++) points.add(new Point());
  for(Point p:points) p.init();
}

void draw(){
  //for(Point p:points) ellipse(p.closest.get(0).x,p.closest.get(0).y,10,10);
  background(0 );
  for(Point p:points) {
    fill(random(255),random(255),random(255));
    triangle(p.pos.x,p.pos.y,p.closest.get(0).x,p.closest.get(0).y,p.closest.get(1).x,p.closest.get(1).y);
  }
}

class PointComparator implements Comparator<Point>{
  PVector pos;
  
  public PointComparator(PVector pos){
    this.pos = pos;
  }
  
  @Override
  public int compare(Point p1, Point p2) {
        return (int)(PVector.dist(p1.pos, pos)-PVector.dist(p2.pos, pos));
  }
}

class Point{
  PVector pos = new PVector(random(width), random(height));
  public ArrayList<PVector> closest = new ArrayList<PVector>();
    
  void init(){
    ArrayList<Point> tmpPoints = (ArrayList<Point>)points.clone();
    Collections.sort(tmpPoints, new PointComparator(this.pos));
    closest.add(tmpPoints.get(1).pos);
    closest.add(tmpPoints.get(2).pos);
    println("Soy un punto y mi pos es: "+pos);
    for(PVector p:closest) println(p);
  }
}
