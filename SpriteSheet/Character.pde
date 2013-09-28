class Character implements Observer, Dibujable{
  Animation []animation = new Animation[4];;
  Animation currentAnimation;
  //PVector currentPos=new PVector((width/2)+random(-width/3,width/3),(height/2)+random(-height/3,height/3));
  PVector currentPos=new PVector(random(100,700), random(150,450));
  PVector lastMov=new PVector();
  ArrayList<Observer> observers = new ArrayList<Observer>();
  CharacterBehaviour behaviour;
  boolean rightCode=false;
  
  Character(Animation animation[]){
    this.animation = animation;
    currentAnimation=animation[1];
  }
  
  Character(String fileName,int cantImages, String extension,int speed){
    animation[0] = new Animation(fileName+"UP", cantImages, extension, speed);
    animation[1] = new Animation(fileName+"DOWN", cantImages, extension, speed);
    animation[2] = new Animation(fileName+"LEFT", cantImages, extension, speed);
    animation[3] = new Animation(fileName+"RIGHT", cantImages, extension, speed);
    currentAnimation=animation[1];
  }
  
  void move(float xMov,float yMov){
    currentPos.x+=xMov;
    currentPos.y+=yMov;
    lastMov.x=xMov;
    lastMov.y=yMov;
    if(xMov>0) currentAnimation=animation[3];//RIGHT
    if(yMov>0) currentAnimation=animation[1];//DOWN
    if(xMov<0) currentAnimation=animation[2];//LEFT
    if(yMov<0) currentAnimation=animation[0];//UP
    
    //NOTIFICAR A MIS OBSERVADORES
    for(int i=0;i<observers.size();i++){
      observers.get(i).hasMoved(this);
    }
  }
  
  void codea(int codeQuality){
    if(random(0,codeQuality)>25){
      rightCode=true;
    }else{
      rightCode=false;
    }
    
    //NOTIFICAR A MIS OBSERVADORES
    for(int i=0;i<observers.size();i++){
      observers.get(i).hasCoded(this);
    }
  }
  
  void display(){
    currentAnimation.display(currentPos.x, currentPos.y);
  }
  
  //OBSERVER STUFF
  
  void addObserver(Observer observer){
    observers.add(observer);
  }

  void removeObserver(){
  //  observers.remove()
  }
  
  void hasMoved(Character character){
    behaviour.act(this, character);
  }
  
  void hasCoded(Character character){ 
  }
}
