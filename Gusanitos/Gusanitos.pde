import java.util.*;

int CANTPOINTS = 10;
ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Triangulo> triangulos = new ArrayList<Triangulo>();

public class pointComparator implements Comparator<Point>{
     public int compare(Point p1, Point p2) {
        return (p1.dist>p2.dist ? -1 : (p1.dist==p2.dist ? 0 : 1));
    }
} 

void setup(){
  size(800,700);
  for(int i=0;i<CANTPOINTS;i++) points.add(new Point());
  stroke(255);
}

void draw(){
  background(0);
  triangulos.clear();
  for(int i=0;i<points.size();i++){
    Point point = points.get(i);
    PVector dir = PVector.fromAngle(noise(point.pos.x*0.01, point.pos.y*0.01)*360);
    dir.mult(0.5);
    point.pos.x+=dir.x;
    point.pos.y+=dir.y;
    ellipse(point.pos.x, point.pos.y, 10, 10);
    point.setClosestPoints();
  }
  for(Triangulo t:triangulos) t.render(); 
}

class Point{
  public PVector pos = new PVector(random(width), random(height));;
  ArrayList<Point> closestPoints = new ArrayList<Point>();
  float dist;
  
  void setClosestPoints(){
    closestPoints.clear();
    for(int i=0;i<points.size();i++){
      Point point = points.get(i);
      point.dist = pos.dist(point.pos);
      closestPoints.add(point);
      Collections.sort(closestPoints, new pointComparator());
    }
    triangulos.add(new Triangulo(closestPoints.get(0).pos,closestPoints.get(1).pos,closestPoints.get(2).pos));
  }
}

class Triangulo{
  Point[] p = new Point[3];
  Triangulo(Point p0, Point p1, Point p2){
    p[0] = p0;
    p[1] = p1;
    p[2] = p2;
  }
  void render(){
    fill(100);
    triangle(p[0].pos.x, p[0].pos.y, p[1].pos.x, p[1].pos.y, p[2].pos.x, p[2].pos.y);
  }
}
