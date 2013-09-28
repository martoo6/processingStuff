int numsCalc=0;
int [][]matriz= new int [8][8];
int [][]mov=new int[8][2];
int [][]pos= new int[64][2];

void setup(){
  size(800,700);
  smooth();
  noLoop();
  mov[0][0]=-1;
  mov[0][1]=2;
  
  mov[1][0]=1;
  mov[1][1]=2;
  
  mov[2][0]=-2;
  mov[2][1]=1;
  
  mov[3][0]=2;
  mov[3][1]=1;
  
  mov[4][0]=-2;
  mov[4][1]=-1;
  
  mov[5][0]=2;
  mov[5][1]=-1;
  
  mov[6][0]=-1;
  mov[6][1]=-2;
  
  mov[7][0]=1;
  mov[7][1]=-2;
  
  calculo(0,0);
}

void draw(){
  background(0);
  noFill();
  stroke(150,0,150);
  translate(width/3,height/3);
  
  beginShape();
  for(int i=0;i<64;i++){
    vertex(pos[i][0]*40+5,pos[i][1]*40-5);
  }
  endShape();
  
  
  for(int i=0;i<8;i++){
    for(int e=0;e<8;e++){
      noFill();
      rect(e*40-20,i*40-20,40,40);
      fill(255,255,0);
      text(matriz[e][i],e*40,i*40);
    }
  }
}


boolean calculo(int x, int y){
  pos[numsCalc][0]=x;
  pos[numsCalc][1]=y;
  numsCalc++;
  matriz[x][y]=numsCalc;
  
  if(numsCalc==64){
    return true;
  }
  for(int i=0;i<8;i++){
    if(movValido(x+mov[i][0],y+mov[i][1])){
      if(calculo(x+mov[i][0],y+mov[i][1])){
        return true;
      }
    }
  }
  matriz[x][y]=0;
  numsCalc--;
  pos[numsCalc][0]=0;
  pos[numsCalc][1]=0;
  return false;
  
}

boolean movValido(int x, int y){
  if((x>7)||(y>7)||(x<0)||(y<0)||matriz[x][y]!=0){
    return false;
  }
  return true;
}
