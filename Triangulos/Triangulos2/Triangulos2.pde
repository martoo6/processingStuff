int i,e;
color paleta [][]={{#070E2B,#0665B9,#80B4E6,#F3C9A3,#F5DD9F},
                   {#BF7D75,#EAF3C6,#68AB8F,#3D8E87,#727D8E},
                   {#6A314F,#AC1E69,#E53491,#F3158A,#FC0487},
                   {#12354B,#0577AB,#EEE9E3,#EEBF35,#C42329}
                  };
int tamanio =20;

void setup(){
  size(1024,768);
  background(0,0,0);
  smooth();
  noStroke();
  int i,e;
  frameRate(5);

}

void draw(){
  int i,e;
  int paleta1 = int(random(3));
  int paleta2 = int(random(3));
  
  for(i=0;i<width+tamanio*2;i+=tamanio*2){
    for(e=0;e<height+tamanio*2;e+=tamanio*2){
      fill(paleta[paleta1][int(random(4))]);
      //triangle(i,e,i+tamanio,e+tamanio,i,e+tamanio*2);
      //triangle(i+tamanio*2,e+tamanio*2,i+tamanio*2,e,i+tamanio,e+tamanio);
      triangle(i,e,i-tamanio,e+tamanio,i,e+tamanio*2);
      triangle(i,e,i+tamanio,e+tamanio,i,e+tamanio*2);
      //Segunda Linea
      i-=tamanio;
      e-=tamanio;
      fill(paleta[paleta2][int(random(4))]);
      triangle(i,e,i-tamanio,e+tamanio,i,e+tamanio*2);
      triangle(i,e,i+tamanio,e+tamanio,i,e+tamanio*2);
      //triangle(i,e,i+tamanio,e+tamanio,i,e+tamanio*2);
      //triangle(i+tamanio*2,e+tamanio*2,i+tamanio*2,e,i+tamanio,e+tamanio);
      i+=tamanio;
      e+=tamanio;
    }
    
  }
    //i = i+tamanio*2;
    //saveFrame("Triangulos-####.tif");
}


void keyPressed() {
  if(key=='a'){
    tamanio +=10;
  }
  if(key=='s'){
    tamanio -=10;
    if (tamanio <0){
      tamanio = 10;
    }
  }
}
