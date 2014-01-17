import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ComunicationNodes extends PApplet {

ArrayList<Node> allNodesList = new ArrayList<Node>();

public void setup()
{
	size(800,600);
	for(int i=0;i<30;i++) allNodesList.add(new Node( new PVector( random(width), random(height))));
	for(int i=0;i<30;i++) allNodesList.get(i).setNodes();
}


public void draw()
{
	background(0);
	for(int i=0;i<30;i++) allNodesList.get(i).render();
}

class Node
{
	PVector pos;
	float tam = 40;
	ArrayList<Particle> particleList = new ArrayList<Particle>();
	ArrayList<Node> nodeList = new ArrayList<Node>();

	Node(PVector pos){
		this.pos = pos;
		for(int i=0;i<40;i++) particleList.add(new Particle(pos.get()));
	}

	public void setNodes(){
		for(int i=0;i<2;i++) nodeList.add(allNodesList.get((int)random(allNodesList.size())));
		for(int i=0;i<40;i++){
			PVector p = PVector.sub( this.pos, nodeList.get( (int)random(nodeList.size()) ).pos);
			p.normalize();
			particleList.get(i).setDir(p);
		} 
	}

	public void render(){
		fill(63, 128, 235, 50);
		noStroke();
		pushMatrix();
		translate(pos.x, pos.y);
		ellipse(0, 0, tam, tam);
		popMatrix();
		for(Particle p: particleList) p.update();
		for(Particle p: particleList) p.render();
	}
};

class Particle
{
	int tam=5;
	PVector pos;
	PVector dir=new PVector();

	PGraphics gp;
	
	Particle(PVector pos){
		this.pos =pos;
		gp = createGraphics(50, 50);
		gp.beginDraw();
		gp.fill(100, 180, 255);
		gp.noStroke();
		gp.ellipse(gp.width/2, gp.height/2, tam, tam);
		//gp.filter(BLUR,2);
		gp.endDraw();	
	}

	public void setDir(PVector dir){
		this.dir = dir;
	}

	public void update(){
		pos.add(dir);
	}

	public void render(){
		noStroke();
		fill(63, 128, 235);
		pushMatrix();
		translate(pos.x, pos.y);
		image(gp, 0,0);
		popMatrix();
	}
};
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ComunicationNodes" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
