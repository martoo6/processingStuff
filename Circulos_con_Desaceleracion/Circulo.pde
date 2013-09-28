public class Circulo extends Forma{
  int cantCirculos=1;
  float xTarget=(int)random(width);
  float yTarget=(int)random(height);
  float zTarget=(int)random(width);
  float xDir;
  float yDir;
  float zDir;
  float speedX;
  float speedY;
  float speedZ;  
  Circulo(int x, int y){
    xPos=x;
    yPos=y;
    this.setDir();
  }
  Circulo(int x, int y, int tam){
    xPos=x;
    yPos=y;
    tamForma=tam;
    this.setDir();
  }
  Circulo(int x, int y, int tam, int cantC){
    xPos=x;
    yPos=y;
    tamForma=tam;
    cantCirculos=cantC;
    this.setDir();
  }
  void setDir(){
    if(this.xTarget-this.xPos>0){
      this.xDir =1;
    }else{
      this.xDir =-1;
    }
    if(this.yTarget-this.yPos>0){
      this.yDir =1;
    }else{
      this.yDir =-1;
    }
  }
  void setDir3D(){
    speedX=abs(this.xTarget-this.xPos)/15;
    speedY=abs(this.yTarget-this.yPos)/15;
    speedZ=abs(this.zTarget-this.zPos)/15;
    if(this.xTarget-this.xPos>0){
      this.xDir =1;
    }else{
      this.xDir =-1;
    }
    if(this.yTarget-this.yPos>0){
      this.yDir =1;
    }else{
      this.yDir =-1;
    }
    if(this.zTarget-this.zPos>0){
      this.zDir =1;
    }else{
      this.zDir =-1;
    }
  }
  void updatePos2D(){
    speedX=abs(xTarget-xPos)/10;
    speedY=abs(yTarget-yPos)/10;
    xPos+=xDir*speedX;
    yPos+=yDir*speedY;
    this.setDir();
    if((abs(xTarget-xPos)<10)&(abs(yTarget-yPos)<10)){
      xTarget=random(width);
      yTarget=random(height);
    }
  }
  void display(){
    stroke(255);
    noFill();
    pushMatrix();
    translate(xPos,yPos);
      for(float i=1;i<tamForma;i+=(tamForma*0.1)){
        ellipse(0,0,i, i);
      }
    popMatrix();
  }
}
