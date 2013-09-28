int i,e;
color paleta [][]={{#070E2B,#0665B9,#80B4E6,#F3C9A3,#F5DD9F},
                   {#BF7D75,#EAF3C6,#68AB8F,#3D8E87,#727D8E},
                   {#6A314F,#AC1E69,#E53491,#F3158A,#FC0487},
                   {#12354B,#0577AB,#EEE9E3,#EEBF35,#C42329},                   
                   {#FFFFFF,#000000,#FFFFFF,#000000,#FFFFFF},                   
                   {#070E2B,#BF7D75,#6A314F,#12354B,#FFFFFF},                   
                   {#80B4E6,#68AB8F,#E53491,#EEE9E3,#000000},                   
                   {#F5DD9F,#727D8E,#FC0487,#C42329,#FFFFFF},                   
                   {#0665B9,#EAF3C6,#AC1E69,#0577AB,#000000},                   
                   {#0665B9,#EAF3C6,#AC1E69,#0577AB,#000000}
                  };
                  
int tamanio =20;
int anim =0;
int paletaMode=1;
int boderMode=0;
int opacidadBlanco = 0;
int opacidadNegro = 0;


ArrayList triangulos= new ArrayList();

void setup(){
  //size(displayWidth ,displayHeight);
  size(displayWidth ,displayHeight);
  background(0,0,0);
  smooth();
  noStroke();
  int i,e;
  //frameRate(5);
}

void draw(){
  int i,e;
  int paleta1 = paletaMode;
  int paleta2=int(random(5));
  if(paletaMode==0){
    paleta1 = int(random(9));
  }
  //Animacion 1
  switch(anim) {
    case(0):
    for(i=0;i<width+tamanio;i+=tamanio*2){
      for(e=0;e<height+tamanio;e+=tamanio*random(10)){
        rombo(i,e,int(random(tamanio)),paleta[paleta1][paleta2],#6A314F);
      }
    }
    break;
    case(1):
    //Animacion 2
    for(i=0;i<width+tamanio;i+=tamanio*2){
      for(e=0;e<height+tamanio;e+=tamanio*random(10)){
        rombo(i,e,tamanio,paleta[paleta1][paleta2],#6A314F);
      }
    }
    break;
    case(2):
    //Animacion 3
    for(i=0;i<width+tamanio;i+=tamanio*random(10)){
      for(e=0;e<height+tamanio;e+=tamanio*random(10)){
        rombo(i,e,int(random(tamanio)),paleta[paleta1][paleta2],#6A314F);
      }
    }
    break;
    case(3):
    //Animacion 4
    for(i=0;i<width+tamanio;i+=tamanio*2){
      if(paletaMode==0){
        paleta1 = int(random(9));
        for(e=0;e<height+tamanio;e+=tamanio*2){
          paleta2=int(random(5));
          rombo(i,e,tamanio,paleta[paleta1][paleta2],#6A314F);
        }
        paleta1 = int(random(9));
        for(e=0;e<height+tamanio;e+=tamanio*2){
          paleta2=int(random(5));
          rombo(i+tamanio,e+tamanio,tamanio,paleta[paleta1][paleta2],#6A314F);
        }
      }else{
        for(e=0;e<height+tamanio;e+=tamanio*2){
          paleta2=int(random(5));
          rombo(i,e,tamanio,paleta[paleta1][paleta2],#6A314F);
        }
        for(e=0;e<height+tamanio;e+=tamanio*2){
          paleta2=int(random(5));
          rombo(i+tamanio,e+tamanio,tamanio,paleta[paleta1][paleta2],#6A314F);
        }
      }
      
    }
    break;
  }
  if(opacidadBlanco>=0){
    fill(255,opacidadBlanco);
    noStroke();
    rect(0,0,displayWidth,displayHeight);
    opacidadBlanco-=15;
  }

  if(opacidadNegro>=0){
    fill(0,opacidadNegro);
    noStroke();
    rect(0,0,displayWidth,displayHeight);
    opacidadNegro-=15;
  }
  //saveFrame("Triangulos-####.tif");
}
class triangulo{
  int xPos, yPos, tam, colores, contorno,vel;
  triangulo(int x,int y,int t,color c,color cont, int v){
    xPos = x;
    yPos = y;
    tam= t;
    colores= c;
    contorno= cont;
    vel=v;
  }
  void update(){
    
  }
  boolean termino(){
    return (false);
  }
  //void dibujar(int xPos,int yPos,int tam,color colores,color contorno){
  void dibujar(){
    if(contorno==0){noStroke();}else{stroke(contorno);}
    fill(colores);
    triangle(xPos-tam,yPos,xPos+tam,yPos,xPos,yPos-tam);
  }
}
void trianguloInvertido(int xPos,int yPos,int tam,color colores,color contorno){
  if(contorno==0){noStroke();}else{stroke(contorno);}
  fill(colores);
  triangle(xPos-tam,yPos,xPos+tam,yPos,xPos,yPos+tam);
}
void rombo(int xPos,int yPos,int tam,color colores,color contorno){
  if(contorno==0){noStroke();}else{stroke(contorno);}
  fill(colores);
  quad(xPos-tam,yPos,xPos,yPos-tam,xPos+tam,yPos,xPos,yPos+tam);
}
void romboRaro(int xPos,int yPos,int tam,color colores,color contorno){
  if(contorno==0){noStroke();}else{stroke(contorno);}
  fill(colores);
  quad(xPos-tam,yPos,xPos+tam,yPos,xPos,yPos-tam,xPos,yPos+tam);
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      tamanio+=2;
    }
    if (keyCode == DOWN) {
      tamanio-=2;
      if(tamanio<8){
        tamanio=8;
      }
    }
    if (keyCode == LEFT) {
      paletaMode-=1;
      if(paletaMode<1){
        paletaMode=1;
      }
    }
    if (keyCode == RIGHT) {
      paletaMode+=1;
      if(paletaMode>9){
        paletaMode=9;
      }
    }
  }
  if(key=='r'){
    paletaMode=0;
  }
  if(key=='1'){
    anim=0;
  }
  if(key=='2'){
    anim=1;
  }
  if(key=='3'){
    anim=2;
  }
  if(key=='4'){
    anim=3;
  }
  if(key=='b'){
    opacidadBlanco=255;
  }
  if(key=='n'){
    opacidadNegro=255;
  }
}
