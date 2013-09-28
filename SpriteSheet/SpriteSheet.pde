import controlP5.*;

ControlP5 cp5;

Character mainCharacter;
ArrayList<Dibujable> otherDibujables=new ArrayList<Dibujable>();
String []nombres={"pickachu", "Mariposa"};
CharacterBehaviour []characterBehaviours={new Follower(), new Shy(), new Wild()};
int codeQuality=50;
PImage fondo = loadImage("/home/martin/sketchbook/SpriteSheet/data/fondo.png");

void setup() {
  size(970, 620);
  background(0);
  textSize(20);
  cp5 = new ControlP5(this);
  cp5.addFrameRate().setInterval(10).setPosition(width-30,height - 10);
  
  cp5.addBang("Crear_Pokemon")
       .setPosition(width-80, 30)
       .setSize(50, 50)
       .setId(0)
       ;
       
  cp5.addSlider("codeQuality")
     .setPosition(width-80,100)
     .setSize(50,150)
     .setRange(0,100)
     ;
  
  loadCharacters();
  loadObjects();
}

void draw() {
  background(0);
  image(fondo,0,0);
  for(int i=0;i<otherDibujables.size();i++){
    otherDibujables.get(i).display();
  }
  mainCharacter.display();
}

void loadCharacters(){
  //mainCharacter= new Character("May", 3, ".png", 230);
  mainCharacter= new Character("Brendan", 3, ".png", 230);
  
  Character tmpCharacter=new Character("pickachu", 3, ".png", 230);
  tmpCharacter.behaviour=new Follower();
  otherDibujables.add(tmpCharacter);
  mainCharacter.addObserver(tmpCharacter);
  
  tmpCharacter=new Character("Mariposa", 3, ".png", 230);
  tmpCharacter.behaviour=new Shy();
  otherDibujables.add(tmpCharacter);
  mainCharacter.addObserver(tmpCharacter);
  
}

void loadObjects(){
  Computer tmpComputer = new Computer();
  otherDibujables.add(tmpComputer);
  mainCharacter.addObserver(tmpComputer);
  
  Computer tmpLaptop = new Laptop();
  otherDibujables.add(tmpLaptop);
  mainCharacter.addObserver(tmpLaptop);
}

public void Crear_Pokemon() {
  Character tmpCharacter=new Character(nombres[(int)random(0,nombres.length)], 3, ".png", 230);
  tmpCharacter.behaviour=characterBehaviours[(int)random(0,characterBehaviours.length)];
  otherDibujables.add(tmpCharacter);
  mainCharacter.addObserver(tmpCharacter);
}

void keyPressed() {
  switch(key){
    case 'w':
      mainCharacter.move(0,-4);
      break;
    case 's':
      mainCharacter.move(0,4);
      break;
    case 'a':
      mainCharacter.move(-4,0);
      break;
    case 'd':
      mainCharacter.move(4,0);
      break;
    case 'C':
    case 'c':
      mainCharacter.codea(codeQuality);
      break;
  }
}
